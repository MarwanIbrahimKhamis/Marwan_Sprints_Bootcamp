def is_leap(year):
    return ((year % 4 == 0) and (year % 100 != 0)) or (year % 400 == 0)


x = "y"

while x == "y":
    print(is_leap(int(input("please enter the year to check whether a leap year or not "))))
    x = input("Do you want another check?(y/n) ")
