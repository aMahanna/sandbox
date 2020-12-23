#ifndef PLIST_H
#define PLIST_H

#include <iostream>
using namespace std;

template<typename T>
class PList {
    private:
       int capacity;
       int size;
       int current;
       T** pListArray;
       
       T* get() const { 
           if (current == -1) {
               throw out_of_range("Current is -1, nothing to return");
           } 

           return &(*pListArray[current]);   
       }
       
       void start() { 
           current = size > 0 ? 0 : -1;
       }
       
       void next() { 
           if (current < size - 1) {
               current += 1;
           }  
       }
       
       bool isLast() const {
          return current == (size - 1); 
       }
       
       int getCurrent() const {
          return current; 
       }
       
    public:
        PList(int c): capacity(c),current(-1),size(0),pListArray(new T*[capacity]){}
        PList(): capacity(1),current(-1),size(0),pListArray(new T*[capacity]){} // Default Constructor
        ~PList() { delete[] pListArray; }
    
        void add(T* item) {
          if (isFull()) {
            throw out_of_range("Maximum capacity reached, cannot add item."); 
          }
          pListArray[++current] = item;
          size++;
        }
    
        bool rem(const T *item) {
            start(); // Start from beginning
            
            if (getCurrent() == -1) {
                cout << "PList Error: List is empty" << endl;
                return false; 
            }
            
            // Iterate to target
            while (get() != item) {
                if (isLast()) {
                    return false; 
                }
                
                next(); 
            }

            // Shift elements
            while (getCurrent() < getSize() - 1) {
              pListArray[getCurrent()] = pListArray[getCurrent()+1];
              next(); 
            }
            
            size--;
            current--;
            return true;
        }
        
        T* getItem(const int i) {
            if (i >= size) {
                throw out_of_range("Index i is bigger than PList size");

            } else if (getCurrent() > i) {
                start(); // Only start from beginning if current is ahead
            }
            
            while (getCurrent() != i) {
                next(); // NOTE: Method getItem() is NOT a 'const', since it modifies PList's "current" index
            }
            
            return get();
        }
        
        bool isFull() const {
            return size == capacity;
        }
        
        int getCapacity() const { 
           return capacity; 
        }
        
        int getSize() const { 
           return size; 
        }

        // Overloading operand in order to properly initialize PList objects
        PList& operator=(const PList<T> &p) { 
          capacity= p.getCapacity();
          size = p.getSize();
          pListArray = new T*[capacity];

          if (size != 0) {
            current = 0; 
            while(current != size ) {
                pListArray[current] = p.pListArray[current]; 
                current++;                    
            }
          }

          start();
          return *this; 
        }
};

#endif // PLIST_H