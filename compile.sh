erlc -I /lib/ejabberd-16.09/include -o ebin src/mod_register_announce.erl
cp ebin/mod_register_announce.beam /lib/ejabberd-16.09/ebin
su - ejabberd -c "ejabberdctl restart"
