location @on_418 {
    # don't forget to define @after_418 in the main file (the file in which you include this snippet)
    try_files %uri @after_418;
}
