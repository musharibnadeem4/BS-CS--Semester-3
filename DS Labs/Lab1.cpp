//Musharib Nadeem
//i201764



#include  <iostream>
#include <string>
using namespace std;


//Problem 1
//template <typename T>
//T large(T x, T y)
//{
//    return (x > y) ? x : y;
//}
//int main()
//{
//    string s1 = "Hello";
//    string s2 = "hi";
//    cout << "Largest Integer :" <<large<int>(3, 5) << endl;
//    cout <<"Largest Double :" << large<double>(4.0, 8.0) << endl;
//    cout <<"Largest char : "<< large<char>('g', 'e') << endl;
//    cout << "Largest string : " <<large(s1.length(), s2.length()) << endl;
//
//    return 0;
//}

//Problem 2:

// Template based function to swap two variables 
//template<typename T>
//void swap_num(T& a, T& b)
//{
//    T temp = a;
//    a = b;
//    b = temp;
//}
//int main() {
//    int x = 10, y = 20;
//    swap_num(x, y);
//    cout << "After Swapping first Integer  :" << x << "  After Swapping second Integer :" << y << endl;
//    double a = 10.5, b = 20.5;
//    swap_num(a, b);
//    cout << "After Swapping first Double  :" << a << "  After Swapping second Double :" << b << endl;
//    string s1 = "Musharib", s2 = "Nadeem";
//    swap_num(s1, s2);
//    cout << "After Swapping first String  :" << s1<< endl;
//    cout << "  After Swapping second String :" << s2 << endl;
//    char ch1 = 'a', ch2 = 'b';
//    swap_num(ch1, ch2);
//    cout << "After Swapping first Character  :" << ch1 << "  After Swapping second Character :" << ch2 << endl;
//}


//Problem 3

template <typename T>
T sameElements(T arr, int n)
{
	for (int i = 0; i < n; i++)
		cout << arr[i] << " ";
	return arr;
}


//void concatenateArrays(int arr1[], int arr2[], int n1, int n2)
//{
//    // Declare resultant array
//    int result[n1 + n2];
//
//  
//    int hash[100] = { 0 };
//
//    int i = 0, j = 0, k = 0;
//
//    
//    for (i = 0; i < n1; i++)
//    {
//    
//        if (hash[arr1[i]] == 0)
//        {
//            result[k] = arr1[i];
//            hash[arr1[i]] = 1;
//            k++;
//        }
//    }
//
//    
//    for (i = 0; i < n2; i++)
//    {
//
//        if (hash[arr2[i]] == 0)
//        {
//            result[k] = arr2[i];
//            hash[arr2[i]] = 1;
//            k++;
//        }
//    }
//    cout << "Resultant array is : ";
//    for (i = 0; i < n1 + n2; i++)
//        cout << result[i] << " ";
//}


int main()
{
    int n1 = 5;
    int n2 = 5;
	int array1[5], array2[5];

	cout << "Enter 5 elements for array 1: ";
	for (int i = 0; i < 5; i++)
		cin >> array1[i];

	cout << "Enter 5 elements for array 2: ";
	for (int i = 0; i < 5; i++)
		cin >> array2[i];
	//sameElements(5, 5);
    
	cout << "\nNumber of same elements in both arrays is: " << sameElements(array1,5) << endl;
   concatenateArrays(array1, array2, n1, n2);


	return 0;
}