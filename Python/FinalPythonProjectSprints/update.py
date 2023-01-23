from datetime import datetime
from csv import DictWriter
# from inputs import book_inputs


def updated_data():
    # remove a line containing a string

    with open("ContactBook.csv", 'r') as file:
        lines = file.readlines()

    with open("ContactBook.csv", 'w', newline="") as file:
        update_user_data = ","+input("please enter username to update data: ")+","
        for line in lines:
            # find() returns -1 if no match is found
            if line.find(update_user_data) != -1:
                insertion_date = str(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
                email = input("Please enter Email: ")
                phonenumbers = str(list(input("Please enter Phonenumbers separated by ',': ").split(",")))
                address = input("Please enter Address: ")
                file.write(insertion_date+update_user_data+email+","+phonenumbers+","+address+"\n")
            else:
                file.write(line)


# updated_data()


def add_data(added_data):
    field_names = ['Insertion date', 'Username', 'Email', 'Phonenumbers', 'Address']
    with open("ContactBook.csv", 'a', newline="") as csvfile:
        # Pass the file object and a list
        # of column names to DictWriter()
        # You will get a object of DictWriter
        writer = DictWriter(csvfile, fieldnames=field_names)

        # Pass the dictionary as an argument to the Writerow()
        for data in added_data:
            writer.writerow(data)

        # Close the file object
        csvfile.close()


# add_data(book_inputs())
