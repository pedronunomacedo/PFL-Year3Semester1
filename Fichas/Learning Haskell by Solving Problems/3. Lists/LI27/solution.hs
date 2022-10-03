scalarProduct :: Num a => [a] -> [a] -> a
scalarProduct l1 l2 = sum [x*y | (x,y) <- zip l1 l2]
