
#ifndef Person_H_
#define Person_H_
#include "Organization.h"
#include <memory>
#include <vector>
#include <iostream>
#include <string>  
#include <sstream> 


class Organization;

class Person {

    std::string name;
    int age;
    int size; 

    // un vecteur de pointeurs intelligents à des organisations
    std::vector<std::weak_ptr<Organization> > organizations; // weak_ptr  

  public:

    Person(std::string n, int a) : name(n),age(a), size(0){}
    ~Person();
    
    // ajouter une organisation
    // L'organization est ajouté sous forme de weak_ptr
    void addOrganization(std::weak_ptr<Organization> organization);
    // retirer une organisation (en spécifiant son nom)
    void removeOrganization(std::string org);

    int getNumberofOrganizations() const {return size;}
    std::string getName() const {return name;}
    int getAge() const {return age;}
    
    const std::string toString() const; // Méthode toString() ajouté

};

// L'ajout de l'opérateur "<<" nous permet d'écrire "cout << *ptr" 
// Où "ptr" est un shared_ptr qui pointe à une isntance de Person
inline std::ostream& operator<<(std::ostream &gauche, const Person &droit) { 
    gauche << droit.toString();
    return gauche;
}

#endif 