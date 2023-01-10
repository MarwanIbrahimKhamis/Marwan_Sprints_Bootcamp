import calendar


def is_leap(year):
    return calendar.isleap(year)


x = "y"

while x == "y":
    print(is_leap(int(input("please enter the year to check whether a leap year or not "))))
    x = input("Do you want another check?(y/n) ")
