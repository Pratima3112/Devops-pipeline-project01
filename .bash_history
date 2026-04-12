ps -p 1 -o comm=
sudo  systemctl start docker
sudo  systemctl enable docker
docker run hello-world
sudo nano /etc/resolv.conf
sudo nano /etc/wsl.conf
ping google.com
sudo rm /etc/resolv.conf
ping google.com
sudo rm /etc/resolv.conf
sudo bash -c 'echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" > /etc/resolv.conf'
sudo nano /etc/wsl.conf
sudo bash -c 'echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" > /etc/resolv.conf'
sudo chattr +i /etc/resolv.conf
