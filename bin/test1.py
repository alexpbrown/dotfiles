#!/usr/bin/env python
#projecteuler problem 1

x = 3
y = 5
z = 15
result = 0
while (x < 1000):
        result += x
        x = x + 3
while (y < 1000):
        result += y
        y = y+5
while (z < 1000):
        result -= z
        z = z+15
print result
