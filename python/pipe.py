import subprocess


p = subprocess.Popen(fullcommandline,shell=True,env=os.environ,
                     stderr=subprocess.STDOUT)
