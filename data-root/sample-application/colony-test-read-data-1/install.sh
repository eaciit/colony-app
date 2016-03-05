go build -o colony-test-read-data-1
mv colony-test-read-data-1 $EC_APP_PATH/web
cd $EC_APP_PATH/web
./colony-test-read-data-1
