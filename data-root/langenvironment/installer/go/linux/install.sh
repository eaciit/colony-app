#installation /.sh
#sourcepath : file
#destpath : /usr/local/
#projectpath : goproject
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
#sudo cp tempextract.sh /usr/local
#testing
#mkdir -p temp/
#cp tempextract.sh temp/
#rm extract.sh
#rm tempextract.sh
#cd temp/
#sh tempextract.sh
#end testing
sudo cp tempextract.sh /usr/local/
rm extract.sh
rm tempextract.sh
cd /usr/local/
sudo sh tempextract.sh
sudo rm tempextract.sh
#finish extract file

#chmod
destpathchmod="$destpath/go/"
sudo chmod -R 755 $destpathchmod

#create folder project
cd ~/
projectpathhome=`pwd`
mkdir -p "$projectpathhome/$projectpath/bin"
mkdir -p "$projectpathhome/$projectpath/pkg"
mkdir -p "$projectpathhome/$projectpath/src"

#set environment go
sed -i '/export GOPATH/d' ~/.bashrc
echo "export GOPATH=$projectpathhome/$projectpath" >> ~/.bashrc
#set profile
pathprof=$destpath'go/bin'
sed -i '/export PATH/d' ~/.profile
echo "export PATH=$PATH:$pathprof" >> ~/.profile
$BASH ~/.profile

#testing run project golang
mkdir -p "$projectpathhome/$projectpath/src/test"
touch "$projectpathhome/$projectpath/src/test/main.go"
echo -e 'package main\n import "fmt"\n func main() {\nfmt.Println("Hello World .. ")\n}' >> "$projectpathhome/$projectpath/src/test/main.go"
#go run "$projectpathhome/$projectpath/src/test/main.go"

