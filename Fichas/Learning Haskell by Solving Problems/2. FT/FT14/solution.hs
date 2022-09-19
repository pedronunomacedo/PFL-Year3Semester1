scalarProduct :: Num a => [a] -> [a] -> a

scalarProduct [][] = 0
scalarProduct (x:xs) (y:ys) = (x*y) + (scalarProduct xs ys)
