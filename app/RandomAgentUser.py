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
        agents = [
            "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.{} Safari/537.36",
            "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.{} Safari/537.36 OPR/74.0.3911.154",
            "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.{} (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1",
            "Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.{} (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30",
            "Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.{} (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36",
            "Mozilla/5.0 (Linux; Android 7.0; SM-A310F Build/NRD90M) AppleWebKit/537.{} (KHTML, like Gecko) Chrome/55.0.2883.91 Mobile Safari/537.36 OPR/42.7.2246.114996",
            "Opera/9.80 (Android 4.1.2; Linux; Opera Mobi/ADR-1305251841) Presto/2.{}.355 Version/12.10",
            "Mozilla/5.0 (Android 7.0; Mobile; rv:54.0) Gecko/54.0 Firefox/{}.0",
            "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_2 like Mac OS X) AppleWebKit/603.2.4 (KHTML, like Gecko) FxiOS/7.5b3349 Mobile/{}F89 Safari/603.2.4",
            "Mozilla/5.0 (Linux; Android 7.0; SAMSUNG SM-G955U Build/NRD90M) AppleWebKit/537.{} (KHTML, like Gecko) SamsungBrowser/5.4 Chrome/51.0.2704.106 Mobile Safari/537.36",
            "Mozilla/5.0 (Linux; U; Android 7.0; en-us; MI 5 Build/NRD90M) AppleWebKit/537.{} (KHTML, like Gecko) Version/4.0 Chrome/53.0.2785.146 Mobile Safari/537.36 XiaoMi/MiuiBrowser/9.0.3",
            "Mozilla/5.0 (Windows Phone 10.0; Android 6.0.1; Microsoft; Lumia 950) AppleWebKit/537.{} (KHTML, like Gecko) Chrome/52.0.2743.116 Mobile Safari/537.36 Edge/15.14977"
        ]

        headers = self.configuration.headers
        trial = agents[random.randint(0, len(agents) - 1)]
        trial = trial.format(random.randint(10, 50))
        headers["User-Agent"] = trial
        self.client.request(self.configuration.verb, self.host, headers=headers)