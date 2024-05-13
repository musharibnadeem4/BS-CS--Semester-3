
/*Musharib Nadeem*/
/*20i-1764*/
/*Part 3*/

int main() {
        Mat image1 = imread("t1.bmp", IMREAD_GRAYSCALE);

    // Getting the dimensions of the first image
    int numRows1 = image1.rows;
    int numCols1 = image1.cols;

    // Allocate memory for the 2D DMA array for the first image
    int** imageArray1 = new int* [numRows1];
    for (int i = 0; i < numRows1; i++) {
        imageArray1[i] = new int[numCols1];
    }

    // Convert the first image to a 2D DMA array
    for (int i = 0; i < numRows1; i++) {
        for (int j = 0; j < numCols1; j++) {
            imageArray1[i][j] = (int)image1.at<uchar>(i, j);
        }
    }

   
    Mat image2 = imread("t2.bmp", IMREAD_GRAYSCALE);

    // Getting the dimensions of the second image
    int numRows2 = image2.rows;
    int numCols2 = image2.cols;

    // Allocate memory for the 2D DMA array for the second image
    int** imageArray2 = new int* [numRows2];
    for (int i = 0; i < numRows2; i++) {
        imageArray2[i] = new int[numCols2];
    }

    // Converting the second image to a 2D DMA array
    for (int i = 0; i < numRows2; i++) {
        for (int j = 0; j < numCols2; j++) {
            imageArray2[i][j] = (int)image2.at<uchar>(i, j);
        }
    }

    // Computing the accuracy of the second image compared to the first image
    float sum = 0;
    for (int i = 0; i < numRows1; i++) {
        for (int j = 0; j < numCols1; j++) {
            float diff = (float)imageArray1[i][j] - (float)imageArray2[i][j];
            sum += pow(diff, 2);
        }
    }
    float mse = sum / (float)(numRows1 * numCols1);
    float acc = 20.0 * log10(255.0 / sqrt(mse));
    cout << "Accuracy = " << acc << endl;

    // Free the memory allocated for the 2D DMA arrays
    for (int i = 0; i < numRows1; i++) {
        delete[] imageArray1[i];
    }
    delete[] imageArray1;

    for (int i = 0; i < numRows2; i++) {
        delete[] imageArray2[i];
    }
    delete[] imageArray2;

    return 0;
}


