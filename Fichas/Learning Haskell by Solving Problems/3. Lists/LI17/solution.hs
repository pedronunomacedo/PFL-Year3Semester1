differentFromNext :: Eq a => [a] -> [a]

differentFromNext [] = []
differentFromNext [x] = []
differentFromNext (x:y:xs)
  | (x == y) = differentFromNext (y:xs)
  | otherwise = x:(differentFromNext (y:xs))
