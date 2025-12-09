CXX = g++
CXXFLAGS = -Wall -Wextra

ifeq ($(OS),Windows_NT)
    EXECUTABLE = main.exe
else
    EXECUTABLE = main
endif

SRCS = main.cpp part1.cpp part2.cpp
OBJS = $(SRCS:.cpp=.o)

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS) $(EXECUTABLE)