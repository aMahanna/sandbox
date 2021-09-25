#include <memory>
#include <vector>
#include <list>
#include <iostream>
#include "Person.h"
#include "Organization.h"


int main() {
    
    std::cout << "Debut:\n";
    
    // les personnes sont dans un std::vector    
    std::vector<std::shared_ptr<Person> > p;
    p.push_back(std::make_shared<Person>("Aymen",19));
    p.push_back(std::make_shared<Person>("Milena",20));
    p.push_back(std::make_shared<Person>("Robert",25));

    // les organisations sont dans une std::liste
    std::list<std::shared_ptr<Organization> > o;
    
    o.push_front(std::make_shared<Organization>("Centraide"));
    inscription(o.front(), p[0]);
    inscription(o.front(), p[1]);
    inscription(o.front(), p[2]);

    o.push_front(std::make_shared<Organization>("Nez Rouge"));
    inscription(o.front(), p[0]);
    inscription(o.front(), p[1]);

    o.push_front(std::make_shared<Organization>("Popotte volante"));
    inscription(o.front(), p[2]);

    // on imprime les personnes et leurs organisations
    std::cout << "1)\n";
    for (auto ptr: p)
        std::cout << *ptr << std::endl;

    // on retire une personne d'une organisation        
    p[1]->removeOrganization("Centraide");
    o.back()->removeMember(p[1]->getName());

    // on imprime les personnes et leurs organisations
    std::cout << "2)\n";
    for (auto ptr: p)
        std::cout << *ptr << std::endl;
    
    // Le erase retire une organisation de la liste
    // Lorsqu'une organisation disparait de la liste, 
    // tous les membres de cette organisation sont automatiquement desinscrits.
    // Ceci doit automatiquement être géré par les pointeurs intelligents
    o.erase(o.begin());
    
     // on imprime les personnes et leurs organisations
    std::cout << "3)\n";
    for (auto ptr: p)
        std::cout << *ptr << std::endl;
        
    std::cout << "Fin.\n";
    
    return 0;
}

/*--------------- résultat ------------------------*\
Debut:
1)
Aymen 2[Centraide Nez Rouge ]
Milena 2[Centraide Nez Rouge ]
Robert 2[Centraide Popotte volante ]
2)
Aymen 2[Centraide Nez Rouge ]
Milena 1[Nez Rouge ]
Robert 2[Centraide Popotte volante ]
Popotte volante(1) detruit
3)
Aymen 2[Centraide Nez Rouge ]
Milena 1[Nez Rouge ]
Robert 1[Centraide ]
Fin.
Nez Rouge(2) detruit
Centraide(2) detruit
Aymen (19) detruit
Milena (20) detruit
Robert (25) detruit

\*-------------------------------------------------*/


