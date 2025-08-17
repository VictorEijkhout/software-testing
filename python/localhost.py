import os
import paramiko
import socket
import sys

def ssh_client(host):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    print( f"Create paramiko ssh client to {host}",flush=True)
    ssh.connect(host)
    return ssh

hostname = socket.gethostname()
pwd = os.getcwd()
ssh = ssh_client(hostname)
datafile = f"{pwd}/paramiko_test.dat"
print( f"create file through ssh tunnel to <<{hostname}>> : <<{datafile}>>" )
stdin,stdout,stderr = ssh.exec_command( f"touch {datafile}" )

##
## make sure the file is there
##
ssh.close()
import time
time.sleep(1)

