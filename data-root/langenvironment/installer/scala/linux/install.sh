#installation /.sh
#sourcepath : file
#destpath : /usr/local/
#projectpath : goproject
sourcepath=$1
destpath=$2

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
sudo cp tempextract.sh $destpath
rm extract.sh
rm tempextract.sh
cd $destpath
sudo sh tempextract.sh
sudo rm tempextract.sh
#finish extract file

#chmod
destpathchmod=$destpath'scala/'
sudo chmod -R 755 $destpathchmod

#create folder project
cd ~/
projectpathhome=`pwd`
mkdir -p "$projectpathhome/testing/src"

#set profile
# export SCALA_HOME=/usr/local/share/scala-2.11.8-linux-x86_64
# export PATH=$PATH:$SCALA_HOME/bin
pathprof=$destpath'scala-2.11.8'
sed -i '/export PATH/d' ~/.profile
echo "export PATH=$PATH:$pathprof/bin" >> ~/.profile
#$BASH ~/.profile
source ~/.profile

#testing run project java