myMinimum (x:xs) = myMinimumAux xs x
myMinimum [] = error "Empty list"

myMinimumAux [] m = m
myMinimumAux (x:xs) m
  | x < m     = myMinimumAux xs x
  | otherwise = myMinimumAux xs m
