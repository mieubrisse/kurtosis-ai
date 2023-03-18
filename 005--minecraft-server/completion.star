# From https://github.com/docker/awesome-compose/tree/master/minecraft
def run(plan, args):
    files = {}
    if args != None and args.data_artifact:
        files["/data"] = args.data_artifact

    plan.add_service(
        service_name = "minecraft-server",
        config = ServiceConfig(
            image = "itzg/minecraft-server",
            ports = {
                "server": PortSpec(number = 25565),
            },
            env_vars = {
                "EULA": "TRUE",
            },
            files = files,
        )
    )
