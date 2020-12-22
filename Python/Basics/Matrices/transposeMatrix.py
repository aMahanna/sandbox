print("Call 'transpose[mat]', for mat a matrix")
def transpose(mat):
    a = []
    for row in range(len(mat[0])):
        b = []
        for col in range(len(mat)):
            temp = mat[col][row]      
            b.append(temp)

        a.append(b)

    return a
                     
        

        
            
            



            
            







        


            
    
    

