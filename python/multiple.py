import subprocess

process = subprocess.Popen(['/bin/bash'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
process_input = process.stdin

command = "a=2"
process_input.write(command+'\n')
process_input.flush()

command = "echo $a"
process_input.write(command+'\n')
process_input.flush()

print(process.stdout.readline().strip())

