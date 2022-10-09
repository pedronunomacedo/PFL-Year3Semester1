import Data.Char

--------------- Divide the given array in string parts ---------------

splitArray :: [Char] -> [[Char]]
splitArray [] = [[]]
splitArray [x] = []
splitArray l = (splitPair l):(splitArray (makeArray l 0))


splitPair :: [Char] -> [Char]
splitPair [] = []
splitPair (x:xs)
  | (null xs) = [x]
  | (((head xs) == '+') || ((head xs) == '-')) = [x]
  | otherwise = [x] ++ (splitPair xs)

makeArray :: [Char] -> Integer -> [Char]
makeArray [] _ = []
makeArray [x] _ = [x]
makeArray (x:xs) num
  | (null xs) = [x]
  | ((((head xs) == '+') || ((head xs) == '-')) && num == 0) = makeArray xs 1
  | ((((head xs) /= '+') || ((head xs) /= '-')) && num == 0) = makeArray xs 0
  | otherwise = [x] ++ (makeArray xs 1)

--------------- Transform the list of strings in [(num, letter, coef),...] ---------------
searchForTimes :: [Char] -> Bool
searchForTimes [] = False
searchForTimes (x:xs)
  | (x == '*') = True
  | otherwise = searchForTimes xs

searchForPower :: [Char] -> Bool
searchForPower [] = False
searchForPower (x:xs)
  | (x == '^') = True
  | otherwise = searchForPower xs
