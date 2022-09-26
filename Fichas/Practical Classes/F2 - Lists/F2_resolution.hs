-- 2.1 a)
myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (x:xs) = if (x == True) then myAnd xs else False

-- 2.1 b)
myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = if (x == True) then True else myOr xs

-- 2.1 c)
myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (x:xs) = x ++ myConcat xs

-- 2.1 d)
myReplicate :: Int -> a -> [a]
myReplicate 0 a = []
myReplicate n a = [a] ++ replicate (n-1) a

-- 2.1 e)
twoExclamations :: [a] -> Int -> a
twoExclamations (x:xs) 0 = x
twoExclamations [] n = error "index out of range"
twoExclamations (x:xs) n = twoExclamations xs (n-1)

-- 2.1 f)
myElem :: Eq a => a -> [a] -> Bool
myElem n [] = False
myElem n (x:xs) = if (x == n) then True else myElem n xs


-- 2.2
myIntersperse :: a -> [a] -> [a]
myIntersperse d [] = error "Empty string"
myIntersperse d [x] = [x]
myIntersperse d (x:xs) = [x] ++ [d] ++ myIntersperse d xs

-- 2.3
myMdc :: Integer -> Integer -> Integer
myMdc a b
  | (b == 0)  = a
  | otherwise = myMdc b (a `mod` b)

-- 2.4 a)
myInsert :: Ord a => a -> [a] -> [a]
myInsert n [] = [n]
myInsert n (a:xs)
  | (n >= a && xs == []) = [a] ++ [n]
  | (n <= a && xs == []) = [n] ++ [a]
  | (n <= a) = n:a:xs
  | otherwise = a:(myInsert n xs)

-- 2.4 b)
myIsort :: Ord a => [a] -> [a]
myIsort [] = []
myIsort (x:xs) = myInsert x (myIsort xs)
