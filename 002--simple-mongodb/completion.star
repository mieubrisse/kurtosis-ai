def run(plan, args):
    # Start the MongoDB server
    plan.add_service(
        service_name = "mongodb",
        config = ServiceConfig(
            image = "mongo",
            ports = {
                "mongodb": PortSpec(number = 27017),
            },
            env_vars = {
                "MONGO_INITDB_ROOT_USERNAME": "some_user",
                "MONGO_INITDB_ROOT_PASSWORD": "some_password",
            }
        )
    )

    # Wait for it to become available
    plan.wait(
        recipe = ExecRecipe(
            command = ["pg_isready"],
        ),
    )
