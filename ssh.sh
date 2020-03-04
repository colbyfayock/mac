# https://superuser.com/questions/988185/how-to-avoid-being-asked-enter-passphrase-for-key-when-im-doing-ssh-operatio
eval `ssh-agent -s`
ssh-add ~/.ssh/id_rsa