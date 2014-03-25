sshd_centos_docker3
===================

chefの試験を行うためのSSHとchefがインストールされたCentOSのDockerfile

PreRequirement
-----
事前に認証キーを作成しておき、authorized_keysという名前で公開鍵をDockerfileと同じフォルダに設置しておくこと。  
```
ssh-keygen -t rsa -C "your mailaddress"  
```

SSHログイン時に鍵を指定し、ノーパスでログインできるようにする。  
```
Host Docker IP Address  
  Hostname Docker IP Address  
  User jenkins 
  Port 2222  
  IdentityFile 作成した秘密鍵へのパス  
  StrictHostKeyChecking no  
  UserKnownHostsFile /dev/null  
  PasswordAuthentication no  
  IdentitiesOnly yes  
```

Test Chef Recipe
-----
```
knife solo cook 'docker vm's IP Address'
```

Modification
-----
From Centosで通常起動した後、chefのRecipeからiptablesが停止できなかったため、以下修正している。

```
RUN sed -ri "s/^IPTABLES_MODULES_UNLOAD=\"yes\"/IPTABLES_MODULES_UNLOAD=\"no\"/" /etc/sysconfig/iptables-config
```

License and Authors
-------------------
Authors: Hiroharu Tanaka
