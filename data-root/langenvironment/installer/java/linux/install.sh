#installation /.sh
#sourcepath : /home/vagrant/test/data-path/langenvironment/installer/java/linux/jdk-version.tar.gz
#destpath : /usr/local/
sourcepath=$1
destpath=$2
projectpath=$3

#extract file
#self extracting script
tarfileextract="'/^_TARFILE_FOLLOWS_/ { print NR + 1; exit 0; }'"
touch extract.sh
echo 'echo "Extracting file into `pwd`"' >> extract.sh
echo 'SKIP=`awk '$tarfileextract' $0`' >> extract.sh
echo 'THIS=`pwd`/$0' >> extract.sh
echo 'tail -n +$SKIP $THIS | tar -xz' >> extract.sh
echo 'echo "Finished"' >> extract.sh
echo 'exit 0' >> extract.sh
echo '_TARFILE_FOLLOWS_' >> extract.sh

#concatenate the script and the tar
cat extract.sh $sourcepath > tempextract.sh
chmod +x tempextract.sh

#copy to directory /usr/local & remove temp sh
sudo cp tempextract.sh /usr/local/
rm extract.sh
rm tempextract.sh
cd /usr/local/
sudo sh tempextract.sh
sudo rm tempextract.sh
#finish extract file

#chmod
destpathchmod="$destpath/java/"
sudo chmod -R 755 $destpathchmod

#create folder project
cd ~/
projectpathhome=`pwd`
mkdir -p "$projectpathhome/$projectpath/src"

#set profile
pathprof=$destpath'jdk1.8.0_77'
sed -i '/export JAVA_HOME/d' ~/.profile
echo "export JAVA_HOME=$pathprof" >> ~/.profile
sed -i '/export PATH/d' ~/.profile
echo "export PATH=$PATH:$JAVA_HOME/bin" >> ~/.profile
# export JAVA_HOME=/usr/local/jdk1.7.0_13
# export PATH=$PATH:$JAVA_HOME/bin
$BASH ~/.profile

#testing run project golang


