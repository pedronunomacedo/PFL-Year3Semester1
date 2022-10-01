append :: [a] -> [a] -> [a]
append [] l2 = l2
append (x:xs) l2 = x:(append xs l2)
