from part1 import part1
from part2 import part2
import time

test1_val = 0
test2_val = 0

if part1("data/test1") == test1_val:
    start_time = time.time()
    print('Solution is {}'.format(part1("data/input")))
    print("--- %s seconds ---" % (time.time() - start_time))
else:
    print("Test 1 failed")

if part2("data/test2") == test2_val:
    start_time = time.time()
    print('Solution is {}'.format(part2("data/input")))
    print("--- %s seconds ---" % (time.time() - start_time))
else:
    print("Test 2 failed")
