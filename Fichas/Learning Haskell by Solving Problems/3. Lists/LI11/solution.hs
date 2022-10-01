myIntersperse :: Eq a => a -> [a] -> [a]
myIntersperse _ [] = []
myIntersperse ch (x:xs) = if (xs == []) then [x] else x:ch:(myIntersperse ch xs)
