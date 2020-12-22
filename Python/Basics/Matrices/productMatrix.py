print("Call 'productMatrix[matA, matB]' for matA and matB two matrixes")
print("Example: productMatrix([[1,2,3],[4,5,6]], [[1,2],[3,4],[5,6]])")
def productMatrix(matA, matB):

    matC = []
    for x in range (len(matA)): # Loop to create an empty array of the proper dimensions
        tempMat = []
        for y in range (len(matB[0])):
            tempMat.append(0)
            
        matC.append(tempMat)
    
    for i in range(len(matA)):
        for j in range(len(matB[0])):
            for p in range(len(matB)):
                matC[i][j] += matA[i][p] * matB[p][j] # Fills the empty array
                
    return matC
            
            
        
