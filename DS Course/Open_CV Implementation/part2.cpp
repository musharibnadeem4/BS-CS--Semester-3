/*Musharib Nadeem*/
/*20i-1764*/
/*Part 2*/

#include <iostream>
#include <fstream>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;
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

}

 static QuadTree* reconstructFromFiles(string folderName, int row, int col){
        ifstream file(fileName);
        if (!file) {
            cout << "Error: Unable to open file " << fileName << endl;
            return NULL;
        }

        int color, row, col;
        file >> color >> row >> col;
        QuadTree* node = new QuadTree(color, row, col);


        int childIndex, childRow, childCol;
        string childFileName;
        for (int i = 0; i < 4; i++) {
            file >> childIndex >> childFileName;
            if (childIndex != -1) {
                int underscoreIndex = childFileName.find("_");
                childRow = stoi(childFileName.substr(underscoreIndex + 1));
                childCol = stoi(childFileName.substr(0, underscoreIndex));
                node->children[childIndex] = reconstructQuadTree(childFileName);
            }
        }

        file.close();
        return node;
    }

]
void regenerateImage(QuadTree* node, Mat& image) {
    if (node == NULL) {
        return;
    }

    if (node->color == 0 || node->color == 255) {
        int x = node->col;
        int y = node->row;
        image.at<uchar>(y, x) = node->color;
        return;
    }

    // Recursively regenerating the image for the children nodes
    for (int i = 0; i < 4; i++) {
        regenerateImage(node->children[i], image);
    }
}
int main() {
    
    QuadTree* root = reconstructQuadTree("root.txt");

   
    Mat image(Size(IMAGE_WIDTH, IMAGE_HEIGHT), CV_8UC1, Scalar(255));
    regenerateImage(root, image);

    imwrite("reconstructed_image.jpg", image);

   

    return 0;
}
