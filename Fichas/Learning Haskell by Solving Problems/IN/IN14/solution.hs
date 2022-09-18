factorial 0 = 1
factorial n
  | (n > 0) = n * factorial(n - 1)
  | (n < 0) = error "negative argument"
