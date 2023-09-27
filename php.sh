#! /bin/bash

projectName=$1

mkdir -p $projectName/src/Model $projectName/src/View $projectName/src/Controller $projectName/src/Css
touch $projectName/src/index.php $projectName/src/db.sql $projectName/src/Css/style.css

# making a basic index setup with just the html tags 
index_content=$(cat << 'EOF'
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="Css/style.css"/>
        <title>PLACEHOLDER_PROJECTNAME</title>
    </head>
    <body>
        <header>
            <nav>
            </nav>
        </header>
        <main>
        </main>
        <footer>
        </footer>
    </body>
</html>
EOF
)
index_content="${index_content/PLACEHOLDER_PROJECTNAME/projectName}"
echo "$index_content" >$projectName/src/index.php