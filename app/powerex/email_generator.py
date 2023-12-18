def generate_email(first_name, last_name, domain):
    email = f"{first_name.lower()}.{last_name.lower()}@{domain}"
    return email

def process_names(input_file, output_file, domain):
    with open(input_file, 'r') as input_file:
        names = input_file.readlines()

    with open(output_file, 'w') as output_file:
        for name in names:
            first_name, last_name = name.strip().split()
            email_address = generate_email(first_name, last_name, domain)
            output_file.write(f"{email_address}\n")
