pip install -r contestsite/requirements.txt
python contestsite/manage.py collectstatic --noinput
supervisord -n -c /etc/supervisor/supervisord.conf