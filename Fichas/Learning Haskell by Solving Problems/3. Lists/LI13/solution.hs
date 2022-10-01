mySplitAt :: Int -> [a] -> ([a],[a])

mySplitAt n l
  | (n >= length l) = (l, [])
  | otherwise       = (take n l, reverse (take ((length l) - n) (reverse l)))
