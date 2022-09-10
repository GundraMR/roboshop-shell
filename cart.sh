set -e

echo setting nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/cart.log

echo installing nodeJS
yum install nodejs -y &>>/tmp/cart.log

echo adding application content
useradd roboshop &>>/tmp/cart.log

echo download application content
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>/tmp/cart.log
cd /home/roboshop &>>/tmp/cart.log

echo cleaning old application content
rm -rf cart &>>/tmp/cart.log

echo Extract application archive
unzip -o /tmp/cart.zip &>>/tmp/cart.log
mv cart-main cart &>>/tmp/cart.log
cd cart &>>/tmp/cart.log

echo installingnodeJS Dependencies
npm install &>>/tmp/cart.log

echo confguring cart SystemD service
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log
systemctl daemon-reload &>>/tmp/cart.log

echo starting cart service
systemctl start cart &>>/tmp/cart.log
systemctl enable cart &>>/tmp/cart.log
