#include<iostream>
#include<string>
using namespace std;

template <class T>
class Node
{
private:
	T data;
	Node<T>* next;
public:
	Node()
	{
		next = NULL;
	}

	T getData()
	{
		return data;
	}

	void setData(T ele)
	{
		data = ele;
	}

	Node<T>* getRear()
	{
		return next;
	}

	void setRear(Node<T>* n)
	{
		next = n;
	}
};

template <class T>
class Queue
{
private:
	Node<T>* front;
	Node<T>* rear;
	int size;
public:
	Queue()
	{
		front = NULL;
		rear = NULL;
		size = 0;
	}

	void enqueue(T ele)
	{
		Node<T>* n = new Node<T>();
		n->setData(ele);

		if (front == NULL)
		{
			front = n;
			rear = n;
		}
		else
		{
			rear->setRear(n);
			rear = n;
		}

		size++;
	}

	Node<T>* getRear() {
		return rear;
	}




	void dequeue()
	{
		if (front == NULL)
		{
			cout << "Queue is empty" << endl;
			return;
		}
		else
		{
			Node<T>* n = new Node<T>();
			n = front;
			front = front->getRear();
			delete n;
			size--;
		}
	}

	int Front()
	{
		if (front == NULL)
		{
			cout << "Queue is empty" << endl;
			return 0;
		}
		else
		{
			return front->getData();
		}
	}

	bool isEmpty()
	{
		if (size == 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	bool isFull()
	{
		return false;
	}


	void Display()
	{
		Node<T>* n = new Node<T>();
		n = front;

		if (n == NULL)
		{
			cout << "Queue is empty";
		}
		else
		{
			while (n != NULL)
			{
				cout << n->getData() << " ";
				n = n->getNext();
			}
		}
	}
};
void roundRobin(Queue<int>& q, int tq) {
	while (!q.isEmpty()) {
		int total = 0;
		int t = q.Front();
		q.dequeue();
		if (t <= tq) {
			total += t;
			cout << "Process ID: " << total << "\n";
			cout << "Processing time: " << t << "\n";
			cout << "Turnaround time: " << total << "\n";
		}
		else {
			total += tq;
			q.enqueue(t - tq);
			cout << "Process ID: " << total << "\n";
			cout << "Processing time: " << tq << "\n";
			cout << "Turnaround time: " << total << "\n";
		}
	}
}
//Queue<char> createQueue(string word) {
//	Queue<char> q;
//	for (char c : word) {
//		q.enqueue(c);
//	}
//	return q;
//}
//
//Queue<char> concatenateQueues(Queue<Queue<char>>& queues) {
//	Queue<char> result;
//	while (!queues.isEmpty()) {
//		Queue<char>& q = queues.Front();
//		while (!q.isEmpty()) {
//			result.enqueue(q.Front());
//			q.dequeue();
//		}
//		queues.dequeue();
//	}
//	return result;
//}
//
//int main() {
//	string input;
//	cout << "Enter a string: ";
//	getline(cin, input);
//
//	Queue<Queue<char>> queues;
//	string current_word;
//	for (char c : input) {
//		if (c == ' ') {
//			if (!current_word.empty()) {
//				queues.enqueue(createQueue(current_word));
//				current_word.clear();
//			}
//		}
//		else {
//			current_word += c;
//		}
//	}
//	if (!current_word.empty()) {
//		queues.enqueue(createQueue(current_word));
//	}
//
//	Queue<char> result = concatenateQueues(queues);
//	while (!result.isEmpty()) {
//		cout << result.Front();
//		result.dequeue();
//	}
//	cout << endl;
//
//	return 0;
//}

