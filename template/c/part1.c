#include <stdio.h>

int solve1(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        perror("Error opening file");
        return -1;
    }

    int result = 0;
    char line[100];

    while (fgets(line, sizeof(line), file) != NULL) {
        printf("%s\n", line);
    }

    fclose(file);
    return result;
}