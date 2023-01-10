def mutate_string(string, pos, ch):
    string_list = list(string)
    string_list[pos] = ch
    string = ''.join(string_list)
    print(string)


x = "y"

while x == "y":
    mutate_string(str(input("please enter the string ")),
                  int(input("please enter the character index you want to change ")),
                  str(input("please enter the new character  ")))
    x = input("Do you want another check?(y/n) ")
