#uninstall app java 
destpath=$1

rm -rf ~/testing/src/testjava/
sed -i '/export JAVA_HOME/d' ~/.profile
sed -ri 's/:[$]JAVA_HOME//g' ~/.profile
source ~/.profile
sudo rm -rf $destpath'jdk1.8.0_77/'
#/usr/local/jdk1.8.0_77/