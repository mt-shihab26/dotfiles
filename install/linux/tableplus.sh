sudo rpm -v --import https://yum.tableplus.com/apt.tableplus.com.gpg.key
sudo dnf config-manager addrepo --from-repofile=https://yum.tableplus.com/rpm/x86_64/tableplus.repo
sudo dnf install tableplus
