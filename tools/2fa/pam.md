# 2fa

https://synay.net/support/kb/setting-two-factor-authentication-ssh-root-debian-12

```
apt install libpam-google-authenticator
```

```
google-authenticator
```

```
nano /etc/ssh/sshd_config

PermitRootLogin no
UsePAM yes
ChallengeResponseAuthentication yes
```

```
systemctl restart ssh
```

```
nano /etc/pam.d/su
...
auth       sufficient pam_rootok.so
...
auth required pam_unix.so no_warn try_first_pass
auth   required   pam_google_authenticator.so
...
```

```
nano /etc/pam.d/sshd
...
@include common-auth
...
auth required pam_unix.so no_warn try_first_pass
auth   required   pam_google_authenticator.so
...
```


