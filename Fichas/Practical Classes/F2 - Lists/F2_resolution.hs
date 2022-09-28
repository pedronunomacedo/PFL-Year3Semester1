-- import libraries (the imports need to be all in the beginning of the file)
import Data.Char

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

-- 2.5 a)
myMinimum :: Ord a => [a] -> a
myMinimum [l] = l
myMinimum (x:xs) = myMinimumAux x xs

myMinimumAux min [l] = if (l <= min) then l else min
myMinimumAux min (x:xs)
  | x < min = myMinimumAux x xs
  | otherwise = myMinimumAux min xs

-- 2.5 b)
myDelete :: Ord a => a -> [a] -> [a]
myDelete n [] = error "Number not found!"
myDelete n (x:xs)
  | n == x    = xs
  | otherwise = [x] ++ myDelete n xs

-- 2.5 c)
mySsort :: Ord a => [a] -> [a]
mySsort [] = []
mySsort l = [myMinimum l] ++ mySsort (myDelete (myMinimum l) l)

-- 2.6
sumUntil100 = sum [n^2 | n <- [1..100]]

-- 2.7 a)
aprox :: Int -> Double
aprox 0 = 1
aprox n = ((fromIntegral ((-1)^n)) / (fromIntegral (2 * n + 1))) + aprox (n-1)

-- 2.7 b)
aprox' :: Int -> Double
aprox' 0 = 1
aprox' k = ((fromIntegral ((-1)^k)) / (fromIntegral ((k+1)^2))) + aprox (k-1)

-- 2.7
{--
  Comparando aprox com aprox', podemos verificar que o aprox' é mais eficaz que o aprox.
  aprox 10 = 0.8080789523513985
  aprox' 10 = 0.7687243675422681
  aprox 100 = 0.7878733502677479
  aprox' 100 = 0.7829962554945791
  aprox 1000 = 0.7856479135848861
  aprox' 1000 = 0.7851491614629446
  pi/4 ≈ 0.785398163
--}

-- 2.8
dotprod :: [Float] -> [Float] -> Float
dotprod a b = sum [ x * y | (x, y) <- zip a b ]

-- 2.9
divprop :: Integer -> [Integer]
divprop n = [i | i <- [1..(n-1)], mod n i == 0]

-- 2.10
perfeitos :: Integer -> [Integer]
perfeitos n = [i | i <- [2..(n-1)], sum (divprop i) == i]

-- 2.11
pitagoricos :: Integer -> [(Integer, Integer, Integer)]
pitagoricos n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]

-- 2.12
primo :: Integer -> Bool
primo n = if (length( divprop n ) == 1) then True else False

-- 2.13 ???
mersennes :: [Int]
mersennes = [i | i <- [1..30], primo (2^i - 1)]

-- 2.14
binom :: Integer -> Integer -> Integer
binom n k = product [1..n] `div` (product [1..k] * product [1..(n-k)])

pascal :: Integer -> [[Integer]]
pascal m = [l | n <- [0..m], let l = [binom n k | k <- [0..n]]]

-- 2.15
cifrar :: Int -> String -> String
cifrar n s = [
  if (fromEnum c > 64 && fromEnum c < 91) then toEnum (65 + mod (fromEnum c - 65 + n) 26) else
  if (fromEnum c > 96 && fromEnum c < 123) then toEnum (96 + mod (fromEnum c - 96 + n) 26) else c | c <- s]

-- 2.16
myConcat2 :: [[a]] -> [a]
myConcat2 l = [x | sub <- l, x <- sub]

myReplicate2 :: Int -> a -> [a]
myReplicate2 n c = [c | _ <- [1..n]]

twoExclamations2 :: Integral b => [a] -> b -> a
twoExclamations2 l n = head [ x | (x,i) <- zip l [0 ..], i == n ]

-- 2.17
forte :: String -> Bool
forte str = length str >= 8 && myOr (map isUpper str) && myOr (map isLower str) && myOr (map isDigit str)

-- 2.18 a)
mindiv :: Int -> Int
mindiv n = head ([i | i <- [2..round (sqrt (fromIntegral n))], mod n i == 0] ++ [n])

-- 2.18 b)
primo2 :: Int -> Bool
primo2 n = if (n > 1 && (mindiv n) == n) then True else False
