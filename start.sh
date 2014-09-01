useradd --shell /bin/sh --create-home $USERNAME -s /bin/false
usermod -d /sftp $USERNAME
echo "$USERNAME:$PASSWORD" |chpasswd

sudo chown root:root /sftp
sudo chown $USERNAME:$USERNAME /sftp/*
sudo chmod -R 755 /sftp/*
/usr/sbin/sshd -D
