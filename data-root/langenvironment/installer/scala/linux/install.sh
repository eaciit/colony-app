#installation /.sh
#sourcepath : file
#destpath : /usr/local/
#projectpath : goproject
sourcepath=$1
destpath=$2

destpath=$destpath'share/'
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
destpathchmod=$destpath'scala-2.11.8/'
sudo chmod -R 755 $destpathchmod

#create folder project
cd ~/
projectpathhome=`pwd`
mkdir -p "$projectpathhome/testing/src"

#set profile
# export SCALA_HOME=/usr/local/share/scala-2.11.8-linux-x86_64
# export PATH=$PATH:$SCALA_HOME/bin
pathprof=$destpath'scala-2.11.8/bin'
sed -i '/export SCALA_HOME/d' ~/.profile

checkpath=`sed -n -e '/export PATH/p' ~/.profile`
if [ $checkpath=="" ]; then
	echo "export SCALA_HOME=$pathprof" >> ~/.profile
	echo 'export PATH=$PATH:$SCALA_HOME' >> ~/.profile
else
	sed -ri '/^export PATH/ i export SCALA_HOME='$pathprof ~/.profile
	sed -ri 's/:[$]SCALA_HOME//g' ~/.profile
	sed -ri '/^export PATH/ s/$/:$SCALA_HOME/' ~/.profile
fi
# sed -i '/export PATH/d' ~/.profile
# echo 'export PATH=$PATH:'$pathprof/bin >> ~/.profile
#$BASH ~/.profile
source ~/.profile

#testing run project java
mkdir -p "$projectpathhome/testing/src/testscala" 
cd "$projectpathhome/testing/src/testscala"
#touch "helloworld.scala"
echo -e 'object helloworld extends App { \n println("scala : Hello World") \n}' > "$projectpathhome/testing/src/testscala/helloworld.scala"
scalac "helloworld.scala"
scala "helloworld"