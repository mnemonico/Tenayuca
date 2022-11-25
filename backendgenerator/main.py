from pathlib import Path
import logging

logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger('terraform_backend_configuration_generator')

if __name__ == '__main__':
    logger.warning('CURRENT DIRECTORY : {}'.format(Path.cwd()))
    logger.info('READING TFVAR FILE TO GENERATE the BACKEND CONFIG FILE')




