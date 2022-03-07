
ifneq (,$(wildcard ./.env))
	include .env
	export
endif

ifeq ($(YOUR_IP),)
$(error You must specify YOUR_IP)
endif
ifeq ($(STACK_BUCKET),)
$(error You must specify STACK_BUCKET)
endif
ifeq ($(STACK_NAME),)
$(error You must specify STACK_NAME)
endif
ifeq ($(UI_S3_BUCKET_NAME),)
$(error You must specify UI_S3_BUCKET_NAME)
endif
ifeq ($(DB_NAME),)
$(error You must specify DB_NAME)
endif
ifeq ($(DB_ADMIN_USERNAME),)
$(error You must specify DB_ADMIN_USERNAME)
endif
ifeq ($(DB_ADMIN_PASSWORD),)
$(error You must specify DB_ADMIN_PASSWORD)
endif

see_environment:
	echo YOUR_IP $(YOUR_IP)
	echo STACK_BUCKET $(STACK_BUCKET)
	echo STACK_NAME $(STACK_NAME)
	echo UI_S3_BUCKET_NAME $(UI_S3_BUCKET_NAME)
	echo DB_NAME $(DB_NAME)
	echo DB_ADMIN_USERNAME $(DB_ADMIN_USERNAME)
	echo DB_ADMIN_PASSWORD $(DB_ADMIN_PASSWORD)

.PHONY: local_setup_ui
	cd shop_ui && $(MAKE) install

.PHONY: local_run_ui
local_run_ui:
	cd shop_ui && $(MAKE) run

.PHONY: docker_setup_be
docker_setup_be:
	docker-compose up --build -d database 
	echo "giving 30 secs for the database to be built"
	sleep 30
	docker-compose up -d
	echo "giving 15 secs for the database to be built"
	sleep 15
	docker-compose stop

.PHONY: docker_run_be
docker_run_be:
	echo "Run 'make docker_stop_be' to stop docker"
	docker-compose start

.PHONY: docker_stop_be
docker_stop_be:
	docker-compose stop

.PHONY: docker_logs_be
docker_logs_be:
	echo "Terminate tail with ctrl+c"
	docker logs skydropx_challenge_api_1 -f --tail 10

.PHONY: local_setup_be
local_setup_be:
	pip install -r shop_backend/requirements.txt

.PHONY: local_test_be
local_test_be:
	rm -rf shop_backend/deployment_package
	python -m pytest
	
.PHONY: aws_verify
aws_verify:
	aws cloudformation validate-template --template-body file://template.yaml

.PHONY: aws_clean
aws_clean:
	rm -f template_deploy.yaml

.PHONY: aws_setup_be
aws_setup_be:
	./prepare_deployment_package.sh

.PHONY: aws_deploy_be
aws_deploy_be: aws_setup_be
	aws cloudformation package \
		--template-file template.yaml \
		--output-template template_deploy.yaml \
		--s3-bucket $(STACK_BUCKET)

	aws cloudformation deploy \
		--no-fail-on-empty-changeset \
		--template-file template_deploy.yaml \
		--stack-name $(STACK_NAME) \
		--capabilities CAPABILITY_IAM \
		--parameter-overrides "DatabaseName=$(DB_NAME)" "AdminUserName=$(DB_ADMIN_USERNAME)" "AdminUserPassword=$(DB_ADMIN_PASSWORD)" "YourExternalIp=$(YOUR_IP)"

.PHONY: aws_get_outputs
aws_get_outputs:
	aws cloudformation describe-stacks --stack-name $(STACK_NAME) --query "Stacks[0].Outputs" | cat

.PHONY: aws_deploy_ui
aws_deploy_ui: 
	$(MAKE) aws_get_outputs | grep "ApiUrl" -A 1 | grep OutputValue | sed -e 's/^.\+\s\+\(.\+\)/\1/g' | xargs -I value echo "VUE_APP_BACKEND_HOST=value" > shop_ui/.env.production.local
	cd shop_ui && $(MAKE) build
	aws s3 cp shop_ui/dist/ s3://$(UI_S3_BUCKET_NAME)/ --recursive
	$(MAKE) aws_get_outputs | grep "WebsiteURL" -A 1 | grep OutputValue | sed -e 's/^.\+\s\+\(.\+\)/\1/g' | xargs -I value echo "site available at: value" 

.PHONY: aws_teardown
aws_teardown:
	aws cloudformation delete-stack --stack-name $(STACK_NAME)
	aws_clean
