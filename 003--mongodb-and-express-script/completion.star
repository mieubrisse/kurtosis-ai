USERNAME = "mongo-express"
PASSWORD = "some_password"

MONGO_PORT_ID = "mongodb"

def run(plan, args):
    mongo = start_mongo(plan)
    start_mongo_express(plan, mongo)


def start_mongo(plan):
    # Start the MongoDB server
    mongo = plan.add_service(
        service_name = "mongo",
        config = ServiceConfig(
            image = "mongo",
            ports = {
                MONGO_PORT_ID: PortSpec(number = 27017),
            },
            env_vars = {
                "MONGO_INITDB_ROOT_USERNAME": USERNAME,
                "MONGO_INITDB_ROOT_PASSWORD": PASSWORD,
            }
        )
    )
    return mongo


def start_mongo_express(plan, mongo):
    # Start the Mongo Express server
    mongo_url = "mongodb://{}:{}@{}:{}/".format(
        USERNAME,
        PASSWORD,
        mongo.hostname,
        mongo.ports[MONGO_PORT_ID].number,
    )
    plan.add_service(
        service_name = "mongo-express",
        config = ServiceConfig(
            image = "mongo-express",
            ports = {
                "http": PortSpec(number = 8081),
            },
            env_vars = {
                "ME_CONFIG_MONGODB_ADMINUSERNAME": USERNAME,
                "ME_CONFIG_MONGODB_ADMINPASSWORD": PASSWORD,
                "ME_CONFIG_MONGODB_URL": mongo_url,
            }
        )
    )
