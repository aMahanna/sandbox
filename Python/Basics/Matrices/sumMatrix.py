print("Call 'sumMatrix[matA, matB]' for matA and matB two matrixes of same size")
def sumMatrix(matA, matB):
    matC = [] # Initializes final matrix
    for row in range(len(matA)):
        tempMat = [] # Temp matrix to store sums
        for col in range(len(matA[0])):
            tempSum = matA[row][col] + matB[row][col]

            tempMat.append(tempSum)
        matC.append(tempMat)

    return matC
            
            
        
