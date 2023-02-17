#include <stdio.h>
#include "SwinGame.h"

typedef struct disk {
    int width;
    color clr;
} disk;

#define MAX 10
#define NUM 4
#define DISK_HEIGHT 10
#define DISK_WIDTH 30
#define DISK_GAP 20
#define TOWER_WIDTH 120

disk towers[3][MAX];

int get_index_for_letter(char c) {

int t = 0;

    switch (c) {
        case 'A':
            t = 0;
            break;
        case 'B':
            t = 1;
            break;
        case 'C':
            t = 2;
            break;
    }
    return t;
}

disk pop(char c) {
    int i;
    int t = 0;
    disk new_disk;

    t = get_index_for_letter(c);

    new_disk.width = 0;
    new_disk.clr = ColorWhite;

    for (i = MAX-1;i >= 0; i--) {
        if (towers[t][i].width > 0) {
            new_disk.width = towers[t][i].width;
            new_disk.clr = towers[t][i].clr;
            towers[t][i].width = 0;
            return new_disk;
        }   
    }   
    return new_disk;     
}

void push(char c, disk push_disk) {
    
    int i;
    int t = 0;

    t = get_index_for_letter(c);

    for (i=0; i<MAX; i++) {
        if (towers[t][i].width == 0) {
            towers[t][i].width = push_disk.width;
            towers[t][i].clr = push_disk.clr;
            return;
        }
    }   
}


void printTowersToTerminal() {
    int t = 0;
    int d = 0;  

    for (t = 0; t < 3; t++) {
        printf("\nTower %d ", t);
        for (d = 0; d < MAX; d++) {
            if (towers[t][d].width > 0)
                printf("Disk %d ", towers[t][d].width);
        }
    }
    printf("\n");
}


void print_disk(int width, int xlocation, int ylocation, color c) {

    fill_rectangle(c, xlocation, ylocation, DISK_WIDTH * width, DISK_HEIGHT);
}


void print_tower(int t) {
int d;
int xoffset = 0;
int yoffset = 0;
     
    for (d = 0; d < MAX; d++) {
        if (t > 0)
            xoffset = (TOWER_WIDTH * t) + (t * DISK_GAP);
        if (towers[t][d].width > 0) {
            yoffset = DISK_HEIGHT * (MAX - d);
            print_disk(towers[t][d].width, xoffset, yoffset, towers[t][d].clr);
        }
    }
    
}

void print_tower_graphics() {
    int t = 0;  

    clear_screen(ColorWhite);   

    for (t = 0; t < 3; t++) {
        print_tower(t);
    }

    refresh_screen();
    delay(1000);
}


void hanoi(int nbr, char s, char d, char a) {
    disk temp;

    if (nbr == 1) {  
        temp = pop(s);
        push(d, temp); 
        printf("\nmove Disk %d from peg %c to %c", nbr, s, d);
        print_tower_graphics();    
        return;
    }

    hanoi(nbr - 1, s, a, d);

    printf("\nmove Disk %d from peg %c to %c", nbr, s, d);
    temp = pop(s);
    push(d, temp); 
    print_tower_graphics();  

    hanoi(nbr - 1, a, d, s);
}



void initTowersAndDisks(int disk_count) {
    int d = 0;
    int t = 0;

    for (t = 1; t < 3; t++) {   
       for (d=0; d < MAX; d++) {
            towers[t][d].width = 0;
            towers[t][d].clr = ColorBlue;
        }
    }  

    for (d=0; d < disk_count; d++) {
        towers[0][d].width = disk_count - d;
        towers[0][d].clr = ColorBlue;
    }
      
}

int main(int argv, char *argc[])
{
	initTowersAndDisks(NUM);

    open_graphics_window("Towers of Hanoi", 400, 350);
    clear_screen(ColorWhite);

    print_tower_graphics();

    hanoi(NUM,'A','C','B');

    print_tower_graphics();
    
    delay(2000);

    return 0;
}

