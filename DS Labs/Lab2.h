//i201764
//Musharib

#include <iostream>
#include <cmath>
#include<cstring>
using namespace std;

//Task 1

template <typename T>
T* add(T* arr1, T* arr)
{
    T size = sizeof(arr1);
    T* result;
    result = new T[size];

    for (int i = 0; i < size; i++)
    {
        result[i] = arr1[i] + arr[i];
    }
    return result;
}

template <class T>
T add(T a, T b)
{
    return a + b;
}


template <class T>
T sub(T num1, T num2)
{
    return num1 - num2;
}

template <class T>
T Div(T num1, T num2)
{
    return num1 / num2;
}

template <class T>
T multiply(T num1, T num2)
{
    return num1 * num2;
}

template <class T>
T prime(T num)
{
    int flag = 1;
    for (int i = 2; i <= num / 2; ++i)
    {
        if (num % i == 0)
        {
            flag = 0;
            break;
        }
    }
    if (flag == 1)
        return 1;
    else
        return 0;
}

template <class T>
T Fact(T num)
{
    if (num == 0)
        return 1;
    else
        return num * Fact(num - 1);
}

template <class T>
T SQRT(T num)
{
    return sqrt(num);
}
//Task 2
int SplitToSets(int arr[], int size)
{
    int h1 = 0;
   /* for (int i = 0; i < size; i++)
    {
        cout << arr[i] << endl;;
    }*/
    int gh = 0;
    int l = size / 2;
    if (size % 2 != 0)
    {
        l++;
    }
    int m = size - l;
    int* arr1 = new int[l];
    int* arr2 = new int[m];
    int g1 = 0;
    for (int i = 0; i < l; i++) {
        for (int i = 1; i < size; ++i) {

            // Change < to > if you want to find the smallest element
            if (arr[0] < arr[i]) {
                gh = arr[0];
                arr[0] = arr[i];
                arr[i] = gh;
            }
        }
        arr1[h1] = arr[0];
        h1++;
        arr[0] = 0;
    }
    h1 = 0;
    for (int i = 0; i < m; i++) {
        for (int i = 1; i < size; ++i) {

            // Change < to > if you want to find the smallest element
            if (arr[0] < arr[i]) {
                gh = arr[0];
                arr[0] = arr[i];
                arr[i] = gh;
            }
        }
        arr2[h1] = arr[0];
        h1++;
        arr[0] = 0;
    }

    for (int i = 0; i < l; i++)
    {
        cout << arr1[i] << ",";
    }
    cout << endl;
    for (int i = 0; i < m; i++)
    {
        cout << arr2[i] << ",";
    }
    h1 = 0; gh = 0;
    for (int i = 0; i < l; i++)
    {
        h1 += arr1[i];
    }
    cout << endl;
    for (int i = 0; i < m; i++)
    {
        gh += arr2[i];
    }
    int m1 = h1 - gh;
    return m1;
}
//Task 3
bool superString(string s)
{
    int n = s.length();

    int a[26] = { 0 };

    for (int i = 0; i < n; i++)
        a[s[i] - 'A']++;

    for (int i = 0; i < n; i++) {
        if (a[s[i] - 'A'] != ((s[i] - 'A') * -1) + 26)
            return false;
        else
            true;
    }
}
//Task 4


//const int MAX_LEN = 100;
//
//bool isPalindrome(const char* str, int start, int end) {
//    while (start < end) {
//        if (str[start++] != str[end--]) {
//            return false;
//        }
//    }
//    return true;
//}
//
//int findPalindromeSubstrings(const char* str) {
//    int len = strlen(str);
//    int counter = 0;
//    cout << "The palindromic substrings are: ";
//    for (int i = 0; i < len; i++) {
//        for (int j = i; j < len; j++) {
//            if (isPalindrome(str, i, j)) {
//                counter++;
//                for (int k = i; k <= j; k++) {
//                    cout << str[k];
//                    
//                }
//                cout << " ";
//            }
//        }
//    }
//    cout << endl;
//    return counter;
//}
//
//int main() {
//    char input[MAX_LEN];
//    cout << "Enter a string: ";
//    cin.getline(input, MAX_LEN);
//   // findPalindromeSubstrings(input);
//    int counter = findPalindromeSubstrings(input);
//    cout << "Number of Sub Palindromes are : " << counter << endl;
//    
//
//    return 0;
//}


//Task 5
//
//const int MAX_LEN = 100;
//int stringToIntArray(const char* input, int* output) {
//    int len = strlen(input);
//    int count = 0;
//    int num = 0;
//    for (int i = 0; i < len; i++) {
//        if (input[i] >= '0' && input[i] <= '9') {
//            num = num * 10 + (input[i] - '0');
//        }
//        else {
//            output[count++] = num;
//            num = 0;
//        }
//    }
//    output[count++] = num;
//    return count;
//}
//int main() {
//    //int result;
//    char input1[MAX_LEN], input2[MAX_LEN];
//    cout << "Enter the first string of integers: ";
//    cin.getline(input1, MAX_LEN);
//    cout << "Enter the second string of  integers: ";
//    cin.getline(input2, MAX_LEN);
//
//    int arr1[MAX_LEN], arr2[MAX_LEN];
//    int len1 = stringToIntArray(input1, arr1);
//    int len2 = stringToIntArray(input2, arr2);
//
//    int result[MAX_LEN];
//    int result2[MAX_LEN];
//    cout << "The first converted array is: ";
//    for (int i = 0; i < len1; i++) {
//        cout << arr1[i] << " ";
//    }
//    cout << endl;
//    cout << "The second converted array is: ";
//    for (int i = 0; i < len2; i++) {
//        cout << arr2[i] << " ";
//    }
//    cout << endl;
//    cout << "The array after adding integer integers in the array are: ";
//    for (int i = 0; i < len1; i++) {
//        result[i] = arr1[i] + arr2[i];
//        cout << result[i] << " ";
//    }
//    cout << endl;
//    cout << "The array after subtracting integer integers in the array are: ";
//    for (int i = 0; i < len1; i++) {
//        result[i] = arr1[i] - arr2[i];
//        cout << result[i] << " ";
//    }
//    cout << endl;
//    cout << endl;
//    return 0;
//}


