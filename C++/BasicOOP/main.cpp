#include <iostream>
#include <string>
#include <stdlib.h>
using namespace std;


class Person {
    private:
        string name;
        int age;
    public: 
        string getName() { return name; }
        int getAge() { return age; }
        Person(string n = "Georges", int a = 52) : name(n), age(a) {}
        
};

class Organization {
    private:
        string name;
        int size; // actual size of the org
        int dim;  // max size of the org
        Person* members; // list of members
        
    public: 
        string getMemberNames() {
            string memberNames = "";
    
            for (int i = 0; i < size; i++) {
                memberNames += members[i].getName() + "; ";
            }
    
            return memberNames;
        }
        
        void addPerson(Person person) {
            
            if (size >= dim) {
                dim *= 2;
                Person* resizedMembers = new Person[dim];
                
                for (int i = 0; i < size; i++) {
                    resizedMembers[i] = members[i];
                }
        
                delete[] members;
                members = resizedMembers;
            }
            
            members[size++] = person; 
        }
        
        Organization(string n = "uOttawa", int d = 100) : name(n), dim(d), size(0) {
            members = new Person[dim];
        }
        
        // Copy constructeur
        Organization(const Organization& org) : name(org.name), size(org.size), dim(org.dim) { 
            members = new Person[dim];
            for (int i=0; i<size; i++) {
                members[i]= org.members[i];
            } 
        }
        
        // Destructeur
        ~Organization() {
            delete[] members; 
        }
};


// prints all members of an organization to std::cout
void printMembers(Organization& organization) {
   cout << organization.getMemberNames() << "\n" << endl;
}

    
int main()
{
    Person p; //create a Person instance
    Organization org; //create an Organization instance
    
    org.addPerson(p); // add p to org
    cout<< "org contains: "<<endl;
    printMembers(org);
    
    // here we will add 250 persons to org
    for (int i =0 ; i<250; i++)
    {
        Person person("Person"+std::to_string(i), rand()% 30 +16); // create  a Person instance with the name "Person+i" and a random age
        org.addPerson(person);
    }
    cout<<endl<< "Original org contains: "<<endl;
    printMembers(org);
    
    Organization orgCopy = org;
    cout<<endl<< "orgCopy contains: "<<endl;
    printMembers(orgCopy);
    
    return 0;
}

