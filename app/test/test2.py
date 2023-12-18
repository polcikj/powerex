from powerex.email_generator import process_names
domain = "powerex.io"
download_path = "names2.txt"
upload_path = "emails_from_names2.txt"
process_names(download_path, upload_path, domain)