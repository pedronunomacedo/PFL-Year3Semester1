conseqPairs :: Eq a => [a] -> [(a,a)]
conseqPairs l = [(x,y) | (x,y) <- zip l (tail l)]
