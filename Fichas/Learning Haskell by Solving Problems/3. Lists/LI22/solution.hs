import Data.List

sSort :: [Int] -> [Int]
sSort [] = []
sSort (x:xs) = (findMin x xs) : (sSort (delete (findMin x (x:xs)) (x:xs)))


findMin :: Int -> [Int] -> Int
findMin x [] = x
findMin x (y:ys)
  | (x <= y)  = findMin x ys
  | otherwise = findMin y ys
