class Cell {
    boolean alive;
    int red;
    int blue;
    
    final static int COLOUR_STEP = 2;

    Cell() {
        alive = false;
        red = 0;
        blue = 255;
    }

    void kill() {
        this.alive = false;
        this.red = 0;
        this.blue = 255;
    }

    void create() {
        this.alive = true;
    }

    void age() {
        if (blue > 20) {
            this.blue -= COLOUR_STEP;
        }
        
        if (red < 255) {
            this.red += COLOUR_STEP;
        }
    }
}