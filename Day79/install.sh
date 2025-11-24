sudo yum install httpd -y
sudo sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf
sudo systemctl restart httpd