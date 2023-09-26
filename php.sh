#! /bin/bash

projectName=$1

mkdir -p $projectName/src/Model $projectName/src/View $projectName/src/Controller
touch $projectName/src/index.php $projectName/src/db.sql
# fill index.php with standard values like head, title and such 