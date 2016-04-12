#uninstall app golang
destpath=$1

rm -rf ~/goproject/
sed -i '/export GOPATH/d' ~/.bashrc
sed -i '/export GO_HOME/d' ~/.profile
sed -ri 's/:[$]GO_HOME//g' ~/.profile
source ~/.profile
# sudo rm -rf /usr/local/go/
sudo rm -rf $destpath'go/'