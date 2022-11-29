from pathlib import Path
import logging
from yaml import load, Loader

logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger('terraform_backend_configuration_generator')

TERRAFORM_VARS = "tfvars/backendvars.yml"
BACKEND_FOLDER = "tfbackend"
PROVIDER_BACKEND = "AWS"
ENVIRONMENT = "DEV"

if __name__ == '__main__':

    logger.info("SCRIPT START")

    current_path = Path.cwd()
    path = Path(current_path)
    tfvars_backend_yaml = path.parent.joinpath(TERRAFORM_VARS)

    logger.info('CURRENT DIRECTORY : {}'.format(current_path))
    logger.info('PARENT DIRECTORY : {}'.format(path.parent))
    logger.info('TFVARS FOLDER : {}'.format(tfvars_backend_yaml))
    logger.warning('READING TFVARS FILE TO GENERATE THE BACKEND CONFIG FILE')

    if tfvars_backend_yaml.exists():
        configuration_bootstrap_backend = {}
        configuration_infrastructure_backend = {}
        with open(tfvars_backend_yaml, "r") as backend_yaml:
            backend_configuration = load(stream=backend_yaml, Loader=Loader)

        providers = backend_configuration.get('provider')

        logger.info("LIST OF PROVIDERS CONFIGURATIONS : {}".format(list(providers.keys())))
        logger.info("SELECTING THE PROVIDER : {}".format(PROVIDER_BACKEND.lower()))
        logger.info("SELECTING THE ENVIRONMENT CONFIGURATION : {}".format(ENVIRONMENT.lower()))

        provider = providers[PROVIDER_BACKEND.lower()]
        configuration_bootstrap_backend["region"] = provider["region"]
        configuration_infrastructure_backend["region"] = provider["region"]

        configuration_backend_params = provider["backend"]["environment"][ENVIRONMENT.lower()]
        configuration_bootstrap_backend["bucket"] = configuration_backend_params["s3bucket_bootstrap"]
        configuration_bootstrap_backend["key"] = configuration_backend_params["s3bucket_bootstrap_key"]

        configuration_infrastructure_backend["bucket"] = configuration_backend_params["s3bucket_infrastructure"]
        configuration_infrastructure_backend["key"] = configuration_backend_params["s3bucket_infrastructure_key"]

        logger.info("FETCHED BOOTSTRAP CONFIGURATION : {}".format(configuration_bootstrap_backend))
        logger.info("FETCHED INFRASTRUCTURE CONFIGURATION : {}".format(configuration_infrastructure_backend))
        logger.info("WRITING THE HCL FILES FOR BACKEND CONFIGURATION")

        tfbackend_folder = path.parent.joinpath(BACKEND_FOLDER)
        tfbackend_bootstrap_file = tfbackend_folder.joinpath("bootstrap.hcl")
        tfbackend_infrastructure_file = tfbackend_folder.joinpath("infrastructure.hcl")

        with open(tfbackend_bootstrap_file, "w") as bootstrap_file_w:
            lines = ["{key} = \"{value}\"\n".format(key=key, value=value) for key, value in configuration_bootstrap_backend.items()]
            bootstrap_file_w.writelines(lines)
        logger.info("BOOTSTRAP HCL BACKEND CONFIGURATION WRITE DONE")

        with open(tfbackend_infrastructure_file, "w") as infra_file_w:
            lines = ["{key} = \"{value}\"\n".format(key=key, value=value) for key, value in configuration_infrastructure_backend.items()]
            infra_file_w.writelines(lines)
        logger.info("INFRASTRUCTURE HCL BACKEND CONFIGURATION WRITE DONE")
        logger.info("SCRIPT FINISHED")


    else:
        logger.error("THE PATH '{}' DON'T EXISTS".format(TERRAFORM_VARS))







