set -xv
cd
git clone https://github.com/umihico/laravel-template.git
cd laravel-template/
hub pr list -f %au%U%n | grep -E "dependabot\[bot\]https://github.com/umihico/laravel-template/pull/[0-9]+" | sed -e 's/dependabot\[bot\]//g' | xargs -I URL hub merge URL
composer update
ncu -u
npm install
git add -A
git status
git commit -m "automated dependencies update"
git push --repo "https://umihico:${GITHUB_REPOSITORY_TOKEN}@github.com/umihico/laravel-template"
