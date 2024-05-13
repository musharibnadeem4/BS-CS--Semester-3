//Musharib Nadeem 
//20I - 1764
//
//#include <iostream>
//#include<string>
//#include<fstream>
//#include <cmath>
//using namespace std;
//class quest1 {
//public:
//	void main() {
//
//		fstream myfile;
//
//		string details;
//
//		float value = 0;
//
//		const int rows = 4000;
//		const int cols = 4;
//		//double array[rows][cols];        //Decalring Array to store Data
//
//		int** array = new int* [rows];
//		for (int i = 0; i < rows; i++) {
//			array[i] = new int[cols];
//		}
//
//		cout << "\n\nDisplaying the content of CSV file\n\n";
//
//		//*****Reading Data from File*****\\
//
//		myfile.open("driver-data.csv", ios::in);
//
//		getline(myfile, details);
//
//		for (int i = 0; i < 4000; i++)
//			for (int j = 0; j < 3; j++) {
//				{
//					if (j != 2) {
//						getline(myfile, details, ',');
//						value = stof(details);
//						array[i][j] = value;
//					}
//					else {
//						getline(myfile, details, '\n');
//						value = stof(details);
//						array[i][j] = value;
//					}
//
//				}
//			}
//		myfile.close();
//		//for (int i = 0; i < 4000; i++) {
//		//	cout << id[i] << ' ';
//		//	cout << dist[i] << ' ';
//		//	cout << speed[i] << endl;
//		//}
//		//
//
//		//********Declaring Variable for below clustering && finding Centroid*******\\
//		int ind1 = 0;
//		int ind2 = 1;
//		int ind3 = 2;
//		int ind4 = 3;
//		double chk1;
//		double chk2;
//		double chk3;
//		double chk4;
//		double smallest = 0;
//		int output[rows][cols];
//		double array1[2] = {};
//		double array2[2] = {};
//		double array3[2] = {};
//		double array4[2] = {};
//
//		//******Calculating Euclidean Distance*****\\
//
//		for (int i = 4; i < rows; i++) {
//
//			array1[0] = array[0][1];
//			array2[0] = array[1][1];
//			array3[0] = array[2][1];
//			array4[0] = array[3][1];
//			array1[1] = array[0][2];
//			array2[1] = array[1][2];
//			array3[1] = array[2][2];
//			array4[1] = array[3][2];
//
//			for (int j = 0; j < 10; j++) {
//
//				chk1 = sqrt(pow(array1[0] - array[i][1], 2) + pow(array1[1] - array[i][2], 2));
//				chk2 = sqrt(pow(array2[0] - array[i][1], 2) + pow(array2[1] - array[i][2], 2));
//				chk3 = sqrt(pow(array3[0] - array[i][1], 2) + pow(array3[1] - array[i][2], 2));
//				chk4 = sqrt(pow(array4[0] - array[i][1], 2) + pow(array4[1] - array[i][2], 2));
//				smallest = min(chk1, chk2);
//				smallest = min(smallest, chk3);
//				smallest = min(smallest, chk4);
//				/*cout << chk1 << " " << chk2 << " " << chk3 << " " << chk4 << " " << endl;*/
//
//				/*Forming Clusters */
//
//				if (smallest == chk1) {
//					array[i][3] = 1;
//					array1[0] = (array1[0] + array[i][1]) / 2;
//					array1[1] = (array1[1] + array[i][2]) / 2;
//				}
//				else if (smallest == chk2) {
//					array[i][3] = 2;
//					array2[0] = (array2[0] + array[i][1]) / 2;
//					array2[1] = (array2[1] + array[i][2]) / 2;
//				}
//				else if (smallest == chk3) {
//					array[i][3] = 3;
//					array3[0] = (array3[0] + array[i][1]) / 2;
//					array3[1] = (array3[1] + array[i][2]) / 2;
//				}
//				else if (smallest == chk4) {
//					array[i][3] = 4;
//					array4[0] = (array4[0] + array[i][1]) / 2;
//					array4[1] = (array4[1] + array[i][2]) / 2;
//				}
//			}
//		}
//
//		//********Again Reading Data to make new File **********\\
//
//		myfile.open("driver-data.csv", ios::in);
//
//		getline(myfile, details);
//
//		for (int i = 0; i < 4000; i++)
//			for (int j = 0; j < 3; j++) {
//				{
//					if (j != 2) {
//						getline(myfile, details, ',');
//						value = stof(details);
//						array[i][j] = value;
//					}
//					else {
//						getline(myfile, details, '\n');
//						value = stof(details);
//						array[i][j] = value;
//					}
//
//				}
//			}
//		myfile.close();
//
//		string filename = "output.csv";
//
//		//Storing Data in Newly Created CSV File
//
//		ofstream file;
//		file.open(filename);
//		file << "id" << ',' << "distance" << ',' << "speed" << ',' << "output" << '\n';
//		file << array[0][0] << ',' << array[0][1] << ',' << array[0][2] << ',' << 1 << '\n';
//		file << array[1][0] << ',' << array[1][1] << ',' << array[1][2] << ',' << 2 << '\n';
//		file << array[2][0] << ',' << array[2][1] << ',' << array[2][2] << ',' << 3 << '\n';
//		file << array[3][0] << ',' << array[3][1] << ',' << array[3][2] << ',' << 4 << '\n';
//
//		for (int i = 4; i < rows; i++)
//		{
//			for (int j = 0; j < cols; j++)
//			{
//
//				if (j != cols - 1) {
//					file << array[i][j] << ',';
//				}
//				else {
//					file << array[i][j] << '\n';
//				}
//			}
//		}
//
//		file.close();
//
//		cout << "Data written to " << filename << endl;
//
//		/*for (int i = 0; i < 4000; i++) {
//			for (int j = 0; j < 4000; j++) {
//				getline(myfile, details, ',');
//				cout << "Array is : " << array<< endl;
//			}
//		}*/
//	}
//};
//
////Calling Object From Main
//
//int main() {
//	quest1 obj;
//	obj.main();
//}



