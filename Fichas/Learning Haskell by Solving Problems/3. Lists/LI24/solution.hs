qSort :: Ord a => [a] -> [a]
qSort [] = []
qSort (x:xs) = (qSort lower) ++ [x] ++ (qSort upper)
                where (lower, upper) = partition x xs

partition :: Ord a => a -> [a] -> ([a],[a])
partition _ [] = ([],[])
partition piv (x:xs)
  | (x <= piv) = (x:l1, l2)
  | otherwise  = (l1, x:l2)
  where (l1,l2) = partition piv xs
