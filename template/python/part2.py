def part2(x):
    total = -1
    with open(x, "r") as f:
        for line in f.read().splitlines():
            print(line)
    return total
