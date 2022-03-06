from . import main_blueprint


@main_blueprint.after_request
def after_request(response):
    header = response.headers
    header["Access-Control-Allow-Origin"] = "*"
    header["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS, PUT, PATCH, DELETE"
    header["Access-Control-Allow-Headers"] = "Content-Type"
    return response


@main_blueprint.route("/", methods=["GET"])
def shop_backend() -> str:
    return "hola", {"Access-Control-Allow-Origin": "*"}
