#!/usr/bin/env python
#projecteuler problem 1

result = 0
for i in xrange(1000):
        if ( (i % 3 == 0) or (i % 5 == 0) ):
                result += i
print result
