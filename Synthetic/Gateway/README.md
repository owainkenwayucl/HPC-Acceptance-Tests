## Simple test to transfer 10G Random file from this machine to RITS clusters

# To run:

$ ./run_test.sh

Due to test account only being in LDAP and not AD will only currently work on two clusters.

To get round this issue can use your account. Will need to add public ssh key to `ssh.rc.ucl.ac.uk`

Output:

ccaathj@pop-os:~/ssh_test$ ./run_test.sh socrates_ssh_config
michael.tunnel
test_data                                                                     100%   65MB   1.6MB/s   00:40    

thomas.tunnel
test_data                                                                     100%   65MB   1.3MB/s   00:48    

grace.tunnel
scp: ./test_data: Read-only file system

ccaathj@pop-os:~/ssh_test$ 

This uses socrates as gateway without argument will use ssh.rc.ucl.ac.uk
