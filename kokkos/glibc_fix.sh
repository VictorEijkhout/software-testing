export LD_LIBRARY_PATH=$( ~/bin/splitpath LD_LIBRARY_PATH | grep -v "/usr/lib64"  | ~/bin/assemblepath )