//Question 2



#include <iostream>
#include<string>
#include<fstream>
#include <cmath>
using namespace std;

class quest2 {

public:

	void function() {
		fstream myfile;

		string details;

		float value = 0;

		const int rows = 200;
		const int cols = 6;

		//Decalring Array to store Data
		int** array = new int* [rows];
		for (int i = 0; i < rows; i++) {
			array[i] = new int[cols];
		}
		cout << "\n\nDisplaying the content of CSV file\n\n";

		//*****Reading Data from File*****\\

		myfile.open("segmented_customers-1.csv", ios::in);

		getline(myfile, details);

		for (int i = 0; i < 200; i++) {
			for (int j = 0; j < 5; j++) {
				{
					if (j > 1 && j != 4) {
						getline(myfile, details, ',');
						value = stof(details);
						array[i][j] = value;
					}
					else if (j <= 1) {
						getline(myfile, details, ',');
					}
					else {
						getline(myfile, details, '\n');
						value = stof(details);
						array[i][j] = value;
					}

				}
			}
		}
		myfile.close();
		/*for (int i = 0; i < 1; i++) {
			for (int j = 0; j < 200; j++) {
				for (int k = 0; k < 3; k++) {
					{
						cout << "Age at display :" << array[i][j][k] << endl;

					}
				}
			}

		}*/

		//********Declaring Variable for below clustering && finding Centroid*******\\

		double chk1;
		double chk2;
		double chk3;
		double chk4;
		double smallest = 0;
		int output[rows][cols];
		array[0][5] = 1;
		array[1][5] = 2;
		array[2][5] = 3;
		array[3][5] = 4;
		double array1[3] = { array[0][2], array[0][3], array[0][4] };
		double array2[3] = { array[1][2], array[1][3], array[1][4] };
		double array3[3] = { array[2][2], array[2][3], array[2][4] };
		double array4[3] = { array[3][2], array[3][3], array[3][4] };

		//******Calculating Euclidean Distance*****\\

		for (int i = 4; i < 200; i++) {

			array1[0] = array[0][2];
			array2[0] = array[1][2];
			array3[0] = array[2][2];
			array4[0] = array[3][2];
			array1[1] = array[0][3];
			array2[1] = array[1][3];
			array3[1] = array[2][3];
			array4[1] = array[3][3];
			array1[2] = array[0][4];
			array2[2] = array[1][4];
			array3[2] = array[2][4];
			array4[2] = array[3][4];

			for (int j = 0; j < 10; j++) {

				chk1 = sqrt(pow(array1[0] - array[i][2], 2) + pow(array1[1] - array[i][3], 2) + pow(array1[2] - array[i][4], 2));
				chk2 = sqrt(pow(array2[0] - array[i][2], 2) + pow(array2[1] - array[i][3], 2) + pow(array2[2] - array[i][4], 2));
				chk3 = sqrt(pow(array3[0] - array[i][2], 2) + pow(array3[1] - array[i][3], 2) + pow(array3[2] - array[i][4], 2));
				chk4 = sqrt(pow(array4[0] - array[i][2], 2) + pow(array4[1] - array[i][3], 2) + pow(array4[2] - array[i][4], 2));
				smallest = min(chk1, chk2);
				smallest = min(smallest, chk3);
				smallest = min(smallest, chk4);
				/*cout << chk1 << " " << chk2 << " " << chk3 << " " << chk4 << " " << endl;*/

				/* Making Clusters */

				if (smallest == chk1) {
					array[i][5] = 1;
					array1[0] = (array1[0] + array[i][2]) / 2;
					array1[1] = (array1[1] + array[i][3]) / 2;
					array1[2] = (array1[2] + array[i][4]) / 2;
				}
				else if (smallest == chk2) {
					array[i][5] = 2;
					array2[0] = (array2[0] + array[i][2]) / 2;
					array2[1] = (array2[1] + array[i][3]) / 2;
					array2[2] = (array2[2] + array[i][4]) / 2;
				}
				else if (smallest == chk3) {
					array[i][5] = 3;
					array3[0] = (array3[0] + array[i][2]) / 2;
					array3[1] = (array3[1] + array[i][3]) / 2;
					array3[2] = (array3[2] + array[i][4]) / 2;
				}
				else if (smallest == chk4) {
					array[i][5] = 4;
					array4[0] = (array4[0] + array[i][2]) / 2;
					array4[1] = (array4[1] + array[i][3]) / 2;
					array4[2] = (array4[2] + array[i][4]) / 2;
				}
			}
		}
		/*Again Reading Data to store it in new created CSV File*/
		ofstream file;
		file.open("Output2.csv");
		myfile.open("segmented_customers-1.csv", ios::in);
		getline(myfile, details);
		file << "ID" << ',' << "Gender" << ',' << "Age" << ',' << "Income" << ',' << "Score" << ',' << "Output" << endl;

		for (int i = 0; i < 1; i++)
			for (int j = 0; j < 200; j++) {
				for (int k = 0; k < 6; k++) {
					{
						if (k < 4) {
							getline(myfile, details, ',');
							file << details << ',';

						}
						else if (k == 4) {
							getline(myfile, details, '\n');
							file << details << ',';
						}
						else {
							file << to_string(array[j][5]) << endl;
						}

					}
				}
			}
		myfile.close();
		file.close();

	}
};

//calling Main Function

int main() {
	quest2 obj;
	obj.function();
}