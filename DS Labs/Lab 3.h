#include "pch.h"
#include <iostream>
#include <fstream>
using namespace std;

int arraySum(int A[][5], int x, int y)
{
	int sum = 0;
	for (int i = 0; i < x; i++)
	{
		for (int j = 0; j < y; j++)
		{
			sum = sum + A[i][j];
		}
	}

	return sum;
}

int* rowSum(int A[][4], int x, int y)
{
	int* ans = new int[x];
	for (int i = 0; i < x; i++)
	{
		ans[i] = 0;
		for (int j = 0; j < y; j++)
		{
			ans[i] += A[i][j];
		}
	}

	return ans;
}

int* colSum(int A[][4], int x, int y)
{
	int* ans = new int[y];
	for (int i = 0; i < y; i++)
	{
		ans[i] = 0;
	}

	for (int j = 0; j < y; j++)
	{
		for (int i = 0; i < x; i++)
		{
			ans[j] += A[i][j];
		}
	}

	return ans;
}


int** transposeMatrix(int A[][2], int x, int y)
{
	int** ans = new int* [y];

	for (int i = 0; i < y; ++i)
	{
		ans[i] = new int[x];
	}

	for (int i = 0; i < x; i++)
	{
		for (int j = 0; j < y; j++)
		{
			ans[i][j] = A[j][i];
		}
	}

	return ans;
}

int** matrixSum(int A[][3], int B[][3], int x, int y)
{
	int** ans = new int* [y];

	for (int i = 0; i < y; ++i)
	{
		ans[i] = new int[x];
	}

	for (int i = 0; i < x; i++)
	{
		for (int j = 0; j < y; j++)
		{
			ans[i][j] = A[i][j] + B[i][j];
		}
	}

	return ans;
}

int **multiplyMatrix(int A[][2], int B[][2], int r1, int c1)
{
	int** ans = new int* [c1];

	for (int i = 0; i < c1; ++i)
	{
		*(ans+i) = new int[r1];
	}
	for (int i = 0; i < r1; i++)
		for (int j = 0; j < c1; j++)
			for (int k = 0; k < r1; k++)
			{
				ans[i][j] += A[i][k] * B[k][j];

			}
	return ans;
}

int leftDiagonalSum(int mat[][4], int m, int n)
{
	int sum = 0;
	for (int i = 0; i < n; i++)
		sum += mat[i][i];
	return sum;
}
int rightDiagonalSum(int arr[][4], int m, int n)
{
	int sum1 = 0;

	for (int i = 0; i < m; i++) {
		for (int j = 0; j < m; j++) {
			if ((i + j) == m - 1)
				sum1 += arr[i][j];
		}
	}
	return sum1;
}
//Question 5
int* displayMiddleRow(int arr[][5], int n)
{
	return arr[n / 2];
}
int* displayMiddleCol(int arr[][5], int n)
{
	int* middle = new int[n];
	for (int i = 0; i < n; i++)
		middle[i] = arr[i][n / 2];
	return middle;
}
//Question  6

int* toIntArray(string str) {
	int length = str.length();
	int* arr = new int[length];
	for (int i = 0; i < length; i++) {
		arr[i] = str[i] - 48;
	}
	return arr;

}
int* addTwoArray(string str, string str1) {
	int length = str.length();
	int* arr = new int[length];
	int* arr1 = new int[length];

	for (int i = 0; i < length; i++) {
		arr[i] = str[i] - 48;
	}
	for (int i = 0; i < length; i++) {
		arr1[i] = str1[i] - 48;
		arr1[i] += arr[i];
	}
	return arr1;

}
int* subTwoArray(string str, string str1) {
	int length = str.length();
	int* arr = new int[length];
	int* arr1 = new int[length];

	for (int i = 0; i < length; i++) {
		arr[i] = str[i] - 48;
	}
	for (int i = 0; i < length; i++) {
		arr1[i] = str1[i] - 48;
		arr1[i] -= arr[i];
	}
	return arr1;

}
int* readFromFile() {
	int** res = new int* [5];

	for (int i = 0; i < 5; ++i)
	{
		res[i] = new int[5];
	}

	int* ans = new int[5];
	ifstream file("file.txt");
	if (!file.is_open()) {
		cout << "File is not Open" << endl;
	}
	for (int i = 0; i < 5; i++) { 
		for (int j = 0; j < 5; j++) {
			file >> res[i][j];
		}
		cout << "Array is :" << res << endl;
	}
	file.close();

	
	for (int i = 0; i < 5; i++)
		for(int j = 0; j<5 ;j++)
	{
		ans[i] += res[i][j];
	}
	return ans;
}

