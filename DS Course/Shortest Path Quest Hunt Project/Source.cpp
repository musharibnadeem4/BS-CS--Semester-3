/*Mushraib Nadeem 20I - 1764*/
#include <iostream>
#include "Header.h"
#include <conio.h>
#include <windows.h>
using namespace std;

const int MAP_WIDTH = 10;
const int MAP_HEIGHT = 10;
const int MAX = 100;

//const int numNodes = 100;
int parent[MAX], ranks[MAX];
bool visited[MAX];


/* Kruskals working here */

struct Edge {
    int u, v, weight;   //u v are endpoints
};

void make_set(int v) {
    parent[v] = v;
    ranks[v] = 0;
}

int find_set(int v) {
    if (v == parent[v]) {
        return v;
    }
    return parent[v] = find_set(parent[v]);
}

void union_sets(int a, int b) {
    a = find_set(a);
    b = find_set(b);
    if (a != b) {
        if (ranks[a] < ranks[b]) {
            swap(a, b);
        }
        parent[b] = a;
        if (ranks[a] == ranks[b]) {
            ranks[a]++;
        }
    }
}

bool compare(Edge a, Edge b) {
    return a.weight < b.weight;
}

void kruskal(int n, int graph[][MAX]) {

    //Edge edges[n * n];
    Edge* edges = new Edge[n * n];
    int index = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (graph[i][j] != 0) {
                edges[index].u = i;
                edges[index].v = j;
                edges[index].weight = graph[i][j];
                index++;
            }
        }
    }

    //array is sorting
    for (int i = 0; i < index - 1; i++) {
        for (int j = i + 1; j < index; j++) {
            if (compare(edges[j], edges[i])) {
                Edge temp = edges[i];
                edges[i] = edges[j];
                edges[j] = temp;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        make_set(i);
    }
    for (int i = 0; i < index; i++) {
        int u = edges[i].u;
        int v = edges[i].v;
        int w = edges[i].weight;
        if (find_set(u) != find_set(v)) {
            union_sets(u, v);
            cout << u << " - " << v << " : " << w << endl;
        }
    }

    delete edges;

}

/*Prims Working here */



void prim(int n, int graph[MAX][MAX]) {
    // initialize parent array and visited array
    for (int i = 0; i < n; i++) {
        parent[i] = -1;
        visited[i] = false;
    }

    // initialize distance array with max value for all vertices
    int dist[MAX];
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[0] = 0;

    // loop over all vertices
    for (int i = 0; i < n; i++) {
        // find the vertex with minimum distance that has not been visited
        int min_dist = INT_MAX;
        int min_vertex = -1;
        for (int j = 0; j < n; j++) {
            if (!visited[j] && dist[j] < min_dist) {
                min_dist = dist[j];
                min_vertex = j;
            }
        }

        // mark the min_vertex as visited
        visited[min_vertex] = true;

        // update the distances to its neighbors
        for (int j = 0; j < n; j++) {
            if (graph[min_vertex][j] > 0 && !visited[j] && graph[min_vertex][j] < dist[j]) {
                dist[j] = graph[min_vertex][j];
                parent[j] = min_vertex;
            }
        }
    }
}

void printMST(int n) {
    cout << "Edges in the minimum spanning tree:\n";
    for (int i = 1; i < n; i++) {
        cout << "(" << parent[i] + 1 << ", " << i + 1 << ")\n";
    }
}





/*Dijsktra Workings here  */


// Function to find the index of the starting and goal nodes
void findStartAndGoal(char map[][MAP_HEIGHT], int& start, int& goal) {
    start = 0;
    goal = -1;
    for (int i = 0; i < MAP_WIDTH; i++) {
        for (int j = 0; j < MAP_HEIGHT; j++) {
            int index = i * MAP_WIDTH + j;
            // if (map[i][j] == 'C') {
            //     start = index;
            // }
            if (map[i][j] == '*') {
                goal = index;
            }

            if (start != -1 && goal != -1) {
                return;
            }
        }
    }
}

void findGoal(char map[][MAP_HEIGHT], int& start, int& goal) {
    goal = -1;
    for (int i = 0; i < MAP_WIDTH; i++) {
        for (int j = 0; j < MAP_HEIGHT; j++) {
            int index = i * MAP_WIDTH + j;
            /*if (map[i][j] == 'C') {
                start = index;
            }*/
            if (map[i][j] == '*') {
                goal = index;
            }

            if (start != -1 && goal != -1) {
                return;
            }
        }
    }
}

// Function to initialize distance and visited arrays
void initDijkstra(int adjMatrix[][100], int start, int distance[], bool visited[]) {
    for (int i = 0; i < MAP_WIDTH * MAP_HEIGHT; i++) {
        distance[i] = INT_MAX;
        visited[i] = false;
    }
    distance[start] = 0;
}

// Function to find the minimum distance node from the distance array that has not been visited yet
int minDistance(int distance[], bool visited[]) {
    int minDist = INT_MAX, minIndex;
    for (int i = 0; i < MAP_WIDTH * MAP_HEIGHT; i++) {
        if (!visited[i] && distance[i] <= minDist) {
            minDist = distance[i];
            minIndex = i;
        }
    }
    return minIndex;
}

// Function to update the distance array with the newly found minimum distance node
void updateDistance(int adjMatrix[][100], int u, int distance[], bool visited[]) {
    for (int v = 0; v < MAP_WIDTH * MAP_HEIGHT; v++) {
        if (adjMatrix[u][v] != 0 && !visited[v] && distance[u] != INT_MAX &&
            distance[u] + adjMatrix[u][v] < distance[v]) {
            distance[v] = distance[u] + adjMatrix[u][v];
        }
    }
}

// Dijkstra's algorithm function
int dijkstra(int adjMatrix[][100], int start, int goal) {
    int distance[MAP_WIDTH * MAP_HEIGHT];
    bool visited[MAP_WIDTH * MAP_HEIGHT];

    // Initialize distance and visited arrays
    initDijkstra(adjMatrix, start, distance, visited);

    for (int i = 0; i < MAP_WIDTH * MAP_HEIGHT; i++) {
        int u = minDistance(distance, visited);
        visited[u] = true;
        updateDistance(adjMatrix, u, distance, visited);
    }
    return distance[goal];
}



/* Bonus Incoming */





void textColor(int color)
{
    HANDLE console = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleTextAttribute(console, color);
}
void displayMainMenu()
{
    textColor(11); //cyan
    cout << "--------------------------------------------------------" << endl;
    cout << "\033[1m\tTHE QUEST FOR THE CRYSTAL KINGDOM\033[0m\n";
    textColor(11); //cyan
    cout << "--------------------------------------------------------" << endl;
    textColor(4); //red
    cout << "           /\\           " << endl;
    cout << "          /  \\          " << endl;
    cout << "         / /\\ \\         " << endl;
    cout << "        / /__\\ \\        " << endl;
    cout << "       / /\\   \\ \\       " << endl;
    cout << "      / /__\\   \\ \\      " << endl;
    cout << "     / /____\\   \\ \\     " << endl;
    cout << "     \\ \\____/   / /     " << endl;
    cout << "      \\ \\  /___/ /      " << endl;
    cout << "       \\_\\/_____/       " << endl;
    textColor(15); //white
    cout << "==============================================================\n";
    textColor(9); //blue
    cout << "1. Shortest path from current location\n";
    textColor(10); //green
    cout << "2. Shortest path from custom location\n";
    textColor(11); //cyan
    cout << "3. Minimum Spanning-Tree (Prims algorithm)\n";
    textColor(6); //yellow
    cout << "4. Minimum Spanning-Tree (Kruskal algorithm)\n";
    textColor(10); //green
    cout << "5. Forest Map\n";
    textColor(9); //blue
    cout << "6. Adjacent Matrix\n";
    textColor(4); //red color
    cout << "7. Dijsktra Algorithm\n";
    textColor(4); //red color
    cout << "8. Dijsktra Algorithm from custom location \n";
    textColor(9); //blue
    cout << "8. Exit\n";
    textColor(15);
    cout << "==============================================================" << endl;
}



/////////////////////////////////Main Function///////////////////////
int main()
{

    const int MAP_WIDTH = 10;
    const int MAP_HEIGHT = 10;
    const int MAX = 100;
    srand(time(0));

    char q = ' ';
    // Create a 2D array of 10x10 elements
    char map[MAP_WIDTH][MAP_HEIGHT];
    for (int i = 0; i < MAP_WIDTH; i++) {
        for (int j = 0; j < MAP_HEIGHT; j++) {
            map[i][j] = 'C';
        }
    }

    // Add jewels
    int numJewels = rand() % 10 + 1; // Random number between 1 and 10
    for (int i = 0; i < numJewels; i++) {
        int x = rand() % MAP_WIDTH;
        int y = rand() % MAP_HEIGHT;
        map[x][y] = 'J';
    }

    // Add potions
    int numPotions = rand() % 6 + 1; // Random number between 1 and 3
    for (int i = 0; i < numPotions; i++) {
        int x = rand() % MAP_WIDTH;
        int y = rand() % MAP_HEIGHT;
        map[x][y] = 'P';
    }

    // Add weapons
    int numWeapons = rand() % 10 + 1; // Random number between 1 and 2
    for (int i = 0; i < numWeapons; i++) {
        int x = rand() % MAP_WIDTH;
        int y = rand() % MAP_HEIGHT;
        map[x][y] = 'W';
    }

    // Add death points
    int numDeaths = rand() % 10 + 1; // Random number between 0 and 1
    for (int i = 0; i < numDeaths; i++) {
        int x = rand() % MAP_WIDTH;
        int y = rand() % MAP_HEIGHT;
        map[x][y] = '%';
    }

    // Add obstacles
    int numObstacles = rand() % 10 + 1; // Random number between 1 and 10
    for (int i = 0; i < numObstacles; i++) {
        int x = rand() % MAP_WIDTH;
        int y = rand() % MAP_HEIGHT;
        map[x][y] = '#';
    }

    // Add monsters
    int numMonsters = rand() % 5 + 1; // Random number between 1 and 5
    for (int i = 0; i < numMonsters; i++) {
        int x = rand() % MAP_WIDTH;
        int y = rand() % MAP_HEIGHT;
        int monster = rand() % 4; // Random number between 0 and 3

        switch (monster) {
        case 0:
            map[x][y] = '&'; // Dragon
            break;
        case 1:
            map[x][y] = '$'; // Goblin
            break;
        case 2:
            map[x][y] = '@'; // Werewolf
            break;
        default:
            break;
        }
    }

    map[0][0] = 'C';
    // Add the crystal (goal point)
    int x = rand() % MAP_WIDTH;
    int y = rand() % MAP_HEIGHT;
    map[x][y] = '*';

    AVLTree tree;

    cout << endl;

    tree.root = tree.insertnode(tree.root, 100, 0);
    const int numNodes = MAP_WIDTH * MAP_HEIGHT;
    int adjacency_matrix[numNodes][numNodes];

    for (int i = 0; i < numNodes; i++) {
        for (int j = 0; j < numNodes; j++) {
            adjacency_matrix[i][j] = 0;
        }
    }

    for (int i = 0; i < MAP_WIDTH; i++) {
        for (int j = 0; j < MAP_HEIGHT; j++) {
            if (map[i][j] == '#')
            {
                adjacency_matrix[i][j] = 100;
            }
            if (map[i][j] == '%')
            {
                adjacency_matrix[i][j] = 100;
            }
            if (map[i][j] == 'J')
            {
                tree.root = tree.insertnode(tree.root, rand() % 100 + 101, 50);
            }
            if (map[i][j] == 'W')
            {
                tree.root = tree.insertnode(tree.root, rand() % 100 + 101, 30);
            }
            if (map[i][j] == 'P')
            {
                tree.root = tree.insertnode(tree.root, rand() % 100 + 101, 70);
            }
            if (map[i][j] == '@')
            {
                tree.root = tree.insertnode(tree.root, rand() % 100 + 101, -30);
            }
            if (map[i][j] == '$')
            {
                tree.root = tree.insertnode(tree.root, rand() % 100 + 101, -70);
            }
            if (map[i][j] == '&')
            {
                tree.root = tree.insertnode(tree.root, rand() % 100 + 101, -50);
            }
            if (map[i][j] == 'C' || map[i][j] == '*') {
                int source = i * MAP_WIDTH + j;
                if (i > 0 && (map[i - 1][j] == 'C' || map[i - 1][j] == '*' || map[i - 1][j] == '#')) {
                    // Up
                    int target = (i - 1) * MAP_WIDTH + j;
                    adjacency_matrix[source][target] = 1;
                }
                if (i < MAP_WIDTH - 1 && (map[i + 1][j] == 'C' || map[i + 1][j] == '*' || map[i + 1][j] == '#')) {
                    // Down
                    int target = (i + 1) * MAP_WIDTH + j;
                    adjacency_matrix[source][target] = 1;
                }
                if (j > 0 && (map[i][j - 1] == 'C' || map[i][j - 1] == '*' || map[i][j - 1] == '#')) {
                    // Left
                    int target = i * MAP_WIDTH + (j - 1);
                    adjacency_matrix[source][target] = 1;
                }
                if (j < MAP_HEIGHT - 1 && (map[i][j + 1] == 'C' || map[i][j + 1] == '*' || map[i][j + 1] == '#')) {
                    // Right
                    int target = i * MAP_WIDTH + (j + 1);
                    adjacency_matrix[source][target] = 1;
                }
            }
        }
    }
    const int INF = 1000000000;
    int start, goal;
    int start1 = 0;
    tree.root = tree.insertnode(tree.root, 100, 0);
    findStartAndGoal(map, start, goal);
    int shortestDistance = dijkstra(adjacency_matrix, start, goal);
    int shortestdistance = dijkstra(adjacency_matrix, start1, goal);
    //Main Menu
    int choice;
    system("CLS");

    while (true) {
        displayMainMenu();
        textColor(4);
        cout << "\nPlease enter your choice: ";
        textColor(4);
        cin >> choice;
        if (choice == 1) {

            cout << "*Floyd's Algorithm*\n";
            textColor(8);
            const int INF = 1000000000;
            tree.root = tree.insertnode(tree.root, 100, 0);
            const int numNodes = MAP_WIDTH * MAP_HEIGHT;
            int adjacency_matrix[numNodes][numNodes];

            for (int i = 0; i < numNodes; i++) {
                for (int j = 0; j < numNodes; j++) {
                    adjacency_matrix[i][j] = INF;
                }
            }

            for (int i = 0; i < MAP_WIDTH; i++) {
                for (int j = 0; j < MAP_HEIGHT; j++) {
                    if (map[i][j] == '#')
                    {
                        adjacency_matrix[i][j] = 100;
                    }
                    if (map[i][j] == '%')
                    {
                        adjacency_matrix[i][j] = 100;
                    }

                    if (map[i][j] == 'J')
                    {
                        tree.root = tree.insertnode(tree.root, rand() % 100 + 101, 50);
                    }
                    if (map[i][j] == 'W')
                    {
                        tree.root = tree.insertnode(tree.root, rand() % 100 + 101, 30);
                    }
                    if (map[i][j] == 'P')
                    {
                        tree.root = tree.insertnode(tree.root, rand() % 100 + 101, 70);
                    }
                    if (map[i][j] == '@')
                    {
                        tree.root = tree.insertnode(tree.root, rand() % 100 + 101, -30);
                    }
                    if (map[i][j] == '$')
                    {
                        tree.root = tree.insertnode(tree.root, rand() % 100 + 101, -70);
                    }
                    if (map[i][j] == '&')
                    {
                        tree.root = tree.insertnode(tree.root, rand() % 100 + 101, -50);
                    }
                    if (map[i][j] == 'C' || map[i][j] == '*') {
                        int source = i * MAP_WIDTH + j;
                        if (i > 0 && (map[i - 1][j] == 'C' || map[i - 1][j] == '*' || map[i - 1][j] == '#')) {
                            // Up
                            int target = (i - 1) * MAP_WIDTH + j;
                            adjacency_matrix[source][target] = 1;
                        }
                        if (i < MAP_WIDTH - 1 && (map[i + 1][j] == 'C' || map[i + 1][j] == '*' || map[i + 1][j] == '#')) {
                            // Down
                            int target = (i + 1) * MAP_WIDTH + j;
                            adjacency_matrix[source][target] = 1;
                        }
                        if (j > 0 && (map[i][j - 1] == 'C' || map[i][j - 1] == '*' || map[i][j - 1] == '#')) {
                            // Left
                            int target = i * MAP_WIDTH + (j - 1);
                            adjacency_matrix[source][target] = 1;
                        }
                        if (j < MAP_HEIGHT - 1 && (map[i][j + 1] == 'C' || map[i][j + 1] == '*' || map[i][j + 1] == '#')) {
                            // Right
                            int target = i * MAP_WIDTH + (j + 1);
                            adjacency_matrix[source][target] = 1;
                        }
                    }
                }
            }

            for (int k = 0; k < MAP_HEIGHT * MAP_WIDTH; k++) {  //all vertices
                for (int i = 0; i < MAP_HEIGHT * MAP_WIDTH; i++) {  //source vertices
                    for (int j = 0; j < MAP_HEIGHT * MAP_WIDTH; j++) {  //destination vertices
                        if (adjacency_matrix[i][k] != INF && adjacency_matrix[k][j] != INF) { //check path
                            adjacency_matrix[i][j] = min(adjacency_matrix[i][j], adjacency_matrix[i][k] + adjacency_matrix[k][j]);
                        }
                    }
                }
            }
            int start, goal;
            findStartAndGoal(map, start, goal);

            if (adjacency_matrix[0][goal] == INT_MAX) {
                cout << "No path from source to goal" << endl;
            }
            else {
                cout << "Shortest distance from source to goal: " << adjacency_matrix[0][goal] << endl;
                textColor(5);
            }
            printTree(tree.root);
            Score(tree.root);


            cout << "\n\nPress any key to main menu.....";
            textColor(4);
            q = _getch();
        }

        else if (choice == 2) {

            const int INF = 1000000000;
            tree.root = tree.insertnode(tree.root, 100, 0);
            int index1;
            int index2;
            cout << " Enter Start Index : ";
            textColor(2);
            cin >> index1;
            cin >> index2;

            int goal;
            findGoal(map, index1, goal);


            const int numNodes = MAP_WIDTH * MAP_HEIGHT;
            int adjMatrix[numNodes][numNodes];

            for (int i = 0; i < numNodes; i++) {
                for (int j = 0; j < numNodes; j++) {
                    adjMatrix[i][j] = INF;
                }
            }

            for (int i = 0; i < MAP_WIDTH; i++) {
                for (int j = 0; j < MAP_HEIGHT; j++) {
                    if (map[i][j] == '#')
                    {
                        adjMatrix[i][j] = 100;
                    }
                    if (map[i][j] == '%')
                    {
                        adjMatrix[i][j] = 100;
                    }
                    if (map[i][j] == 'J')
                    {
                        tree.root = tree.insertnode(tree.root, rand() % 100 + 101, 50);
                    }
                    if (map[i][j] == 'W')
                    {
                        tree.root = tree.insertnode(tree.root, rand() % 100 + 101, 30);
                    }
                    if (map[i][j] == 'P')
                    {
                        tree.root = tree.insertnode(tree.root, rand() % 100 + 101, 70);
                    }
                    if (map[i][j] == '@')
                    {
                        tree.root = tree.insertnode(tree.root, rand() % 100 + 101, -30);
                    }
                    if (map[i][j] == '$')
                    {
                        tree.root = tree.insertnode(tree.root, rand() % 100 + 101, -70);
                    }
                    if (map[i][j] == '&')
                    {
                        tree.root = tree.insertnode(tree.root, rand() % 100 + 101, -50);
                    }
                    if (map[i][j] == 'C' || map[i][j] == '*') {
                        int source = i * MAP_WIDTH + j;
                        if (i > 0 && (map[i - 1][j] == 'C' || map[i - 1][j] == '*' || map[i - 1][j] == '#')) {
                            // Up
                            int target = (i - 1) * MAP_WIDTH + j;
                            adjMatrix[source][target] = 1;
                        }
                        if (i < MAP_WIDTH - 1 && (map[i + 1][j] == 'C' || map[i + 1][j] == '*' || map[i + 1][j] == '#')) {
                            // Down
                            int target = (i + 1) * MAP_WIDTH + j;
                            adjMatrix[source][target] = 1;
                        }
                        if (j > 0 && (map[i][j - 1] == 'C' || map[i][j - 1] == '*' || map[i][j - 1] == '#')) {
                            // Left
                            int target = i * MAP_WIDTH + (j - 1);
                            adjMatrix[source][target] = 1;
                        }
                        if (j < MAP_HEIGHT - 1 && (map[i][j + 1] == 'C' || map[i][j + 1] == '*' || map[i][j + 1] == '#')) {
                            // Right
                            int target = i * MAP_WIDTH + (j + 1);
                            adjMatrix[source][target] = 1;
                        }
                    }
                }
            }


            for (int k = 0; k < MAP_HEIGHT * MAP_WIDTH; k++) {
                for (int i = 0; i < MAP_HEIGHT * MAP_WIDTH; i++) {
                    for (int j = 0; j < MAP_HEIGHT * MAP_WIDTH; j++) {
                        if (adjMatrix[i][k] != INF && adjMatrix[k][j] != INF) {
                            adjMatrix[i][j] = min(adjMatrix[i][j], adjMatrix[i][k] + adjMatrix[k][j]);
                        }
                    }
                }
            }

            if (adjMatrix[index1][goal] == INT_MAX) {
                cout << "No path from source to goal" << endl;
            }
            else {
                cout << "Shortest distance from source to goal: " << adjMatrix[index1][goal] << endl;
                textColor(9);
            }

            printTree(tree.root);
            Score(tree.root);

            cout << "\n\nPress any key to main menu.....";
            textColor(4);
            q = _getch();
        }


        else if (choice == 3) {
            cout << "*   Prim's Algorithm   *\n";
            textColor(6);
            prim(numNodes, adjacency_matrix);
            printMST(numNodes);
            cout << "\n\nPress any key to main menu.....";
            textColor(8);
            q = _getch();

        }
        else if (choice == 4) {
            cout << "*  Kruskal Algorithm  *\n";
            textColor(15);
            kruskal(100, adjacency_matrix);
            cout << "\n\nPress any key to main menu.....";
            textColor(4);
            q = _getch();

        }
        else if (choice == 5) {
            cout << "* Forest Map *" << endl;
            textColor(14);
            //Printing the Randomly generated Map 
            for (int i = 0; i < 10; i++) {
                for (int j = 0; j < 10; j++) {
                    cout << map[i][j] << " ";
                }
                cout << endl;
            }
            cout << "\n\nPress any key to main menu.....";
            textColor(4);
            q = _getch();

        }
        else if (choice == 6) {

            cout << "* Adjacency Matrix *" << endl;
            textColor(18);
            // Printing that adjacency_matrix
            for (int i = 0; i < numNodes; i++)
            {
                for (int j = 0; j < numNodes; j++)
                {
                    cout << adjacency_matrix[i][j];
                }
                cout << endl;
            }
            cout << "\n\nPress any key to main menu.....";
            textColor(4);
            q = _getch();

        }
        else if (choice == 7) {
            //Dijsktra Algorithm
            cout << "*Dijsktra Algorithm*" << endl;
            textColor(8);
            cout << endl;

            cout << "Shortest distance (Number of Minimum Nodes to get to the Diamond) : " << shortestDistance << endl;
            textColor(14);
            printTree(tree.root);
            Score(tree.root);

        }
        else if (choice == 8) {
            int start2;
            //Dijsktra Algorithm from custom location
            cout << "Enter the starting index " << endl;
            textColor(10);
            cin >> start1;
            cin >> start2;
            shortestdistance = dijkstra(adjacency_matrix, start1, goal);
            cout << "Shortest distance from custom index  (Number of Minimum Nodes to get to the Diamond) : " << shortestdistance << endl;
            textColor(8);
            printTree(tree.root);
            textColor(5);
            Score(tree.root);
            textColor(5);

        }
        else
            cout << "Invalid choice!\n";
    }
    return 0;
}