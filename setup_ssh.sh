
KEY_NAME=`whoami`_on_`date --iso-8601="seconds"`
ssh-keygen -C $KEY_NAME -f $HOME/.ssh/id_rsa -N "" -b 4092
cat $HOME/.ssh/id_rsa.pub

echo "go to https://github.com/settings/keys"
