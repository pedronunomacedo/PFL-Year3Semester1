myGroup :: Eq a => [a] -> [[a]]
myGroup [] = []
myGroup [x] = [[x]]
myGroup (x:y:xs)
  | x == y = (x:g):gs
  | otherwise = [x]:g:gs
  where (g:gs) = myGroup (y:xs)
