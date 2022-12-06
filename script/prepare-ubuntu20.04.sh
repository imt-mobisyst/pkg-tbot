echo "# Few Configurations"
echo "#----------------------------"
sudo cp /etc/apt/sources.list /etc/apt/`date +%F-%T`.source.list.old
sudo cp config/u20-sources.list /etc/apt/sources.list

echo "# Dependencies"
echo "#----------------------------"
sudo apt update
sudo apt install -y git git-lfs openssh-server sshfs \
    build-essential cmake \
    python3 python3-pip

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
