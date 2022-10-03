differentFromNext :: Eq a => [a] -> [a]
differentFromNext [] = []
differentFromNext l = [x | (x,y) <- zip l (tail l), x /= y] ++ [head (reverse l)]
