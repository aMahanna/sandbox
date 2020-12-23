#include "Organization.h"

Organization::~Organization() {
    std::cout << name << "(" << size << ") detruit\n";  // Destructeur pour la classe Organization
} 

void Organization::addMember(std::shared_ptr<Person> member) {  
    members.push_back(member);                          // Ajoute le membre au vecteur
    size++;                                             // Augmente la taille 
}

void Organization::removeMember(std::string name) {
 	std::vector<std::shared_ptr<Person> >::iterator it; 
    
    // Traverser le vecteur avec un itérateur
    for (it = members.begin(); it != members.end(); ++it) { 
        if ((*it)->getName() == name) {                 
            members.erase(it);                          // Si on trouve un match, enlève le shared_ptr
            size--;                                     // à la position "it" de la liste
            return;
        }
    }
    
    // Si on est ici, alors l'organization ne contient aucun membre "name"
    std::cout << getName() << " n'a aucun membre nommé " << name << std::endl;
}

// Méthode inscription fait appel à addMember et addOrganization
void inscription(std::shared_ptr<Organization> o, std::shared_ptr<Person> p) {
    o->addMember(p);            
    p->addOrganization(o); // Le shared_ptr est convertit à un weak_ptr ici
}
