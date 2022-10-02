myNub :: [Char] -> [Char]
myNub [] = []
myNub (x:xs) = x:(myNub (findMoreOccurences x xs))

findMoreOccurences :: Char -> [Char] -> [Char]
findMoreOccurences ch [] = []
findMoreOccurences ch (y:ys)
  | (ch == y) = findMoreOccurences ch ys
  | otherwise = y:(findMoreOccurences ch ys)
