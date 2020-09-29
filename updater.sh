set -xv
curl https://github.com/users/umihico/contributions | grep data-date=\"$(date +'%Y-%m-%d')\" | grep data-count=\"0\"
if [ $? -eq 0 ]; then
  sh umihi.co.sh
  sh books.sh
  sh PortfolioHub.sh
  sh laravel-demo.sh
  sh laravel-template.sh
fi
