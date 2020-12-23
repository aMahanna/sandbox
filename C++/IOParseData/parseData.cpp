#include <iostream>
#include <fstream>
#include <string>

using namespace std;

void printData(string fileName);

int main() {

	string fileName;
	cout << "Enter the file name (i.e data.txt): ";
	cin >> fileName;

	printData(fileName);

    return 0;
}

void printData(string fileName) {
	string name;
	string gender;
	string age;
	const string MALE = "m";
	const int MAX_AGE(25);

	int ageInInt(0);
	int totalMales(0);
   
    ifstream data(fileName);
	if (data.is_open()) {
		while (!data.eof()) {
            data >> name >> gender >> age; // Load data
          	ageInInt = stoi(age); // Convert string to integer
          	
            if (gender == MALE && ageInInt > MAX_AGE) { 
            	cout << name << " - " << age << " years" << endl; 
            	totalMales++; 
            }
        }

    	data.close();
    	cout << "\nThere are " << totalMales << " males who are over 25 years old." << endl;

	} else {
		cout << "Unable to find/open file " << fileName << endl;

	}
}

