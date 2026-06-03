# !/bin/sh

if ! test -d ".agents/skills"; then
    mkdir -p ".agents/skills"
fi

ln -s "$PWD/skills/afhl-review-skills" ".agents/skills/afhl-review-skills"