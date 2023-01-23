from datetime import datetime


def book_inputs():
    contacts_book_list = []
    inputs_loop_index = "y"

    while inputs_loop_index == "y":
        contact_inputs = {"Insertion date": "", "Username": "", "Email": "", "Phonenumbers": [], "Address": ""}
        contact_inputs["Insertion date"] += str(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
        contact_inputs["Username"] += input("Please enter username: ")
        contact_inputs["Email"] += input("Please enter Email: ")
        contact_inputs["Phonenumbers"] += list(input("Please enter Phonenumbers separated by ',': ").split(","))
        contact_inputs["Address"] += input("Please enter Address: ")
        contacts_book_list.append(contact_inputs)
        inputs_loop_index = input("Do you want to enter another contact? (y/n) ")

    return contacts_book_list


# print(book_inputs())
