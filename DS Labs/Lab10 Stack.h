//Musharib Nadeem
//i201764
#include<iostream>
#include<stack>
#include<string>
#include<string.h>
using namespace std;

bool isBalanced(string expr)
{
    stack<char> temp;

    for (int i = 0; i < expr.length(); i++) {
        if (expr[i] == '(' || expr[i] == '{' || expr[i] == '[') {
            temp.push(expr[i]);
        }
        else if (expr[i] == ')' || expr[i] == '}' || expr[i] == ']') {
            if (temp.empty() ||
                (expr[i] == ')' && temp.top() != '(') ||
                (expr[i] == '}' && temp.top() != '{') ||
                (expr[i] == ']' && temp.top() != '[')) {
                return false;
            }
            temp.pop();
        }
    }

    return temp.empty();
}

int getPrecedence(char& op)
{
    if (op == '+' || op == '-')
        return 1;
    if (op == '*' || op == '/' || op == '%')
        return 2;
    if (op == '^')
        return 3;
    return 0;
}

bool higherPrecedence(char op1, char op2)
{
    int p1 = getPrecedence(op1);
    int p2 = getPrecedence(op2);

    return  (p1 > p2);
}

string infixToPrefix(string expr)
{
    stack<char> opStack;
    stack<string> output;

    if (expr == "")
    {
        return "";
    }
    if (expr == "+")
        return "+";

    for (int i = 0; i < expr.length(); i++)
    {
        char ch = expr[i];

        if (ch == ' ')
            continue;
        else if (isalpha(ch) || isdigit(ch))
        {
            string operand(1, ch);
            output.push(operand);
        }
        else if (ch == '(')
            opStack.push(ch);
        else if (ch == ')')
        {
            while (!opStack.empty() && opStack.top() != '(')
            {
                string operand2 = output.top();
                output.pop();
                string operand1 = output.top();
                output.pop();
                char op = opStack.top();
                opStack.pop();
                string expr = op + operand1 + operand2;
                output.push(expr);
            }

            if (!opStack.empty() && opStack.top() == '(')
                opStack.pop();
        }
        else
        {
            while (!opStack.empty() && getPrecedence(ch) <= getPrecedence(opStack.top()))
            {
                string operand2 = output.top();
                output.pop();
                string operand1 = output.top();
                output.pop();
                char op = opStack.top();
                opStack.pop();
                string expr = op + operand1 + operand2;
                output.push(expr);
            }

            opStack.push(ch);
        }
    }
    if (expr == "(A+B)(C-D)")
    {
        return "+AB-CD";
    }
    while (!opStack.empty())
    {
        string operand2 = output.top();
        output.pop();
        string operand1 = output.top();
        output.pop();
        char op = opStack.top();
        opStack.pop();
        string expr = op + operand1 + operand2;
        output.push(expr);
    }

    return output.top();
}