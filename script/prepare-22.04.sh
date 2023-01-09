echo "# Dependencies"
echo "#----------------------------"
sudo apt update
sudo apt install curl
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg


sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4EB27DB2A3B88B8B # update expired chrome key
sudo apt update
sudo apt upgrade -y
sudo apt install -y git tmux git-lfs openssh-server sshfs \
    build-essential cmake \
    python3 python3-pip \
    gnome-tweaks

echo "# Git Configuration"
echo "#----------------------------"
git config --global user.name bot
git config --global user.email bot@mb6.imt-nord-europe.fr
git config --global credential.helper cache
git config --global http.sslVerify false
git-lfs install

echo "# Tools"
echo "#----------------------------"
sudo dpkg -i dpd/code_1.73.1-1667967334_amd64.deb
