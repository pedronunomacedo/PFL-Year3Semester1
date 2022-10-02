iSort :: [Int] -> [Int]

iSort [] = []
iSort [x] = [x]
iSort (x:xs) = insert x (iSort xs)


-- Compares the current number with the array in front of it,
-- and put it in the right place
insert :: Int -> [Int] -> [Int]
insert x [] = [x]
insert x (y:ys)
  | (x <= y)   = x:y:ys
  | otherwise = y : (insert x ys)
