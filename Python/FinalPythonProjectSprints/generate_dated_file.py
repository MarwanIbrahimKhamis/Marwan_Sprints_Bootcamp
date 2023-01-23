from datetime import datetime


def create_dated_file():
    file_name = open("ContactBook.csv", "r")
    file_name_dated = open("ContactBook_"+datetime.now().strftime("%d%m%Y")+".csv", "w")
    line = file_name.read()
    file_name_dated.write(str(line))
    file_name.close()
    file_name_dated.close()


# create_dated_file()
