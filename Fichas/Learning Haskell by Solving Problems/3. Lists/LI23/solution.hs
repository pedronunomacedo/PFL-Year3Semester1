import Data.List

mSort :: Ord a => [a] -> [a]
mSort [] = []
mSort [x] = [x]
mSort l = merge (mSort l1) (mSort l2)
            where (l1,l2) = splitAt (div (length l) 2) l

merge :: Ord a => [a] -> [a] -> [a]
merge [] l = l
merge l [] = l
merge (x:xs) (y:ys)
  | (x < y)   = x:(merge xs (y:ys))
  | otherwise = y:(merge (x:xs) ys)
