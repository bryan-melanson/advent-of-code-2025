CC = gcc
CFLAGS = -Wall -Wextra

ifeq ($(OS),Windows_NT)
    EXECUTABLE = main.exe
else
    EXECUTABLE = main
endif

SRCS = main.c part1.c part2.c
OBJS = $(SRCS:.c=.o)

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS) $(EXECUTABLE)