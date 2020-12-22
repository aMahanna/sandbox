values = input("Insert all your marks: ")

marks = list(eval(values))

def computeStats(marks):
    sum = 0
    for elements in marks:
        sum += elements

    if (elements > 100 or elements < 0):
        print("Error, your marks can only be between 0% and 100%")

    else:
        
        average = round((sum / len(marks)))
        topGrade = max(marks)
        bottomGrade = min(marks)
        results = [average, topGrade, bottomGrade]
        print("You average, highest grade and lowest grade are as follows" + "\n",results)

call = computeStats(marks)
