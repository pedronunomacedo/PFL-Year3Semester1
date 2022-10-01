myElem :: Eq a => a -> [a] -> Bool

myElem elem [] = False
myElem elem (x:xs) = if elem == x then True else myElem elem xs
