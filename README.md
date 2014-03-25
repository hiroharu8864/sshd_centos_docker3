sshd_centos_docker3
===================

chefの試験を行うためのSSHとchefがインストールされたDockerfile

PreRequirement
-----
事前に認証キーを作成しておき、authorized_keysという名前で公開鍵をDockerfileと同じフォルダに設置しておくこと。  
```ssh-keygen -t rsa -C "your mailaddress"  
```
SSHログイン時に鍵を指定し、ノーパスでログインできるようにする。  
```Host Docker IP Address  
  Hostname Docker IP Address  
  User jenkins 
  Port 2222  
  IdentityFile 作成した秘密鍵へのパス  
  StrictHostKeyChecking no  
  UserKnownHostsFile /dev/null  
  PasswordAuthentication no  
  IdentitiesOnly yes  
```
