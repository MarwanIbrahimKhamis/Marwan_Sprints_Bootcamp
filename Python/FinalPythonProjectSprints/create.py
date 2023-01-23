# importing the csv module
import csv
# from inputs import book_inputs

# my data rows as dictionary objects
'''
contacts_book_list = [{'Entry date': '2023-01-19 14:47:32.045357', 'Username': 'hdggd', 'Email': 'kajan',
                       'Phonenumbers': ['1234'], 'Address': 'dff'},
                      {'Entry date': '2023-01-19 14:47:40.578324', 'Username': 'dsfr', 'Email': 'vrgttg',
                       'Phonenumbers': ['3214324', '235243534'], 'Address': 'dsgfsg'},
                      {'Entry date': '2023-01-19 14:47:40.578324', 'Username': 'dsfrg', 'Email': 'vrgttg',
                       'Phonenumbers': ['3214324', '235243534'], 'Address': 'dsgfsg'}]
'''


def create_file(file_data):
    # name of csv file
    filename = "ContactBook.csv"

    # writing to csv file
    with open(filename, 'w', newline="") as csvfile:
        # creating a csv dict writer object
        writer = csv.DictWriter(csvfile, fieldnames=file_data[0].keys())

        # writing headers (field names)
        writer.writeheader()

        # writing data rows
        writer.writerows(file_data)
        csvfile.close()


# create_file(book_inputs())
