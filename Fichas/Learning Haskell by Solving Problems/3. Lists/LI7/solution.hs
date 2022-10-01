-- a)
deleteOne :: Eq a => a -> [a] -> [a]
deleteOne _ [] = []
deleteOne ch (x:xs)
  | (x == ch) = xs
  | otherwise = x:(deleteOne ch xs)

-- b)
deleteAll :: Eq a => a -> [a] -> [a]
deleteAll _ [] = []
deleteAll ch (x:xs)
  | (x == ch) = deleteAll ch xs
  | otherwise = x:(deleteAll ch xs)
