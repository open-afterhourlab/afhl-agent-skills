#!/bin/sh

AFHL_REPO_PATH="<CHECKOUT_REPO_URL>"
TARGET_SKILL_OUTPUT_FOLDER="./skills"

for filename in "$AFHL_REPO_PATH/skills/"*; 
do 
    skill_name=`basename ${filename}`
    output_name="${TARGET_SKILL_OUTPUT_FOLDER}/${skill_name}"

    if test -f "${output_name}"
    then
        rm "$output_name"
    fi

    ln -sf "${filename}" "${TARGET_SKILL_OUTPUT_FOLDER}/"
done
