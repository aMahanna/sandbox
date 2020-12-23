#include "Person.h" 
#include "Organization.h"
#include "OrganizationPayante.h"
#include <sstream>      

Person::Person(string n, int a)  {
        name = n;
        age = a;
        size = 0;
};

void Person::addOrganization(Organization* organization) {
        
        if (size == 5) {
            throw out_of_range("A Person cannot belong to more than 5 organizations"); 
        
        } else {
            orgPointers[size++] = organization; 
        }
}

float Person::getAPayer() {
    OrganizationPayante* temp;
    float total = 0;
    
    for (int i = 0; i < size; i++) {
        temp = dynamic_cast<OrganizationPayante*>(orgPointers[i]);   
        
        if (temp != nullptr) {
            total += temp->getFrais();
        }
    }

    return total; 
}

// //retourne un string de toutes les noms des organisations payantes en faisant un downcasting 
string Person::printAPayer() {
    OrganizationPayante* temp;
    string message = "";
    
    
    for (int i = 0; i < size; i++) {
        temp = dynamic_cast<OrganizationPayante*>(orgPointers[i]);  
        
        if (temp != nullptr) { 
            stringstream ss;
            ss << temp->getFrais();         
            message += temp->getName() + ": " + ss.str() + "; ";
        }
    }
    return message;
}

// //retourne un string contenant toutes les organisations de la personnne 
string Person::getOrgNames() {
    Organization* temp;
    string message = "";

    for (int i = 0; i < size; i++) {
        temp = orgPointers[i]; 
        message += temp->getName() + ", ";
    }

    return message;
}

int Person::getAge() { return age; }
string Person::getName() { return name; }
int Person::getSize() { return size; }