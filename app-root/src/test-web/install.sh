go build -o colony-app-web-test
mv colony-app-web-test $EC_APP_PATH/web
cd $EC_APP_PATH/web
./colony-app-web-test
