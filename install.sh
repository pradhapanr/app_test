#!/bin/bash
sudo apt-get update

# Installation for React Project
# sudo apt-get install nodejs
# sudo apt install npm
sudo apt install build-essential -y
sudo apt-get install wget -y
curL https://deb.nodesource.com/setup_16.x | sudo -E bash - &&\
	sudo apt-get install -y nodejs

sudo apt-get install nginx
npm install react-bootstrap bootstrap

# npm sprint-4/start

# Serving the React Application

# sudo rm /etc/nginx/sites-enabled/default
# Need the actual React file. Need to replace the /react-flask-app.nginx
# sudo ln -s /etc/nginx/sites-available/react-flask-app.nginx /etc/nginx/sites-enabled/react-flask-app.nginx
# sudo systemctl reload nginx

# Installation for the Python Environment 
sudo apt install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools # Install the packages that will allow you to build the Python Enviroment
sudo apt install python3-venv 

python3 -m venv server/venv
source server/venv/bin/activate

pip install flask 
pip install -r server/requirements.txt
##temporary installs add to requirements.txt after
pip install gunicorn

# flask run

# cd server 
# Configuring uWSGI and Serving the Flask Application
# uwsgi --socket 0.0.0.0:5000 --protocol=http -w wsgi:app
# cd ..
deactivate

sudo rm /etc/nginx/sites-available/server # delete existing file and replace it so we have no symlink issue
sudo cp -a server/server /etc/nginx/sites-available/server #configure Nginx to pass web requests to that socket using the uwsgi protocol
sudo ln -s /etc/nginx/sites-available/server /etc/nginx/sites-enabled #To enable the Nginx server block configuration you’ve just created, link the file to the sites

sudo systemctl reload nginx # loads up front end to public url

sudo cp -a server/scheduler.service /etc/systemd/system/  # Copy server.server to sysmtem folder
 
# sudo systemctl start server  # start the uWSGI service you created and enable it so that it starts at boot
# sudo systemctl enable server

# sudo systemctl status server # Check status

# sudo rm /etc/nginx/sites-enabled/default

sudo systemctl daemon-reload
sudo systemctl start scheduler
sudo systemctl reload nginx

# sudo nginx -t #test for syntax errors
# sudo systemctl restart nginx
