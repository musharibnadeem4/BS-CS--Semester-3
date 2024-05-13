/*Musharib Nadeem*/
/*20i-1764*/
/*Part 1*/

#include <iostream>
#include <fstream>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

class myNode {
public:
    int data;
    myNode* next;

    myNode(int val) {
        data = val;
        next = NULL;
    }
};
class LinkedList {
public:
    myNode* head;
    LinkedList() {
        head = NULL;
    }

    void insertAtEnd(int data) {
        myNode* newNode = new myNode(0);
        newNode->data = data;
        newNode->next = NULL;

        if (head == NULL) {
            head = newNode;
            return;
        }

        myNode* curr = head;
        while (curr->next != NULL) {
            curr = curr->next;
        }

        curr->next = newNode;
    }
};

class TwoDLinkedList {
public:
    myNode* rowHead;
    TwoDLinkedList* down;
    TwoDLinkedList() {
        rowHead = NULL;
        down = NULL;
    }

    void insertAtEnd(int data) {
        if (rowHead == NULL) {
            rowHead = new myNode(0);
            rowHead->data = data;
            rowHead->next = NULL;
            return;
        }

        myNode* curr = rowHead;
        while (curr->next != NULL) {
            curr = curr->next;
        }

        curr->next = new myNode(0);
        curr->next->data = data;
        curr->next->next = NULL;
    }
    void convertTo2dLL(int** array, int row, int col) {
        // Creating head of the 2D Linked List
        this->rowHead = new myNode(-1);
        this->down = NULL;

        TwoDLinkedList* currRow = this;
        for (int i = 0; i < row; i++) {
            // Creating head of the row linked list
            currRow->rowHead = new myNode(-1);
            myNode* currNode = currRow->rowHead;

            for (int j = 0; j < col; j++) {
                currNode->next = new myNode(array[i][j]);
                currNode = currNode->next;
            }

            currNode->next = new myNode(-1);
            currNode = currNode->next;
            currNode->next = new myNode(-2);
            currNode = currNode->next;

            // Creating the next row of the 2D Linked List
            if (i != row - 1) {
                currRow->down = new TwoDLinkedList();
                currRow = currRow->down;
            }
        }
    }



    // Printing the 2D Linked List
    void print() {
        TwoDLinkedList* curr = this;
        while (curr != NULL) {
            myNode* rowHead = curr->rowHead;
            while (rowHead != NULL) {
                if (rowHead->data == -1) {
                    cout << "-1 ";
                }
                else if (rowHead->data == -2) {
                    cout << "-2 ";
                }
                else {
                    cout << rowHead->data << " ";
                }
                rowHead = rowHead->next;
            }
            cout << endl;
            curr = curr->down;
        }
    }
};
class QuadTree {
private:
    int color;
    int row;
    int col;
    QuadTree* children[4];

public:
    
    QuadTree() {
        color = 0;
        row = 0;
        col = 0;
        for (int i = 0; i < 4; i++) {
            children[i] = NULL;
        }
    }

    // Function to construct quad tree from 2D linked list
    void constructFrom2dLL(TwoDLinkedList* head) {
        if (head == NULL) {
            return;
        }
        myNode* currNode = head->rowHead;
        while (currNode != NULL && currNode->data != -2) {  // traversing each row
            int start = currNode->data;
            currNode = currNode->next;
            int end = currNode->data;
            currNode = currNode->next;

            
            if (start >= 0 && end >= 0) {
                QuadTree* child = new QuadTree();
                children[0] = child;
                for (int i = start; i <= end; i++) {
                    currNode = currNode->next;
                }
            }

            start = currNode->data;
            currNode = currNode->next;
            end = currNode->data;
            currNode = currNode->next;

            // creating child node for black pixels
            if (start >= 0 && end >= 0) {
                QuadTree* child = new QuadTree();
                children[1] = child;
                for (int i = start; i <= end; i++) {
                    currNode = currNode->next;
                }
            }
        }

        // traversing the next row of the 2D linked list
        if (head->down != NULL) {
            children[2] = new QuadTree();
            children[2]->constructFrom2dLL(head->down);
            children[3] = new QuadTree();
            children[3]->constructFrom2dLL(head->down);
        }
    }

    
    void QuadTreeWriter() {
        string folderName = "output"; 
        string fileName = folderName + ".txt";
        ofstream file(fileName);
        if (file.is_open()) { 
            file << color << " " << row << " " << col << " ";
            for (int i = 0; i < 4; i++) {
                if (children[i] != NULL) {
                    file << i << " " << folderName << "/" << children[i]->row << "_" << children[i]->col << ".txt ";
                }
                else {
                    file << -1 << " ";
                }
            }
            file.close();
        }
        else {
            cout << "Error: Unable to create file " << fileName << endl;
        }

        // recursively traversing the children nodes
        for (int i = 0; i < 4; i++) {
            if (children[i] != NULL) {
                children[i]->QuadTreeWriter();
            }
        }
    }
    
};

   
int main() {
        // Read the image file
        Mat image = imread("t1.bmp", IMREAD_GRAYSCALE);

        // Get the dimensions of the image
        int numRows = image.rows;
        int numCols = image.cols;

        // Allocate memory for the 2D DMA array
        int** imageArray = new int* [numRows];
        for (int i = 0; i < numRows; i++) {
            imageArray[i] = new int[numCols];
        }

        // Convert the image to a 2D DMA array
        for (int i = 0; i < numRows; i++) {
            for (int j = 0; j < numCols; j++) {
                imageArray[i][j] = (int)image.at<uchar>(i, j);
            }
        }
        cout << "Rows : " << numRows << endl;
        cout << "Column :" << numCols << endl;

        // Print the values of the 2D DMA array 
        for (int i = 0; i < numRows; i++) {
            for (int j = 0; j < numCols; j++) {
        //        cout << imageArray[i][j] << " ";
            }
            cout << endl;
        }

        TwoDLinkedList* list = new TwoDLinkedList();
        list->convertTo2dLL(imageArray, numRows, numCols);
       // list->print();
       
        QuadTree* quadTree = new QuadTree();

        quadTree->constructFrom2dLL(list);
        quadTree->QuadTreeWriter();


        return 0;
}
