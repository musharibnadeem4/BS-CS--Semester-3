#include<iostream>
#include <unordered_set>
using namespace std;
//*******************Task 1*******************
template <class T>
class List {
public:
	T* values;
	int capacity;
	int counter;
	List(int capacity) {
		this->capacity = capacity;
		this->values = new T[capacity]{ 0 };
		this->counter = 0;
	}
	bool isEmpty() {
		return counter == 0;
	}
	bool isFull() {
		return counter == capacity;
	}
	bool insert(T val) {
		if (!isFull()) {
			values[counter] = val;
			counter++;
			return true;
		}
		else
			return false;
	}
	int	search(T item) {
		for (int i = 0; i < counter; i++) {
			if (values[i] = item)
				return i;
		}
		return 0;
	}
	bool insertAt(T item, int index) {
		{
			int temp = counter - 1;
			while (temp >= index)
			{
				values[temp + 1] = values[temp];
				temp--;
			}
			values[index] = item;
			counter++;
			return true;
		}
	}
	bool insertBefore(T itemTobeInserted, T item) {
		int temp;
		for (int i = 0; i < capacity; i++) {
			if (item == values[i]) {
				temp = i;
				break;
			}
		}
		bool x = insertAt(itemTobeInserted, temp);
		return x;
	}
	int insertAfter(T itemTobeInserted, T item) {
		int temp;
		for (int i = 0; i < capacity; i++) {
			if (item == values[i]) {
				temp = i;
				break;
			}
		}
		bool x = insertAt(itemTobeInserted, temp + 1);
		return x;
	}
	bool remove(T item) {
		int index = search(item);
		for (int i = 0; i < counter; i++)
		{
			if (i > index)
			{
				values[i - 1] = values[i];
			}
		}
		counter--;
		return true;
	}
	bool removeBefore(T item) {
		int index = search(item);
		index--;
		for (int i = 0; i < counter; i++)
		{
			if (i > index)
			{
				values[i - 1] = values[i];
			}
		}
		counter--;
		return true;
	}
	bool removeAfter(T item) {
		int index = search(item);
		index++;
		for (int i = 0; i < counter; i++)
		{
			if (i > index)
			{
				values[i - 1] = values[i];
			}
		}
		counter--;
		return true;
	}
	void print() {
		for (int i = 0; i < capacity; i++) {
			cout << values[i] << endl;
		}
	}
	bool operator==(List l)
	{
		bool isTrue = true;
		for (int i = 0; i < counter; i++)
		{
			if (values[i] != l.values[i])
				return false;
		}

		return true;
	}
	void reverse()
	{
		T* reverseList = new T[counter];
		int j = 0;
		for (int i = counter - 1; i >= 0; i--, j++)
		{
			reverseList[j] = values[i];
		}
		values = reverseList;

	}
};

//Question 2

//bool EmailValidation(string str) {
//	int len = 0;
//	int i = 0;
//	bool check1 = false, check2 = false, check3 = false, check4 = false, check5 = false, check6 = false;
//	string domain[2] = { "gmail", "hotmail" };
//	for (int i = 0; i < len; i++) {
//		if(str = )
//	}
//}

bool PasswordValidation(string str)
{
	int len = 0;
	int i = 0;
	bool check1 = false, check2 = false, check3 = false, check4 = false, check5 = false;
	while (str[i] != '\0')
	{
		len++;
		i++;
	}
	if (len > 5 && len < 11)
	{
		check1 = true;
	}
	for (int i = 0; i < len; i++)
	{
		if ((int)str[i] >= 48 && (int)str[i] <= 57)
		{
			check2 = true;
		}
		if ((int)str[i] >= 65 && (int)str[i] <= 90)
		{
			check3 = true;
		}
		if ((int)str[i] >= 97 && (int)str[i] <= 122)
		{
			check4 = true;
		}
		if ((int)str[i] >= 33 && (int)str[i] <= 47 && (int)str[i] >= 58 && (int)str[i] <= 64)
		{
			check5 = true;
		}
	}
	if (check2 == true && check3 == true && check4 == true)
	{
		return true;
	}
	else
		return false;

}
unordered_set<string> domains = { "gmail.com", "yahoo.com", "outlook.com", "hotmail.com" };

bool isValidPrefix(string prefix) {
	int n = prefix.length();

	if (!isalpha(prefix[0])) {
		return false;
	}

	if (prefix[n - 1] == '-' || prefix[n - 1] == '.' || prefix[n - 1] == '_') {
		return false;
	}

	for (int i = 0; i < n - 1; i++) {
		if ((prefix[i] == '-' || prefix[i] == '.' || prefix[i] == '_') && (prefix[i + 1] == '-' || prefix[i + 1] == '.' || prefix[i + 1] == '_')) {
			return false;
		}
	}
	return true;
}

bool EmailValidation(string email) {
	int n = email.length();

	if (email.find('@') == string::npos) {
		return false;
	}


	string prefix = email.substr(0, email.find('@'));
	string domain = email.substr(email.find('@') + 1);

	if (domains.find(domain) == domains.end()) {
		return false;
	}

	return isValidPrefix(prefix);
}

























