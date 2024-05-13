#include<iostream>
using namespace std;


void bubblesort(int arr[], int Array_size) {

    for (int p = 1; p < Array_size; p++) {
        for (int i = 0; i < Array_size - p; i++) {
            if (arr[i] < arr[i + 1]) {
                int temp = arr[i];
                arr[i] = arr[i + 1];
                arr[i + 1] = temp;

            }
        }
    }
}
void merge(int* arr, int low, int high, int mid)
{
    int i, j, k, c[50];
    i = low;
    k = low;
    j = mid + 1;
    while (i <= mid && j <= high) {
        if (arr[i] < arr[j]) {
            c[k] = arr[i];
            k++;
            i++;
        }
        else {
            c[k] = arr[j];
            k++;
            j++;
        }
    }
    while (i <= mid) {
        c[k] = arr[i];
        k++;
        i++;
    }
    while (j <= high) {
        c[k] = arr[j];
        k++;
        j++;
    }
    for (i = low; i < k; i++) {
        arr[i] = c[i];
    }
}
void merge_sort(int* arr, int low, int high)
{
    int mid;
    if (low < high) {
        mid = (low + high) / 2;
        merge_sort(arr, low, mid);
        merge_sort(arr, mid + 1, high);
        merge(arr, low, high, mid);
    }
}
int main()
{
    cout << "*******Merge Sort*************" << endl;
    int arr[30], num;
    cout << "Enter number of elements in Array:" << endl;
    cin >> num;
    for (int i = 0; i < num; i++) {
        cin >> arr[i];
    }
    merge_sort(arr, 0, num - 1);
    cout << "Sorted array in Ascending Order" << endl;
    for (int i = 0; i < num; i++)
    {
        cout << arr[i] << endl;
    }
    cout << "*******Bubble Sort***********" << endl;
    int array[30], num1;
    const int Array_size = 30;
    //int array[Array_size];
    cout << "Enter Number of elements in Array: ";
    cin >> num1;
    for (int i = 0; i < num1; i++) {
        cin >> arr[i];
    }
    cout << endl;
    bubblesort(arr, Array_size);

    cout << "Sorted array in Descending Order: " << endl;
    for (int i = 0; i < num1; i++) {
        cout << arr[i];
    }

    cout<<"Worst Time complexity of Merge sort is O(nlogn) and of Bubble sort is O(n^2)"<<endl;
    cout<<"So in terms of efficiency the merge sort is better as its worst case time complexity nlogn"<<endl;
    cout << " is better then the worst case complexity of Bubble Sort" << endl;
}

/*Worst Time complexity of Merge sort is O(nlogn) and of Bubble sort is O(n^2)*/
/* So in terms of efficiency the merge sort is better as its worst case time complexity nlogn
  is better then the worst case complexity of Bubble Sort*/