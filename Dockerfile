FROM erdnase/vm:generic
RUN add-apt-repository ppa:deluge-team/stable && apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y rclone deluge deluged deluge-web deluge-console && apt-get clean
# must first run `sudo service nordvpn start`
RUN wget 'https://downloads.nordcdn.com/apps/linux/install.sh' && bash ./install.sh -n && rm ./install.sh