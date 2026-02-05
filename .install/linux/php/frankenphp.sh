echo "Installing frankenphp from frankenphp.dev..."

cd /tmp
curl https://frankenphp.dev/install.sh | sh
sudo mv frankenphp /usr/local/bin/
cd ~
