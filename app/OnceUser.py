import threading
import os
from locust import TaskSet, task, HttpUser, between, tag, events
import logging
import random


class ConfigurationComponent:
    def __init__(self) -> None:
        self.verb = os.getenv('VERB', 'GET')        
        self.host = os.getenv('LOCUST_HOST', '')        
        self.headers = dict()

        if os.getenv('USER_AGENT', ''):
            self.headers['User-Agent'] = os.getenv('USER_AGENT')        


@events.test_start.add_listener
def on_test_start(environment, **kwargs):
    configuration = ConfigurationComponent()    
    logger = logging.getLogger()
    logger.info("=======   HEADERS =========")
    for k,v in configuration.headers.items():
        logger.info("{}:{}".format(k, v))
    logger.info("===========================")    
    logger.info("=======   HOST =========")
    logger.info("{}:{}".format(configuration.host, configuration.verb))
    logger.info("===========================")

class WebsiteUser(HttpUser):    

    def __init__(self, parent):
        super().__init__(parent)
        self.logger = logging.getLogger(__name__)
        self.configuration = ConfigurationComponent()        

    def wait_time(self):
        return random.randint(1, 3) # between(1, 3)

    def on_start(self):
        pass

    def on_stop(self):
        pass

    @task()
    def execute(self):                     
        headers = self.configuration.headers
        self.client.request(self.configuration.verb, self.host, headers=headers)