def is_balanced(string):
    brackets = ['()', '{}', '[]']
    while any(x in string for x in brackets):
        for br in brackets:
            string = string.replace(br, '')
    return not string


for i in range(int(input("please enter the number of brackets strings you want to check "))):
    print("YES" if is_balanced((input("please enter the brackets string you want to check ")).strip()) else "NO")
