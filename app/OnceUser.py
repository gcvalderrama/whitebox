import threading
import os
from locust import TaskSet, task, HttpUser, between, tag, events


class ConfigurationComponent:
    def __init__(self) -> None:
        self.verb = os.getenv('VERB', 'http://www.google.com')
        self.target = os.getenv('TARGET', 'http://www.google.com')
        

class WebsiteUser(HttpUser):
    wait_time = between(1, 2)

    def __init__(self, parent):
        super().__init__(parent)
        self.configuration = ConfigurationComponent()        

    def on_start(self):
        pass

    def on_stop(self):
        pass

    @task()
    def execute(self):
        self.client.get(self.configuration.target)
        


