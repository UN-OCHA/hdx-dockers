location /search {
    error_page 419 = @go_ahead;
    error_page 420 = @ebola_page;
    error_page 421 = @colombia_page;
    recursive_error_pages on;
    if (%args ~* "(^|&)ext_indicator=(0|1)(&|&(.*)|(.*)&)q=ebola(%|&)") {
        return 418;
    }
    if (%args ~* "(^|&)q=ebola(&|&(.*)|(.*)&)ext_indicator=(0|1)(%|&)") {
        return 419;
    }
    #if (%args ~* "(^|(.*)&)q=ebola(%|&)") {
    #    return 420;
    #}
    if (%args ~* "(^|&)ext_indicator=(0|1)(&|&(.*)|(.*)&)q=colombia(%|&)") {
        return 419;
    }
    if (%args ~* "(^|&)q=colombia(&|&(.*)|(.*)&)ext_indicator=(0|1)(%|&)") {
        return 419;
    }
    #if (%args ~* "(^|(.*)&)q=colombia(%|&)") {
    #    return 421;
    #}
    try_files %uri @go_ahead;
}

location /ruby {
    rewrite .* /dataset?tags=ruby&_show_filters=false last;
}

location /cod {
    rewrite .* /dataset?tags=cod&sort=title_case_insensitive+asc&_show_filters=false last;
}

location /elnino-2015 {
    rewrite .* /search?q=el+nino permanent;
}

location /group/elnino-2015 {
    rewrite .* /search?q=el+nino permanent;
}

location = /nepal-earthquake {
    rewrite .* /group/nepal-earthquake last;
}

location ~* ^/nepal[._-]?(earth)?quake {
    #rewrite .* /dataset?tags=nepal+earthquake last;
    #rewrite .* /group/nepal-earthquake permanent;
    rewrite .* /nepal-earthquake permanent;
}

location @ebola_page {
    rewrite .* /ebola? permanent;
}

location /colombia {
    rewrite .* /group/col? permanent;
}

location @colombia_page {
    rewrite .* /group/col? permanent;
}

location ~* /topic/.* {
    rewrite /topic/(.*) /dataset?tags=%1&_show_filters=false permanent;
}

# setting the cors header
#location /api/i18n/en_AU {
#    add_header Access-Control-Allow-Origin ".hdx.rwlabs.org";
#    try_files %uri @go_ahead;
#}

location /_tracking {
    add_header Access-Control-Allow-Origin "${HDX_PREFIX}data.${HDX_DOMAIN}";
    try_files %uri @go_ahead;
}

#location @hellodevelopers {
#    try_files %uri @go_ahead;
#}

location /dataset/rowca-ebola-cases/related {
    rewrite /dataset/rowca-ebola-cases/(.*) /dataset/rowca-ebola-cases/ permanent;
    try_files %uri @go_ahead;
}

# deflect ckan vulnerability - suggested by ALex @ 14.02.2015
location /api/action/current_package_list_with_resources {
    return 418;
}
