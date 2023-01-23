
def deleted_data():
    # remove a line containing a string

    with open("ContactBook.csv", 'r') as file:
        lines = file.readlines()

    with open("ContactBook.csv", 'w', newline="") as file:
        delete_user_data = ","+input("please enter username to delete data: ")+","
        for line in lines:
            # find() returns -1 if no match is found
            if line.find(delete_user_data) != -1:
                pass
            else:
                file.write(line)


# deleted_data()
