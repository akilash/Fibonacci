# Fibonacci

Fibonacci is a relatively small project I created to infinitely output the fibonacci sequence, as presented in a UITableView.  The core objective of the project was to provide an efficient and performant method of inifinitely generating the fibonacci sequence outside the bounds of integer precision limits imposed by 64-bit system architechtures.  Integers larger than 2^64 on 64-bit architectures will exhibit integer truncation.  Fibonacci numbers after the 93rd number in the sequence, or in general, numbers larger than 18,446,744,073,709,600,000 (2^64) will lose precision and hence invalidate the precision of all subsequent values generated.

### Libraries Used
I leveraged the open sourced BigInteger library which obfuscates the arbitrary precision arithmitic computations.  
 - [BigInteger-ObjC](https://github.com/PascalLG/biginteger-objc)

### Notes
The algorithm used is the iterative, dynamic programming approach.  Although more asymtotically efficient than the recursive approach, it is not as efficient as the matrix exponentiation or fast doubling approach.

### Future Improvements
- Implement a faster algorithm, namely the matrix exponentiation or fast doubling approach.
- Design and implement a more intuitive and aesthetically appealing UI for presenting the numbers in the sequence