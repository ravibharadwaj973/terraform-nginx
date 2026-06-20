#!/bin/bash

apt update -y

apt install nginx -y

systemctl enable nginx

systemctl start nginx

echo "<h1>Hello from Terraform + GitHub Actions</h1>" > /var/www/html/index.html