partir :: Eq a => a -> [a] -> ([a],[a])
partir n l
    | (length (filter (== n) l) == 0) = (l, [])
    | otherwise = (takeWhile (/= n) l, dropWhile (/= n) l)