#/bin/bash
echo “This command must be run as root in order to work properly”
read -p "Is this command being run as root? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
        echo "Command needs to be run as root"
        [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

sudo apt-get update
wait
sudo apt-get upgrade -y
wait
# Install guacamole dependencies
sudo apt-get install libcairo2-dev libpng12-dev libossp-uuid-dev libavcodec-dev libavutil-dev libswscale-dev libfreerdp-dev libpango1.0-dev libssh2-1-dev libtelnet-dev libvncserver-dev libpulse-dev libssl-dev libvorbis-dev libwebp-dev libjpeg-dev libjpeg8-dev libjpeg-turbo8-dev tomcat8 x11vnc -y
wait
# Download and extract server files
sudo wget -O /tmp/guacamole-server-0.9.12-incubating.tar.gz http://download.nextag.com/apache/incubator/guacamole/0.9.12-incubating/source/guacamole-server-0.9.12-incubating.tar.gz
wait
sudo tar -zxvf /tmp/guacamole-server-0.9.12-incubating.tar.gz -C /tmp/.
wait
# Configure and make the guacamole server
cd /tmp/guacamole-server-0.9.12-incubating && sudo ./configure --with-init-dir=/etc/init.d
sudo make -C /tmp/guacamole-server-0.9.12-incubating/.
wait
cd /tmp/guacamole-server-0.9.12-incubating && sudo make install
sudo ldconfig
wait

# Download guacamole web application file
sudo wget -O /var/lib/tomcat8/webapps/guacamole.war http://mirrors.sonic.net/apache/incubator/guacamole/0.9.12-incubating/source/guacamole-client-0.9.12-incubating.tar.gz
wait
# make required directories
sudo mkdir /etc/guacamole
sudo mkdir /usr/share/tomcat8/.guacamole
# make guacamole.properties file and fill it with correct information
sudo cat > /etc/guacamole/guacamole.properties << EOF
guacd-hostname: localhost
guacd-port:    4822
user-mapping:    /etc/guacamole/user-mapping.xml
auth-provider:    net.sourceforge.guacamole.net.basic.BasicFileAuthenticationProvider
basic-user-mapping:    /etc/guacamole/user-mapping.xml
EOF
# make required links for guacamole.properties and guacamole.war
sudo ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat8/.guacamole
sudo mkdir /var/lib/guacamole
sudo ln -s /var/lib/tomcat8/webapps/guacamole.war /var/lib/guacamole/guacamole.war
# make empty user-mapping.xml file
# give files required permissions and change owner to tomcat8
sudo touch /etc/guacamole/user-mapping.xml && sudo chmod 600 /etc/guacamole/user-mapping.xml && sudo chown tomcat8:tomcat8 /etc/guacamole/user-mapping.xml

# start tomcat8 and guacamole
sudo service tomcat8 start
wait
# add guacamole to start on boot
sudo systemctl enable guacd.service
wait
sudo systemctl start guacd.service
