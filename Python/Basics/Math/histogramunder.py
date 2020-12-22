def histogramunder(charChain):
    letters = {}

    for char in charChain:
        letters[char] = letters.get(char, 0) + 1

    letterList = list(letters.items())
    letterList.sort()

    return letterList

text = input(str("Insert a string: "))
print(histogramunder(text))

