max3 a b c
  | (a >= b && a >= c) = a
  | (b >= a && b >= c) = b
  | (c >= a && c >= b) = c
