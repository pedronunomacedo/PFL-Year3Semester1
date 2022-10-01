-- a)
myAnd :: [Bool] -> Bool

myAnd [] = True
myAnd (x:xs) = x && myAnd(xs)
