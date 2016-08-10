# ---- ssh to server
# ssh developer@go.eaciit.com -i /Users/novalagung/Downloads/developer.pem

# ---- copy installer
# scp -i /Users/novalagung/Downloads/developer.pem /Users/novalagung/Desktop/installer.zip developer@go.eaciit.com:/data/goapp/src/github.com/eaciit/colony-app-installer

# ---- colony nginx conf
# cd /data/nginx/ && 8026_colony-dev.conf

# ---- update colony
# go get -u github.com/eaciit/colony-manager
# go get -u github.com/eaciit/colony-core
# go get -u github.com/eaciit/colony-app

# ---- make sure no error on colony-core
cd $GOPATH/src/github.com/eaciit/colony-core/v0
go install

# ---- make sure no error on colony-manager
cd $GOPATH/src/github.com/eaciit/colony-manager
go install

# ---- go to colony-manager
cd $GOPATH/src/github.com/eaciit/colony-manager
colony_manager_port='8026'
colony_manager_old_port='server.Address = "localhost:3000"'
colony_manager_new_port='server.Address = "localhost:'$colony_manager_port'"'
sed -i "s%$colony_manager_old_port%$colony_manager_new_port%g" colony.go

# ---- kill previous process
kill -9 `lsof -i:$colony_manager_port -t`

cd $GOPATH/src/github.com/eaciit/colony-manager
go build colony.go && mv colony colony_manager && nohup ./colony_manager &