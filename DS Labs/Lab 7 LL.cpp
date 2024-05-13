//i201764
//Musharib

#include <iostream>
#include <string>

using namespace std;

//struct Employee {
//    string EmpID;
//    string CNIC;
//    string JoiningDate;
//    int Salary;
//    int Bonus;
//    Employee* next;
//};
//
//class EmployeeList {
//private:
//    Employee* head;
//    Employee* previous;
//
//public:
//    EmployeeList() {
//        head = NULL;
//        previous = NULL;
//    }
//
//    EmployeeList(const EmployeeList& other) {
//        head = NULL;
//        previous = NULL;
//        Employee* temp = other.head;
//        while (temp != NULL) {
//            Insert(temp->EmpID, temp->CNIC, temp->JoiningDate, temp->Salary, temp->Bonus);
//            temp = temp->next;
//        }
//    }
//
//    bool IsEmpty() {
//        return head == NULL;
//    }
//
//    void Insert(string empID, string cnic, string joiningDate, int salary,int bonus ) {
//        Employee* emp = new Employee;
//        emp->EmpID = empID;
//        emp->CNIC = cnic;
//        emp->JoiningDate = joiningDate;
//        emp->Salary = salary;
//        emp->Bonus = bonus;
//        emp->next = NULL;
//
//        if (head == NULL) {
//            head = emp;
//            previous = emp;
//        }
//        else {
//            previous->next = emp;
//            previous = emp;
//        }
//    }
//
//    Employee* Search(string empID) {
//        Employee* temp = head;
//        while (temp != NULL) {
//            if (temp->EmpID == empID) {
//                return temp;
//            }
//            temp = temp->next;
//        }
//        return NULL;
//    }
//
//    void Remove(string empID) {
//        if (head == NULL) {
//            return;
//        }
//        Employee* temp = head;
//        Employee* prev = NULL;
//        while (temp != NULL) {
//            if (temp->EmpID == empID) {
//                if (temp == head) {
//                    head = temp->next;
//                }
//                else {
//                    prev->next = temp->next;
//                }
//                delete temp;
//                return;
//            }
//            prev = temp;
//            temp = temp->next;
//        }
//    }
//
//    void UpdateSalary(string empID, int salary) {
//        Employee* emp = Search(empID);
//        if (emp != NULL) {
//            emp->Salary = salary;
//        }
//    }
//
//    Employee* MaximumSalary() {
//        if (head == NULL) {
//            return NULL;
//        }
//        Employee* temp = head;
//        Employee* maxEmp = temp;
//        while (temp != NULL) {
//            if (temp->Salary > maxEmp->Salary) {
//                maxEmp = temp;
//            }
//            temp = temp->next;
//        }
//        return maxEmp;
//    }
//
//    void Print() {
//        Employee* temp = head;
//        while (temp != NULL) {
//            cout << "EmpID: " << temp->EmpID << endl;
//            cout << "CNIC: " << temp->CNIC << endl;
//            cout << "Joining Date: " << temp->JoiningDate << endl;
//            cout << "Salary: " << temp->Salary << endl;
//            cout << "Bonus: " << temp->Bonus << endl << endl;
//            temp = temp->next;
//        }
//    }
//};
//
//int main() {
//    EmployeeList empList;
//    empList.Insert("1", "12345-5454542-1", "01/10/2000", 50000, 5000);
//    empList.Insert("2", "23456-2842575-1", "02/10/2000", 60000, 6000);
//    empList.Insert("3", "24875-1865412-1", "03/10/2000", 70000, 7000);
//    empList.Print();
//
//    Employee* maxEmp = empList.MaximumSalary();
//    cout << "Employee with Maximum Salary: " << maxEmp->EmpID << endl << endl;
//
//    empList.Remove("2");
//    empList.UpdateSalary("3", 75000);
//    empList.Print();
//
//    return 0;
//}


/*Task 2*/


// Node class for the circular linked list
class Node {
public:
    int data;
    Node* next;

    Node(int data) {
        this->data = data;
        this->next = nullptr;
    }
};

// Function to create a circular linked list with N nodes
Node* createList(int N) {
    Node* head = nullptr;
    Node* tail = nullptr;

    for (int i = 1; i <= N; i++) {
        Node* node = new Node(i);

        if (head == nullptr) {
            head = node;
        }
        else {
            tail->next = node;
        }

        tail = node;
    }

    tail->next = head;

    return head;
}

// Function to solve the Josephus problem for a given M and N
int solveJosephus(int M, int N) {
    Node* head = createList(N);
    Node* current = head;
    Node* prev = nullptr;

    // Find the last remaining node
    while (current->next != current) {
        // Find the Mth node
        for (int i = 0; i < M; i++) {
            prev = current;
            current = current->next;
        }

        // Remove the Mth node
        prev->next = current->next;
        delete current;
        current = prev->next;
    }

    int winner = current->data;
    delete current;

    return winner;
}

int main() {
    int M, N;

    int winner = solveJosephus(2, 6);
    int winner2 = solveJosephus(1, 5);
    int winner3 = solveJosephus(3, 9);
    cout << winner << endl;
    cout << winner2 << endl;
    cout << winner3 << endl;

    return 0;
}
