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

-- 3.5 a)
myMaximum :: Ord a => [a] -> a
myMaximum [] = error "The list needs to have at least one element!"
myMaximum l = foldl (\x y -> (if (x >= y) then x else y) ) (head l) l

myMinimum :: Ord a => [a] -> a
myMinimum [] = error "The list needs to have at least one element!"
myMinimum l = foldr (\x y -> (if (x <= y) then x else y) ) (head l) l

-- 3.5 b)
myFoldl1 :: Ord a => (a -> a -> a) -> [a] -> a
myFoldl1 f l = foldl f (head l) (tail l)

myFoldr1 :: (b -> b -> b) -> [b] -> b
myFoldr1 f l = foldr f (last l) (init l)

-- 3.6
mdc :: (a -> Bool) -> (a -> a) -> a -> a
mdc a b =
