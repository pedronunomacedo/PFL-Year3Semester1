-- a)
myTake :: Int -> [a] -> [a]
myTake 0 _ = []
myTake _ [] = []
myTake n (x:xs)
  | (n > 0) = x:(myTake (n-1) xs)
  | otherwise = error "Negative number in first argument!"

-- b)
myDrop :: Int -> [a] -> [a]
myDrop 0 l = l
myDrop _ [] = []
myDrop n (x:xs) = myDrop (n-1) xs
