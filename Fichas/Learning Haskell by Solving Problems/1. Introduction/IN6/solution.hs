-- a)
-- half :: Fractional a => a -> a
half x = x/2

-- b)
xor a b = (a && (not b)) || ((not a) && b)

-- c)
cbrt x = x ^ (1/3)

-- d)
heron a b c =
  sqrt (s * (s-a)*(s-b)*(s-c))
  where s = (a+b+c)/2
