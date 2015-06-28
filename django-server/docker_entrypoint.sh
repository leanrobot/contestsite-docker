pip install -r /root/contestsite/requirements.txt
python /root/contestsite/manage.py collectstatic --noinput
supervisord -n -c /etc/supervisor/supervisord.conf