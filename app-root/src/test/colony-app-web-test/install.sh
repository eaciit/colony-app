go build -o colony-app-web-test
mv colony-app-web-test $EC_APP_PATH/web
cd $EC_APP_PATH/web
nohup ./colony-app-web-test > /dev/null 2>&1 & echo $! > run.pid
