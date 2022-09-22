#!/bin/bash
set -x
amazon-linux-extras install -y redis6
systemctl enable redis
systemctl start redis
yum install -y git
cd /
git clone https://github.com/cs399f22/base_covid_app
cd /base_covid_app/collector/ && python3 -m venv .venv
/base_covid_app/collector/.venv/bin/pip install -r /base_covid_app/collector/requirements.txt 
echo "REDIS_HOST=localhost" >> /base_covid_app/collector/.env
echo "REDIS_PORT=6379" >> /base_covid_app/collector/.env
cp /base_covid_app/collector/collector.service /etc/systemd/system/
systemctl enable collector.service
systemctl start collector.service
cd /base_covid_app/server/ && python3 -m venv .venv
/base_covid_app/server/.venv/bin/pip install -r /base_covid_app/server/requirements.txt 
echo "REDIS_HOST=localhost" >> /base_covid_app/server/.env
echo "REDIS_PORT=6379" >> /base_covid_app/server/.env
cp /base_covid_app/server/flask.service /etc/systemd/system/
systemctl enable flask.service
systemctl start flask.service
