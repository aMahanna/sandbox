def bcd(a,b):
    
    if(b==0):
        return a
    
    else:
        return bcd(b,a%b)
