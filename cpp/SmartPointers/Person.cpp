#include "Person.h"

// à vous de le compléter

Person::~Person() {
    std::cout << name << " (" << age << ") detruit\n";
}

// Le shared_ptr passé à cette méthode est converti en weak_ptr automatiquement
void Person::addOrganization(std::weak_ptr<Organization> organization) { 
    organizations.push_back(organization);         // Ajoute l'organization au vecteur
    size++;                                        // Augmente la taille
}

void Person::removeOrganization(std::string name) {
    std::vector<std::weak_ptr<Organization> >::iterator it; // Itérateur
    
    // Organization Shared_Pointer pour entreposer les valeurs de nos weak_ptr.lock()
    std::shared_ptr<Organization> sp;                       
    
    for (it = organizations.begin(); it != organizations.end(); it++) { // Traverser le vecteur organizations
        sp = (*it).lock();                                  // Déréférencer "it" pour faire appel à lock()
        if (sp) {                                           // Verifie que le pointeur existe bien encore 
           if (sp->getName() == name) {                     
                organizations.erase(it);                    // Si on trouve un match, enlève le weak_ptr
                size--;                                     // à la position "it" de la liste   
                return;
            }
        }
    }
    
    // Si on est ici, alors cette Persone n'est pas dans l'organization "name"
    std::cout << getName() << " n'est pas dans " << name << std::endl;
}

// Méthode toString() pour imprimer l'instance Person et ses organizations
const std::string Person::toString() const {
    std::stringstream ss (std::stringstream::in | std::stringstream::out);  
    ss << name;
    ss << " ["; 
    std::vector<std::weak_ptr<Organization> >::const_iterator it;  // Itérateur
    // Organization Shared_Pointer pour entreposer les valeurs de nos weak_ptr.lock()
    std::shared_ptr<Organization> sp;
    for (it = organizations.begin(); it != organizations.end(); ++it) {
        sp = (*it).lock();                                  // Déréférencer "it" pour faire appel à lock()
        if (sp) {                                           // Verifie que le pointeur existe bien encore
            ss << sp->getName() << " ";                     // Imprime le nom de l'organization
        }
    }
    ss << "]";
    return ss.str();
}


