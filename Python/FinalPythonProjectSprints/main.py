import inputs
import create
import generate_dated_file
import delete
import update


def contact_book_menu():
    options = '0'
    while options != "q":
        options = input("Please choose:\n1: create contact book \t2: generate_dated_backup "
                        "\t3: delete user data\n4: update user data \t5: add contacts     \tq: quit\n")
        if options == '1':
            create.create_file(inputs.book_inputs())
        elif options == '2':
            generate_dated_file.create_dated_file()
        elif options == '3':
            delete.deleted_data()
        elif options == '4':
            update.updated_data()
        elif options == '5':
            update.add_data(inputs.book_inputs())


contact_book_menu()

'''
create.create_file(inputs.book_inputs())

generate_dated_file.create_dated_file()

delete.deleted_data()

update.updated_data()

update.add_data(inputs.book_inputs())
'''
