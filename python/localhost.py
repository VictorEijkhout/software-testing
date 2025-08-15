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
stdin,stdout,stderr = ssh.exec_command( f"touch {pwd}/paramiko_test.dat" )

