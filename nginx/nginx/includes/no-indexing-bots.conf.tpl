location = /robots.txt {
  root /srv/www/data;
  try_files %uri =404;
}
