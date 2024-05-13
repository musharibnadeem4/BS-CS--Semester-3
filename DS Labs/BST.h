#include <iostream>
#include <queue>
using namespace std;


class BinarySearchTree {
private:
    struct Node {
        int data;
        Node* left;
        Node* right;

        Node(int val) : data(val), left(nullptr), right(nullptr) {}
    };

    Node* root;

    void insert(Node*& node, int val) {
        if (node == nullptr) {
            node = new Node(val);
            return;
        }

        if (val < node->data) {
            insert(node->left, val);
        }
        else {
            insert(node->right, val);
        }
    }

    void inOrderTraversal(Node* node) {
        if (node == nullptr) {
            return;
        }

        inOrderTraversal(node->left);
        std::cout << node->data << " ";
        inOrderTraversal(node->right);
    }

    void breadthFirstTraversal(Node* node) {
        if (node == nullptr) {
            return;
        }

        std::queue<Node*> q;
        q.push(node);

        while (!q.empty()) {
            Node* curr = q.front();
            q.pop();

            std::cout << curr->data << " ";

            if (curr->left != nullptr) {
                q.push(curr->left);
            }

            if (curr->right != nullptr) {
                q.push(curr->right);
            }
        }
    }

    Node* remove(Node*& node, int val) {
        if (node == nullptr) {
            return node;
        }

        if (val < node->data) {
            node->left = remove(node->left, val);
        }
        else if (val > node->data) {
            node->right = remove(node->right, val);
        }
        else {
            if (node->left == nullptr) {
                Node* temp = node->right;
                delete node;
                return temp;
            }
            else if (node->right == nullptr) {
                Node* temp = node->left;
                delete node;
                return temp;
            }

            Node* temp = findMinNode(node->right);
            node->data = temp->data;
            node->right = remove(node->right, temp->data);
        }

        return node;
    }

    Node* findMinNode(Node* node) {
        while (node->left != nullptr) {
            node = node->left;
        }

        return node;
    }

public:
    BinarySearchTree() : root(nullptr) {}

    void insert(int val) {
        insert(root, val);
    }

    void inOrderTraversal() {
        inOrderTraversal(root);
        std::cout << std::endl;
    }

    void breadthFirstTraversal() {
        breadthFirstTraversal(root);
        std::cout << std::endl;
    }

    void remove(int val) {
        root = remove(root, val);
    }
};


struct Node {
    int data;
    Node* left;
    Node* right;
};

Node* createNode(int data) {
    Node* newNode = new Node;
    newNode->data = data;
    newNode->left = nullptr;
    newNode->right = nullptr;
    return newNode;
}

void deleteTree(Node* node) {
    if (node == nullptr) {
        return;
    }
    deleteTree(node->left);
    deleteTree(node->right);
    delete node;
}

void inOrderTraversal(Node* root) {
    if (root == nullptr) {
        return;
    }
    inOrderTraversal(root->left);
    std::cout << root->data << " ";
    inOrderTraversal(root->right);
}

void preOrderTraversal(Node* root) {
    if (root == nullptr) {
        return;
    }
    std::cout << root->data << " ";
    preOrderTraversal(root->left);
    preOrderTraversal(root->right);
}

void postOrderTraversal(Node* root) {
    if (root == nullptr) {
        return;
    }
    postOrderTraversal(root->left);
    postOrderTraversal(root->right);
    std::cout << root->data << " ";
}