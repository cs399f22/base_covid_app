from flask import Flask
import redis
import dotenv
import os
import sys


app = Flask(__name__)
dotenv.load_dotenv()

host = os.getenv('REDIS_HOST')
port = os.getenv('REDIS_PORT')

if host is None or port is None:
    print('ERROR: Specify REDIS_HOST and REDIS_PORT in .env')
    sys.exit(1)

r = redis.Redis(host=host, port=port)


@app.route('/')
def home():
    confirmed = int(r.get('confirmed'))
    return 'confirmed: {}'.format(confirmed)


if __name__ == '__main__':
   app.run(host='0.0.0.0', port=8000)
