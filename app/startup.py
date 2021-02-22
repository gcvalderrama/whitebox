from locust.env import Environment
import os
from os import listdir
import gevent
from locust import HttpUser, task, between
from locust.env import Environment
from locust.log import setup_logging, greenlet_exception_logger
from locust import stats
from ftplib import FTP
from locust.argument_parser import parse_options
import time
from locust.stats import StatsCSV, StatsCSVFileWriter, stats_printer, stats_history
import logging
import sys


TARGET_APP_DIR = os.getenv('TARGET_DIR' , './app')
LOCUST_RUN_TIME = os.getenv('LOCUST_RUN_TIME' , 20)
LOCUST_USER_COUNT = os.getenv('LOCUST_USER_COUNT' , 10)
LOCUST_SPAWN_RATE = os.getenv('LOCUST_SPAWN_RATE' , 5)
LOCUST_SPAWN_RATE = os.getenv('LOCUST_SPAWN_RATE' , 5)

setup_logging("INFO", None)
logger = logging.getLogger()
greenlet_exception_handler = greenlet_exception_logger(logger)


options = parse_options()
from app.OnceUser import WebsiteUser
env = Environment(user_classes=[WebsiteUser], host="http://www.google.com", reset_stats=True, parsed_options=options)
if  os.getenv('OnceUser.py'):
    pass    
else:
    pass
    #raise ValueError('test was not loaded')

stats_csv_writer = StatsCSVFileWriter(env, stats.PERCENTILES_TO_REPORT, './app/reports', options.stats_history_enabled)
print(type(stats_csv_writer))
env.create_local_runner()

env.runner.start(LOCUST_USER_COUNT, LOCUST_SPAWN_RATE)
gevent.spawn(stats_printer(env.stats))
gevent.spawn(stats_csv_writer.stats_writer).link_exception(greenlet_exception_handler)
gevent.spawn_later(LOCUST_RUN_TIME, lambda: env.runner.quit())
env.runner.greenlet.join()
env.runner.stop()
env.runner.quit()

ftp = FTP(host="192.168.18.16", user='trial', passwd='1234')
ftp.set_pasv(False)

for filename in listdir(TARGET_APP_DIR):
    file = '{}/{}'.format(TARGET_APP_DIR, filename)
    if ".csv" in filename and os.path.isfile(file):
        with open(file, 'rb') as f:    
            ftp.storbinary('STOR {}'.format(filename), f)

ftp.quit()

sys.exit(0)

def web_ui():
    env.create_web_ui("127.0.0.1", 8089)

    # start a greenlet that periodically outputs the current stats
    gevent.spawn(stats_printer(env.stats))

    # start a greenlet that save current stats to history
    gevent.spawn(stats_history, env.runner)

    # start the test
    env.runner.start(1, spawn_rate=10)

    # in 60 seconds stop the runner
    gevent.spawn_later(30, lambda: env.runner.quit())

    # wait for the greenlets
    env.runner.greenlet.join()

    # stop the web server for good measures
    env.web_ui.stop()

   

