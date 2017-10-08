final int SQUARE_SIZE = 10;
int numRows, numCols;
boolean[][] grid;
int generation = 0;
boolean settingUp = true;

void setup() {
    size(900, 900);
    numRows = width/SQUARE_SIZE;
    numCols = height/SQUARE_SIZE;
    grid = new boolean[numRows][numCols];
}


void draw() {
    if (settingUp) {
        frameRate(30);
        int[] coords = getIndex(mouseX, mouseY);
        int i = coords[0];
        int j = coords[1];
        if (mousePressed) {
            if (mouseButton == LEFT) {
                grid[i][j] = true;
            } else {
                grid[i][j] = false;
            }
        }
        if (keyPressed && key == 's') {
            settingUp = false;
        }
    } else {
        frameRate(5);
        applyRules();
        if (keyPressed && key == 'r') {
            settingUp = true;
            grid = new boolean[numRows][numCols];
            generation = 0;
        }
    }

    drawGrid();
}

void applyRules() {
    boolean[][] nextGrid = new boolean[numRows][numCols];

    for (int i=0; i<numRows; i++) {
        for (int j=0; j<numCols; j++) {
            int numNeighbours = getNumberOfNeighbours(i, j);
            if (numNeighbours < 2) {
                nextGrid[i][j] = false;
            } else if (numNeighbours > 3) {
                nextGrid[i][j] = false;
            } else if (numNeighbours == 3){
                nextGrid[i][j] = true;
            } else {
                if(grid[i][j]) {
                     nextGrid[i][j] = true;  
                }
            }
        }
    }
    grid = nextGrid;
}

void drawGrid() {
    background(0);
    fill(255);
    for (int i=0; i<numRows; i++) {
        for (int j=0; j<numCols; j++) {
            if (grid[i][j]) {
                int x = i*SQUARE_SIZE;
                int y = j*SQUARE_SIZE;
                rect(x, y, SQUARE_SIZE, SQUARE_SIZE);
            }
        }
    }

    fill(150, 100, 0);
    rect(20, 20, 200, 80);
    fill(255);
    if (settingUp) {
        text("Draw the initial cells", 50, 50);
    } else {
        text("Simulation is running", 50, 50);
        text("Generation: " + generation++, 50, 80);
    }
}

int[] getIndex(int x, int y) {
    int[] cleanedCoords = {min(max(x, 0), width-1), min(max(y, 0), height-1) - 1};
    cleanedCoords[0] = cleanedCoords[0] / SQUARE_SIZE;
    cleanedCoords[1] = cleanedCoords[1] / SQUARE_SIZE;
    return cleanedCoords;
}

int getNumberOfNeighbours(int r, int c) {
    int numberOfNeighbours = 0;
    int count = 0;

    int rowMin = max(r-1, 0);
    int rowMax = min(r+1, numRows-1);

    int colMin = max(c-1, 0);
    int colMax = min(c+1, numCols-1);

   // println("Checking Cell (" + r + "," + c + ")");

    for (int row = rowMin; row <= rowMax; row++) {
        for (int col = colMin; col <= colMax; col++) {
            //println(count++ + ": Checking (" + x + ", " + y + ")"); 
            if (row != r || col != c) {
                if (grid[row][col]) {
                    numberOfNeighbours ++;
                }
            }
        }
    }
    
    if(numberOfNeighbours > 0) {
        println("(" + r + "," + c + ") had " + numberOfNeighbours + "\n");
    }
    
    return numberOfNeighbours;
}