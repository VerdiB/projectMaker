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

if [ $pyCommand == "py" ]; then
    echo "running base script with empty virtual env"

elif [ $pyCommand == "py-web" ]; then
    echo "running the pip module"
    pyLibraryCommand="$projectName/.venv/bin/pip3 install flask"
fi

eval "python3 -m venv $projectName/.venv"
eval "$pyLibraryCommand"
echo "$py_content" > $projectName/src/main.py