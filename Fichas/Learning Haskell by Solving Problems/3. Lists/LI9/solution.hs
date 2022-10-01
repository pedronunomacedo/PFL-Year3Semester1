myReplicate :: Int -> a -> [a]
myReplicate 0 num = []
myReplicate n num
  | (n < 0)   = error "Number of times to repeat num needs to be a positive integer number!"
  | otherwise = num:(myReplicate (n-1) num)
