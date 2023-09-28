#! bin/bash

projectName=$1
pyCommand=$2
pyLibraryCommand=""
py_content=$(cat << 'EOF'
if __name__ == '__main__':
    print("Hello World")
EOF    
)

touch $projectName/src/main.py

echo $projectName/pyhton3 -m venv .venv

if [$pyCommand == "py" ] then;
    echo "running base script"

elif [$pyCommand == "py-web"] then;
    echo "running the pip module"
    pyLibraryCommand=$projectName/.vnv/bin/pip3 install flask

echo $pyLibraryCommand
echo "$py_content" > $projectName/src/main.py