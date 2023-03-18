def run(plan, args):
    start_postgres(plan)

def start_postgres(plan):
    # Start the Postgres server
    plan.add_service(
        service_name = "postgres",
        config = ServiceConfig(
            image = "postgres",
            ports = {
                "postgres": PortSpec(number = 5432, application_protocol = "postgresql"),
            },
            env_vars = {
                "POSTGRES_USER": "some_user",
                "POSTGRES_PASSWORD": "some_password",
            }
        )
    )

    # Wait for it to become available
    plan.wait(
        recipe = ExecRecipe(
            command = ["pg_isready"],
        ),
    )
