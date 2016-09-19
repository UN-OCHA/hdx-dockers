
add_header X-Robots-Tag "noindex, nofollow, nosnippet, noarchive";

location = /robots.txt {
  root /srv/www/data;
  try_files %uri =404;
}
