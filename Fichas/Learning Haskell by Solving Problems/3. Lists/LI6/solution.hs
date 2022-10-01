conseqPairs :: [a] -> [(a,a)]
conseqPairs [] = []
conseqPairs [x] = []
conseqPairs (x:y:xs) = (x,y) : conseqPairs xs
