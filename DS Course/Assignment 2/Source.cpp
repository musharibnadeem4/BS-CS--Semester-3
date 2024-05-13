//Musharib Nadeem
//20i-1764 .
#include <iostream>
using namespace std;

class student_Node {
public:
    string data;
    student_Node* next;
    student_Node(string data) {
        this->data = data;
        this->next = NULL;
    }
};

// Function to insert a new node at the end of the linked list
void insert(student_Node*& head, string data) {
    student_Node* new_node = new student_Node(data);
    new_node->next = NULL;
    if (head == NULL) {
        head = new_node;
    }
    else {
        student_Node* current = head;
        while (current->next != NULL) {
            current = current->next;
        }
        current->next = new_node;
    }
}
string* list_of_all_students(student_Node*& head1, student_Node*& head2, student_Node*& head3)
{
    
    const int MAX_STUDENTS = 1000; 
    string* result = new string[MAX_STUDENTS];
    int num_students = 0; 

   
    student_Node* current = head1;
    while (current != nullptr)
    {
        bool is_unique = true;
        
        for (int i = 0; i < num_students; i++)
        {
            if (result[i] == current->data)
            {
                is_unique = false;
                break;
            }
        }
        if (is_unique)
        {
            result[num_students] = current->data;
            num_students++;
        }
        current = current->next;
    }

    current = head2;
    while (current != nullptr)
    {
        bool is_unique = true;
        for (int i = 0; i < num_students; i++)
        {
            if (result[i] == current->data)
            {
                is_unique = false;
                break;
            }
        }
        
        if (is_unique)
        {
            result[num_students] = current->data;
            num_students++;
        }
        current = current->next;
    }

    current = head3;
    while (current != nullptr)
    {
        bool is_unique = true;
       
        for (int i = 0; i < num_students; i++)
        {
            if (result[i] == current->data)
            {
                is_unique = false;
                break;
            }
        }
       
        if (is_unique)
        {
            result[num_students] = current->data;
            num_students++;
        }
        current = current->next;
    }

    return result;
}

string* list_common_student_society(student_Node*& head1, student_Node*& head2, student_Node*& head3)
{
    string* result = new string[6];
    int index = 0;
    student_Node* curr = head1;
    while (curr != NULL) {
        student_Node* curr2 = head2;
        while (curr2 != NULL) {
            if (curr->data == curr2->data) {
                student_Node* curr3 = head3;
                while (curr3 != NULL) {
                    if (curr->data == curr3->data) {
                        result[index++] = curr->data;
                        break;
                    }
                    curr3 = curr3->next;
                }
                break;
            }
            curr2 = curr2->next;
        }
        curr = curr->next;
    }
    return result;
}

void print_list(student_Node* head) {
    student_Node* curr = head;
    while (curr != NULL) {
        cout << curr->data << " ";
        curr = curr->next;
    }
    cout << endl;
}
int main() {
    student_Node* FGC_List = NULL;
    student_Node* FAS_List = NULL;
    student_Node* FDS_List = NULL;
    string* result = nullptr;

    insert(FGC_List, "Ali");
    insert(FGC_List, "Maryam");
    insert(FGC_List, "Usman");
    insert(FGC_List, "Masooma");
    insert(FGC_List, "Haider");
    insert(FGC_List, "Urooj");

    insert(FAS_List, "Ashiq");
    insert(FAS_List, "Maryam");
    insert(FAS_List, "Manika");
    insert(FAS_List, "Ali");
    insert(FAS_List, "Masooma");
    insert(FAS_List, "Urooj");

    insert(FDS_List, "Bila");
    insert(FDS_List, "Rohail");
    insert(FDS_List, "Amna");
    insert(FDS_List, "Madiha");
    insert(FDS_List, "Masooma");
    insert(FDS_List, "Urooj");

    print_list(FDS_List);

    cout << "List of All Students" << endl;

    result = list_of_all_students(FGC_List, FAS_List, FDS_List);
    for (int i = 0; i < 18; i++) {
        if (!result[i].empty()) {
            cout << result[i] << endl;
        }
    }

    cout << "List of All Common Students" << endl;

    result = list_common_student_society(FGC_List, FAS_List, FDS_List);
    for (int i = 0; i < 6; i++) {
        if (!result[i].empty()) {
            cout << result[i] << endl;
        }
    }
    
        
}
