#!/bin/bash

dnf update -y

dnf install -y nginx

systemctl enable nginx

systemctl start nginx

cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Terraform Nginx Server</title>
</head>

<body>

<h1>Hello from Terraform!</h1>

<h2>Nginx installed using EC2 User Data</h2>

<p>Server successfully created using Terraform Module.</p>

</body>
</html>
EOF