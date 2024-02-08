USERNAME = "ricardoddev"
PASSWORD = "ccyay"
PASSWORD_VAULT = {
    aws: {
        username: "aws_ricardoddev",
        password: "12345"
    }
}

def welcome_message
    puts "Welcome to None Shall Pass - A Password Manager."
end

def prompt_user_for_name
    puts "Please sign in to continue."
    print "Enter username: " #print para o input vir na mesma linha
    gets.chomp #return omitido, mas está aí
end 

def verify_user_name(user_name)
    if user_name != USERNAME 
        puts "Invalid username."
        exit
    end
end

def prompt_user_for_password
    print "Enter password: "
    gets.chomp
end

def verify_user_password(user_password)
    if user_password != PASSWORD
        puts "Invalid password."
        exit
    end
end

def greet_user(user_name)
    puts "Hello, #{user_name}"
    puts "What would you like to do?"
end

def menu_options
    puts "1. Add new service credentials."
    puts "2. Retrieve an existing service's credentials."
    puts "3. Exit."
end

def get_user_menu_selection
    gets.chomp
end 

def handle_user_selection(user_selection)
    case user_selection
    when "1"
        
        new_service = set_new_service_name
        set_username_for(new_service)
        set_password_for(new_service)
        
        credentials_of_new_service = retrieve_service_credentials_for(new_service)
        display_service_credentials(credentials_of_new_service, new_service)
    when "2"
        requested_service_name = retrieve_service_name
        credentials = retrieve_service_credentials_for(requested_service_name)

        display_service_credentials(credentials, requested_service_name)
    else 
        exit_program
    end
end

def set_new_service_name
    print "Enter the name of the service: "
    new_service = gets.chomp.to_sym
    PASSWORD_VAULT[new_service.to_sym] = {}
    new_service
end

def set_username_for(service)
    print "Enter the username for this new service: "
    new_service_username = gets.chomp
    PASSWORD_VAULT[service.to_sym][:username] = new_service_username
end

def set_password_for(service)
    print "Enter the password for this new service: "
    new_service_password = gets.chomp
    PASSWORD_VAULT[service.to_sym][:password] = new_service_password
end

def retrieve_service_name
    print "Please enter the name of the service you wish to access credentials for: "
    gets.chomp
end

def retrieve_service_credentials_for(service)
    PASSWORD_VAULT[service.to_sym]
end

def display_service_credentials(credentials, service_name)
    puts "Here are the credentials for [#{service_name}]"
        
    credentials.each do |key, value|
        puts "#{key}: #{value}"
    end 
end

def exit_program
    puts "Exiting the program. Goodbye."
    exit
end

#--------------------------MAIN------------------------------

welcome_message

username = prompt_user_for_name
verify_user_name(username)

password = prompt_user_for_password
verify_user_password(password)

greet_user(username)

loop do
    menu_options
    handle_user_selection(get_user_menu_selection)
end