USER = "some_user"
PASSWORD = "some_password"
DB = "some_db"

POSTGRES_PORT_ID = "postgres"
API_PORT_ID = "http"


def run(plan, args):
    postgres = start_postgres(plan)
    start_api(plan, postgres)


def start_postgres(plan):
    # Start the Postgres server
    postgres = plan.add_service(
        service_name = "postgres",
        config = ServiceConfig(
            image = "postgres",
            ports = {
                POSTGRES_PORT_ID: PortSpec(number = 5432, application_protocol = "postgresql"),
            },
            env_vars = {
                "POSTGRES_USER": USER,
                "POSTGRES_PASSWORD": PASSWORD,
                "POSTGRES_DB": DB,
            }
        )
    )
    return postgres


def start_api(plan, postgres):
    # Add PostgREST
    postgres_url = "postgresql://{}:{}@{}:{}/{}".format(
        USER,
        PASSWORD,
        postgres.hostname,
        postgres.ports[POSTGRES_PORT_ID].number,
        DB,
    )
    api = plan.add_service(
        service_name = "api",
        config = ServiceConfig(
            image = "postgrest/postgrest",
            env_vars = {
                "PGRST_DB_URI": postgres_url,
                "PGRST_DB_ANON_ROLE": USER,
            },
            ports = {
                API_PORT_ID: PortSpec(3000, application_protocol = "http"),
            },
        )
    )
