-- a)
mySum :: Num a => [a] -> a

mySum [] = 0
mySum (x:xs) = x + (mySum xs)

-- b)
myProduct :: Num a => [a] -> a

myProduct [] = 1
myProduct (x:xs) = x * (myProduct xs)
