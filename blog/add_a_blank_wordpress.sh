mkdir -p /srv/www/docs && \
curl https://wordpress.org/latest.tar.gz -so /srv/latest.tar.gz && \
tar xzf /srv/latest.tar.gz -C /srv/www/ && \
mv /srv/www/wordpress/* /srv/www/docs/ && \
rm /srv/latest.tar.gz && \
rm -rf /srv/www/wordpress
