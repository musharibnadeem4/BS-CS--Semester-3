#include <string>
#include <iostream>
#include <stack>

using namespace std;

string evaluatePostfixExpression(const string& expression) {
    stack<int> st;
    for (char c : expression) {
        if (isdigit(c)) {
            st.push(c - '0');
        }
        else if (c == ' ') {
            // Ignore whitespace
            continue;
        }
        else if (c == '+' || c == '-' || c == '*' || c == '/') {
            if (st.size() < 2) {
                return "Error: invalid expression";
            }
            int operand2 = st.top();
            st.pop();
            int operand1 = st.top();
            st.pop();
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
                if (operand2 == 0) {
                    return "Error: division by zero";
                }
                result = operand1 / operand2;
                break;
            default:
                return "Error: invalid expression";
            }
            st.push(result);
        }
        else {
            return "Error: invalid expression";
        }
    }
    if (st.size() == 1) {
        return to_string(st.top());
    }
    else {
        return "Error: invalid expression";
    }
}
struct Node {
    Node* left;
    Node* right;
};
int countNodes(Node* root) {
    if (root == nullptr) {
        return 0;
    }
    else
    {
        int leftCount = countNodes(root->left);
        int rightCount = countNodes(root->right);
        return 1 + leftCount + rightCount;
    }
}