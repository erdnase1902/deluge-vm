# To use x11 in ubuntu host, first run "xhost+" in the host
r = Random.new
port1 = r.rand(10000...65535)
port2 = r.rand(10000...65535)
port3 = r.rand(10000...65535)

module OS
  def OS.windows?
      (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
      (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
      !OS.windows?
  end

  def OS.linux?
      OS.unix? and not OS.mac?
  end
end

Vagrant.configure("2") do |config|
  config.ssh.insert_key = true
  config.vm.hostname = "ubuntu"
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"
  config.vm.provider :docker do |d|
    if OS.windows?
      d.create_args = ['--sysctl', 'net.ipv4.ip_default_ttl=66', '--privileged=true', '-v', '/var/lib/docker', '--shm-size', '2gb']
    elsif OS.mac?
      d.create_args = ['--sysctl', 'net.ipv4.ip_default_ttl=66', '--privileged=true', '-v', '/var/lib/docker', '--shm-size', '2gb']
    else
      d.create_args = ['--sysctl', 'net.ipv4.ip_default_ttl=66', '--privileged=true', '-v', '/var/lib/docker', '--shm-size', '2gb', '-v', '/tmp/.X11-unix:/tmp/.X11-unix']
    end
     d.image = "erdnase/vm:deluge"
     d.remains_running = true
     d.has_ssh = true
  end


if OS.windows?
  config.vm.provision "shell", inline: <<-SHELL
  echo "export DISPLAY=host.docker.internal:0.0" >> /home/vagrant/.profile
  # xfce4-power-manager -q
  SHELL
elsif OS.mac?
  config.vm.provision "shell", inline: <<-SHELL
  echo "export DISPLAY=host.docker.internal:0.0" >> /home/vagrant/.profile
  # xfce4-power-manager -q
  SHELL
else
  config.vm.provision "shell", inline: <<-SHELL
  echo "export DISPLAY=#{ENV['DISPLAY']}" >> /home/vagrant/.profile
  # xfce4-power-manager -q
  SHELL
end
#   config.vm.provision :shell, path: "install.sh", privileged: false
#   https://ilhicas.com/2018/04/08/Fixing-do-you-need-insmod.html
#   need to run, in host, sudo modprobe ip6table_filter
config.vm.provision :shell, inline: "sudo service xrdp restart && sudo ufw --force enable && sudo ufw deny out from any to 10.0.0.0/8 && sudo ufw deny out from any to 172.16.0.0/12 && sudo ufw deny out from any to 192.168.0.0/16 && sudo ufw deny out from any to 100.64.0.0/10 && sudo ufw deny out from any to 198.18.0.0/15 && sudo ufw deny out from any to 169.254.0.0/16 && sudo ufw allow ssh", run: 'always'
# config.vm.synced_folder "data", "/vagrant_data"
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", type: "dhcp"
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
config.vm.network "forwarded_port", guest: 3389, host: 3389, auto_correct: true
config.vm.network "forwarded_port", guest: 11111, host: 11111, auto_correct: true
config.vm.network "forwarded_port", guest: 11112, host: 11112, auto_correct: true

end
