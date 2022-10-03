import Data.List

-- 3.1
comb f p xs = map f (filter p xs)

-- 3.2
dec2int :: [Int] -> Int
dec2int l = foldl (\x y -> x * 10 + y) 0 l

-- 3.3
myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ [] _ = []
myZipWith _ _ [] = []
myZipWith f (x:xs) (y:ys) = (f x y):(myZipWith f xs ys)

-- 3.4
isort :: Ord a => [a] -> [a]
isort l = foldr (\x y -> (insert x y)) [] l
