BASE_FOLDER="shop_backend"
PACKAGE_PATH="${BASE_FOLDER}/deployment_package"

rm -rf ${PACKAGE_PATH}/*
# create root folder
mkdir -p ${PACKAGE_PATH}
# create folder tree
git ls-tree --name-only HEAD ${BASE_FOLDER}/ -d -r | grep -v tests | grep / | cut -d "/" -f 2- |  xargs -I path mkdir -p ${PACKAGE_PATH}/path
# copy files to the package folder with the same tree structure
git ls-tree --name-only HEAD ${BASE_FOLDER}/ -r | grep -vE "/tests/|dockerignore|Dockerfile" | cut -d / -f 2- | xargs -I file_path cp ${BASE_FOLDER}/file_path ${PACKAGE_PATH}/file_path
# paste the dependencies in the package folder
pip install -t ${PACKAGE_PATH} -r ${BASE_FOLDER}/requirements.txt --upgrade
