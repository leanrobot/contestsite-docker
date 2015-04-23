command = '/opt/myenv/bin/gunicorn'
pythonpath = '/opt/myenv/myproject'
bind = 'unix:/tmp/gunicorn.sock'
workers = 3
reload = True
errorlog  = '/root/logs/gunicorn_error.log'
accesslog = '/root/logs/gunicorn_access.log'
