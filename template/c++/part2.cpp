#include <fstream>
#include <iostream>

int solve2(const char *filename) {
    std::ifstream file(filename);
    if (!file.is_open()) {
        std::cerr << "Error opening file: " << filename << std::endl;
        return -1;
    }

    int result = 0;
    std::string line;

    while (std::getline(file, line)) {
        // Process each line as needed
        // For simplicity, let's assume each line contains an integer
        result += std::stoi(line);
    }

    file.close();
    return result;
}