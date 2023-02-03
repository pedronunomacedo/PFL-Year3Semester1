import Data.Maybe (fromJust)
main :: IO ()
main = return ()

-- 1.1
testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c = (a > b + c && b > a + c && c > a + b)

-- 1.2
areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt(s * (s - a) * (s - b) * (s - c))
                        where s = (a + b + c) / 2

-- 1.3
metades :: [Int] -> ([Int], [Int])
metades list = (metade1, metade2)
                where metade1 = take ((length list) `div` 2) list
                      metade2 = drop ((length list) `div` 2) list

-- 1.4
-- a)
myLast :: [Int] -> Int
myLast list = head (reverse list)

-- b)
myInit :: [Int] -> [Int]
myInit list = reverse (tail (reverse list))

-- 1.5
-- a)
binom :: Integer -> Integer -> Integer
binom n k = factN `div` (factK * factDiff)
            where factN = product [1..n]
                  factK = product [1..k]
                  factDiff = product [1..(n-k)]

-- b)
binom2 :: Integer -> Integer -> Integer
binom2 n k
    | (k < n - k) = product [(n - k + 1)..n] `div` product [1..k]
    | otherwise = product [(k+1)..n] `div` product [1..(n-k)]

-- 1.6
raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c = (r1, r2)
            where r1 = (-b - (sqrt delta)) / (2 * a)
                  r2 = (-b + (sqrt delta)) / (2 * a)
                  delta = (b^2 - 4 * a * c)

                  