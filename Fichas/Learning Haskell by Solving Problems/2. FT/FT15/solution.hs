myMaximum :: Ord a => [a] -> a

myMaximum (x:xs) = myMaximumAux xs x
myMaximum [] = error "Empty list"

myMaximumAux [] m = m
myMaximumAux (x:xs) max = if x > max then myMaximumAux xs x else myMaximumAux xs max
