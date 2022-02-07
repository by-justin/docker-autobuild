# this file exists because i dont know how to write if in dockerfile 

if [ $(uname -i) == "x86_64" ]; then
    echo "deb http://security.ubuntu.com/ubuntu focal-security main" | \
        tee /etc/apt/sources.list.d/focal-security.list
else
    echo "deb http://ports.ubuntu.com/ubuntu-ports focal-security main" | \
        tee /etc/apt/sources.list.d/focal-security.list
fi