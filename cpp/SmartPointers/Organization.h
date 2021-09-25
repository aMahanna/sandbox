#ifndef OrganizationH
#define OrganizationH 

#include <memory>
#include <vector>
#include <iostream>
#include <string>
#include "Person.h"

// Vous pouvez ajouter autant de code que nécessaire
// Remplacer les ??? par le code manquant
// Le code déjà présent ne doit pas être modifié ou effacé

class Person;

class Organization {
    int size; 
    std::string name;
    // un vecteur de pointeurs intelligents à des personnes
    std::vector<std::shared_ptr<Person> > members; // shared_ptr 

public:

    Organization(std::string n) : name(n), size(0) {}
    ~Organization();
    
    // ajouter une personne
    void addMember(std::shared_ptr<Person> member);
    // retirer une personne en spécifiant son nom
    void removeMember(std::string name);
    
    std::string getName() const {return name;}
    int getNumberOfMembers() const {return size;}
};

// La définition de cette méthode se trouve dans le fichier Organization.cpp
void inscription(std::shared_ptr<Organization> o, std::shared_ptr<Person> p);

#endif 