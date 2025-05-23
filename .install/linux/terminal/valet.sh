bash ./php.sh

sudo apt remove apache2

sudo apt update

sudo apt install network-manager libnss3-tools jq xsel nginx
sudo apt install php-cli php-curl php-mbstring php-mcrypt php-xml php-zip php-sqlite3 php-mysql php-pgsql php-redis

composer global require cpriego/valet-linux

valet install
