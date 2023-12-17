FROM erdnase/vm:generic
RUN add-apt-repository ppa:deluge-team/stable && apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y rclone deluge deluged deluge-web deluge-console ufw && apt-get clean
# see https://github.com/JohnDoee/deluge-client
RUN pip3 install deluge-client
# RUN ufw deny out from any to 10.0.0.0/8 && ufw deny out from any to 172.16.0.0/12 && ufw deny out from any to 192.168.0.0/16 && ufw deny out from any to 100.64.0.0/10 && ufw deny out from any to 198.18.0.0/15 && ufw deny out from any to 169.254.0.0/16 && ufw allow ssh && ufw enable
