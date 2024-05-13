//Musharib Nadeem
//i201764

#include <iostream>
#include <string>
using namespace std;

class DoubleLinkedList {
private:
    struct Node {
        char data;
        Node* prev;
        Node* next;
        Node(char c) {
            data = c;
            prev = nullptr;
            next = nullptr;
        }
    };


    Node* head;
    Node* tail;

public:
    DoubleLinkedList() : head(nullptr), tail(nullptr) {}

    void push(char c) {
        Node* newNode = new Node(c);
        if (head == nullptr) {
            head = newNode;
            tail = newNode;
        }
        else {
            tail->next = newNode;
            newNode->prev = tail;
            tail = newNode;
        }
    }
    char top() {
        if (head == nullptr) {
            throw std::runtime_error("Stack is Empty");
        }
        return head->data;
    }
    string pop() {
        if (head == nullptr) {
            return "";
        }
        char data = tail->data;
        Node* prevNode = tail->prev;
        if (prevNode != nullptr) {
            prevNode->next = nullptr;
        }
        else {
            head = nullptr;
        }
        delete tail;
        tail = prevNode;
        return std::string(1, data);
    }

    bool is_empty() {
        return head == nullptr;
    }
};


//infix_to_postfix_A function
int infix_to_postfix_A(const string& infix, char* output_stack, DoubleLinkedList& operator_stack) {
    int pos = 0; 

    for (char c : infix) {
        if (isalnum(c)) {
            output_stack[pos++] = c;
        }
        else if (c == '(') {
            string s(1, c); 
            operator_stack.push(c);
        }
        else if (c == ')') {
            while (!operator_stack.is_empty() && operator_stack.pop() != "(") {
                string temp = operator_stack.pop();
                output_stack[pos++] = temp[0]; 
            }
            operator_stack.pop(); 
        }
        else {
            string s(1, c);
            while (!operator_stack.is_empty() && operator_stack.pop() != "(" && operator_stack.pop() != ")") {
                string temp = operator_stack.pop();
                output_stack[pos++] = temp[0]; 
            }
            operator_stack.push(c);
        }
    }

    while (!operator_stack.is_empty()) {
        string temp = operator_stack.pop();
        output_stack[pos++] = temp[0];
    }

    return pos; 
}

/*D part */
int postfix_evaluation(const string& postfix, const int values[]) {
    DoubleLinkedList operand_stack; 
    for (char c : postfix) {
        if (isalpha(c)) {
            int index = c - 'A'; 
            int value = values[index]; 
            operand_stack.push(value); 
        }
        else if (c == '+' || c == '-' || c == '*' || c == '/' || c == '%') {
            int operand2 = operand_stack.top();
            operand_stack.pop();
            int operand1 = operand_stack.top();
            operand_stack.pop();
            int result;
            switch (c) {
            case '+':
                result = operand1 + operand2;
                break;
            case '-':
                
                result = operand1 - operand2;
                break;
            case '*':
                result = operand1 * operand2;
                break;
            case '/':
              
                result = operand1 / operand2;
                break;
            case '%':
               
                result = operand1 % operand2;
                break;
            }
            operand_stack.push(result);
        }
    }

    int answer = operand_stack.top();
    operand_stack.pop();
    return answer;
}






