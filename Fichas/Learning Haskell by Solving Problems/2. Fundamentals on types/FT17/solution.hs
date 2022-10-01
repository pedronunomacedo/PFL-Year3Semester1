nth1 :: (Eq a, Num a) => a -> [b] -> b

nth1 _ [] = error "Index out of range"
nth1 1 (x:_) = x
nth1 n (_:xs) = nth1 (n-1) xs
