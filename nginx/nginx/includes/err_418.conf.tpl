
# let developers run some api ckan scripts
# when the http basic auth is on
# (can't have more than one auth header and that is for ckan api key)
error_page 418 = @on_418;
if (%http_user_agent = "HDX-Developer-2015") {
    return 418;
}

location @on_418 {
    # don't forget to define @after_418 in the main file (the file in which you include this snippet)
    try_files %uri @after_418;
}
