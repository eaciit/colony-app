#uninstall app scala
rm -rf ~/testing/src/testscala/
sed -i '/export SCALA_HOME/d' ~/.profile
sed -ri 's/:[$]SCALA_HOME//g' ~/.profile
source ~/.profile
# sudo rm -rf /usr/local/share/scala-2.11.8/
sudo rm -rf $destpath'share/scala-2.11.8/'