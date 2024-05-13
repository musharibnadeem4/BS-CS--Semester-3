#include <iostream>
using namespace std;

template <typename T>

class container {

private:
    T* values;
    int capacity;
    int counter;
public:
    container()
    {
        capacity = 10;
        counter = 0;
        values = new T[capacity];
    }

    container(int a)
    {
       capacity = a;
        values = new T[capacity];
    }

    void insert(T i)
    {

        if (counter != capacity)
        {
            values[counter] = i;
            counter++;

            cout << "Value is inserted" << endl;
        }
        else
            cout << "Value is not inserted" << endl;

       // return false;
    }


    bool isFull()
    {
        return (counter == capacity);

    }

    bool search(T s)
    {
        for (int i = 0; i < counter; i++)
        {
            if (s == values[i])
            {
                return true;
            }
        }

        return false;
    }
    void remove(T r)
    {
        int index;

        if (search(r))
        {
            for (int i = 0; i < counter; i++)
            {
                if (r == values[i])
                    index = i;
            }

            for (int i = index; i < (counter - 1); i++)
            {
                values[i] = values[i + 1];
            }

            counter--;
            cout << "Value is removed" << endl;
        }

        else
            cout << "Value is not removed" << endl;
        
    }
    void print()
    {
        for (int i = 0; i < counter; i++)
        {
            cout << values[i] << " " << endl;
        }

    }
};
int main() {
    container<int> contain;
    contain.insert(20);
    cout << "Inserted value is " << endl;
    contain.print();
    contain.search(20);
    contain.remove(20);

    contain.print();

}