//#include <iostream>
//#include <fstream>
//#include <string>
//#include <stack>
//#include <queue>
//
//using namespace std;
//
//// Node class to represent a line of text
//class Node {
//public:
//    string data;
//    Node* next;
//    Node(string line) : data(line), next(nullptr) {}
//};
//
//// Text Processing Software (TPS) class
//class TPS {
//private:
//    Node* head; // Head of the linked list
//    stack<string> undoStack; // Stack to store undo operations
//    stack<string> redoStack; // Stack to store redo operations
//    queue<string> megaUndoQueue; // Queue to store mega undo operations
//
//public:
//    // Constructor
//    TPS() : head(nullptr) {}
//
//    // Function to append a line to the end of the linked list
//    void append(string line) {
//        Node* newNode = new Node(line);
//        if (head == nullptr) {
//            head = newNode;
//        }
//        else {
//            Node* temp = head;
//            while (temp->next != nullptr) {
//                temp = temp->next;
//            }
//            temp->next = newNode;
//        }
//        cout << "Line appended: " << line << endl;
//        undoStack.push(line); // Add the line to undo stack
//        while (!redoStack.empty()) {
//            redoStack.pop(); // Clear redo stack after appending a new line
//        }
//    }
//
//    // Function to display the content of the linked list
//    void display() {
//        Node* temp = head;
//        while (temp != nullptr) {
//            cout << temp->data << endl;
//            temp = temp->next;
//        }
//    }
//
//    // Function to perform undo operation
//    void undo() {
//        if (!undoStack.empty()) {
//            string line = undoStack.top();
//            undoStack.pop();
//            redoStack.push(line); // Add the line to redo stack
//            megaUndoQueue.push(line); // Add the line to mega undo queue
//            cout << "Undo performed: " << line << endl;
//            if (head != nullptr) {
//                Node* temp = head;
//                while (temp->next != nullptr && temp->next->data != line) {
//                    temp = temp->next;
//                }
//                if (temp->next != nullptr && temp->next->data == line) {
//                    Node* delNode = temp->next;
//                    temp->next = temp->next->next;
//                    delete delNode;
//                }
//            }
//        }
//        else {
//            cout << "Nothing to undo." << endl;
//        }
//    }
//
//    // Function to perform redo operation
//    void redo() {
//        if (!redoStack.empty()) {
//            string line = redoStack.top();
//            redoStack.pop();
//            undoStack.push(line); // Add the line to undo stack
//            cout << "Redo performed: " << line << endl;
//            if (head == nullptr) {
//                head = new Node(line);
//            }
//            else {
//                Node* temp = head;
//                while (temp->next != nullptr) {
//                    temp = temp->next;
//                }
//                temp->next = new Node(line);
//            }
//        }
//        else {
//            cout << "Nothing to redo." << endl;
//        }
//    }
//
//                // Function to perform mega undo operation
//                void megaUndo(int n) {
//                    if (!megaUndoQueue.empty()) {
//                        if (n > megaUndoQueue.size()) {
//                            cout << "Number of lines to undo is greater than available lines. Performing mega undo for all lines." << endl;
//                            n = megaUndoQueue.size();
//                        }
//                        cout << "Performing mega undo for " << n << " lines:" << endl;
//                        for (int i = 0; i < n; i++) {
//                            string line = megaUndoQueue.front();
//                            megaUndoQueue.pop();
//                            cout << "Undo performed: " << line << endl;
//                            if (head == nullptr) {
//                                head = new Node(line);
//                            }
//                            else {
//                                Node* temp = head;
//                                while (temp->next != nullptr) {
//                                    temp = temp->next;
//                                }
//                                temp->next = new Node(line);
//                            }
//                        }
//                        undoStack.push("MEGA UNDO"); // Add a special marker to undo stack for mega undo operation
//                        while (!redoStack.empty()) {
//                            redoStack.pop(); // Clear redo stack after performing mega undo
//                        }
//                    }
//                    else {
//                        cout << "Nothing to perform mega undo." << endl;
//                    }
//                }
//            };
//
//            // Driver code
//            int main() {
//                TPS tps;
//                int choice;
//                string line;
//                int n;
//
//                while (true) {
//                    cout << "Text Processing Software (TPS)" << endl;
//                    cout << "1. Append a line" << endl;
//                    cout << "2. Display content" << endl;
//                    cout << "3. Undo" << endl;
//                    cout << "4. Redo" << endl;
//                    cout << "5. Mega Undo" << endl;
//                    cout << "6. Exit" << endl;
//                    cout << "Enter your choice: ";
//                    cin >> choice;
//
//                    switch (choice) {
//                    case 1:
//                        cout << "Enter a line to append: ";
//                        cin.ignore();
//                        getline(cin, line);
//                        tps.append(line);
//                        break;
//                    case 2:
//                        cout << "Content of the linked list:" << endl;
//                        tps.display();
//                        break;
//                    case 3:
//                        tps.undo();
//                        break;
//                    case 4:
//                        tps.redo();
//                        break;
//                    case 5:
//                        cout << "Enter number of lines to perform mega undo: ";
//                        cin >> n;
//                        tps.megaUndo(n);
//                        break;
//                    case 6:
//                        cout << "Exiting..." << endl;
//                        return 0;
//                    default:
//                        cout << "Invalid choice. Please try again." << endl;
//                    }
//                }
//
//                return 0;
//            }
