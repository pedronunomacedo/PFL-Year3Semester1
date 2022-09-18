isPrime n
  | (n <= 1)       = False
  | (n == 2)       = True
  | (mod n 2 == 0) = False
  | otherwise      = isDivisorOfn 1 n 0

isDivisorOfn t n numTimes
  | (t > n && numTimes /= 2) = False
  | (t > n && numTimes == 2)  = True
  | ((mod n t) == 0)          = isDivisorOfn (t + 1) n (numTimes + 1)
  | otherwise                 = isDivisorOfn (t + 1) n numTimes
