#!/usr/bin/env python
#project euler problem 2

three = 0
sum = 2

def fib(one, two):
    global three
    global sum
    while (three <= 4000000):
            three = (one + two)
            if (three % 2 == 0):
                    sum += three
            fib(two, three)

fib(1, 2)
print sum
