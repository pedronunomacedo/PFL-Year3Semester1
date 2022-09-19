-- 1.1
-- testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c = (a < b + c && b < a + c && c < a + b)

-- 1.2
-- areaTriangulo :: Float -> Float -> Float -> Bool
areaTriangulo a b c = sqrt (s*(s-a)*(s-b)*(s-c))
                        where s = (a + b + c) / 2

-- 1.3
metades l = (metade1, metade2)
              where metade1 = take ((length l) `div` 2) l
                    metade2 = drop ((length l) `div` 2) l

-- 1.4 a)
lastElem l = head (reverse l)

-- 1.4 b)
removeLastElem l = take ((length l) - 1) l

-- 1.5 a)
-- binom :: Integer -> Integer -> Integer
binom n k = factN `div` (factK * fact)
            where factN = product [1..n]
                  factK = product [1..k]
                  fact = product [1..(n-k)]

-- 1.5 b)
binom' n k
  | (k < n - k) = factN1 `div` factK
  | otherwise   = factN2 `div` factD
  where factN1 = product [(n - k + 1)..n]
        factK = product [1..k]
        factN2 = product [(k + 1)..n]
        factD = product [1..(n - k)]

-- 1.6
raizes :: Float -> Float -> Float -> (Float,Float)
raizes a b c = (r1, r2)
                where r1 = (-b - (sqrt delta)) / (2 * a)
                      r2 = (-b + (sqrt delta)) / (2 * a)
                      delta = (b^2 - 4 * a * c)


-- Tipos e Classes

-- 1.7
  -- a) ['a','b','c'] :: [Char]
  -- b) ('a','b','c') :: (Char, Char, Char)
  -- c) [(False,'0'),(True,'1'))] :: [(Bool,Char)]
  -- d) ([False,True],['0','1']) :: ([Bool],[Char])
  -- e) [tail,init,reverse] :: [[a] -> [a]]
  -- f) [id,not] :: [Bool -> Bool]

-- 1.8
  -- a) segundo :: (x:y:xs) -> y
  -- b) trocar :: (t1,t2) -> (t2,t1)
  -- c) par :: t1,t2 -> (t1,t2)
  -- d) dobro :: t -> t
