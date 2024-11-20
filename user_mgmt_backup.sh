#!/bin/bash

# Function to display the menu
function display_menu() {
    echo "====================================="
    echo "User Management and Backup Script"
    echo "====================================="
    echo "1. Add User"
    echo "2. Delete User"
    echo "3. Modify User"
    echo "4. Create Group"
    echo "5. Add User to Group"
    echo "6. Backup Directory"
    echo "7. Exit"
    echo "====================================="
    echo -n "Enter your choice: "
}

# Function to add a user
function add_user() {
    echo -n "Enter the username to add: "
    read username
    sudo useradd "$username" && echo "User '$username' added successfully." || echo "Failed to add user '$username'."
}

# Function to delete a user
function delete_user() {
    echo -n "Enter the username to delete: "
    read username
    sudo userdel "$username" && echo "User '$username' deleted successfully." || echo "Failed to delete user '$username'."
}

# Function to modify a user
function modify_user() {
    echo -n "Enter the username to modify: "
    read username
    echo "Options: "
    echo "1. Change username"
    echo "2. Change shell"
    echo "3. Change home directory"
    echo -n "Choose an option: "
    read option
    case $option in
        1)
            echo -n "Enter the new username: "
            read new_username
            sudo usermod -l "$new_username" "$username" && echo "Username changed successfully." || echo "Failed to change username."
            ;;
        2)
            echo -n "Enter the new shell: "
            read shell
            sudo usermod -s "$shell" "$username" && echo "Shell changed successfully." || echo "Failed to change shell."
            ;;
        3)
            echo -n "Enter the new home directory: "
            read home_dir
            sudo usermod -d "$home_dir" -m "$username" && echo "Home directory changed successfully." || echo "Failed to change home directory."
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
}

# Function to create a group
function create_group() {
    echo -n "Enter the group name to create: "
    read groupname
    sudo groupadd "$groupname" && echo "Group '$groupname' created successfully." || echo "Failed to create group '$groupname'."
}

# Function to add a user to a group
function add_user_to_group() {
    echo -n "Enter the username: "
    read username
    echo -n "Enter the group name: "
    read groupname
    sudo usermod -a -G "$groupname" "$username" && echo "User '$username' added to group '$groupname' successfully." || echo "Failed to add user to group."
}

# Function to backup a directory
function backup_directory() {
    echo "Enter the directory to backup:"
    read directory
    echo "Enter the backup destination directory:"
    read destination
    sudo tar -czvf $destination/backup_$(date +%F).tar.gz $directory
    echo "Backup of $directory completed."
}
 

# Main script
while true; do
    display_menu
    read choice
    case $choice in
        1)
            add_user
            ;;
        2)
            delete_user
            ;;
        3)
            modify_user
            ;;
        4)
            create_group
            ;;
        5)
            add_user_to_group
            ;;
        6)
            backup_directory
            ;;
        7)
            echo "Exiting script. Goodbye!"
            break
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done


