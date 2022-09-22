main :: IO ()
main = return ()

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
  -- e)
  -- f)
  -- g)
  -- h)
  -- i)

-- 1.9
classifica :: Int -> String
classifica n
  | (n <= 9)             = "reprovado"
  | (n >= 10 && n <= 12) = "suficiente"
  | (n >= 13 && n <= 15) = "bom"
  | (n >= 16 && n <= 18) = "muito bom"
  | (n >= 19 && n <= 20) = "muito bom com distincao"

-- 1.10
classificaIMC :: Float -> Float -> String
classificaIMC peso altura
  | (imc < 18.5)              = "baixo peso"
  | (imc >= 18.5 && imc < 25) = "peso normal"
  | (imc >= 25 && imc < 30)   = "excesso de peso"
  | (imc >= 30)               = "obesidade"
  where imc = peso / (altura^2)


-- 1.11 a)
max3, min3 :: Ord a => a -> a -> a -> a
max3 x y z
  | (x >= y && x >= z) = x
  | (y >= x && y >= z) = y
  | (z >= x && z >= y) = z

min3 x y z
  | (x <= y && x <= z) = x
  | (y <= x && y <= z) = y
  | (z <= x && z <= y) = z

-- 1.11 b)
max3recur :: Ord a => a -> a -> a -> a
max3recur x y z = max (max x y) z

min3recur :: Ord a => a -> a -> a -> a
min3recur x y z = min (min x y) z

-- 1.12
xor :: Bool -> Bool -> Bool
xor x y
  | x && y             = False
  | (not x) && y       = True
  | x && (not y)       = True
  | (not x) && (not y) = False

-- 1.13
safetail1 :: [a] -> [a]
safetail1 l
  | (length l) == 0 = []
  | otherwise = (tail l)

safetail2 :: [a] -> [a]
safetail2 l = if (length l == 0) then [] else (tail l)

-- 1.14 a)
curta1 :: [a] -> Bool
curta1 l = if (length l <= 2) then True else False

-- 1.14 b)
curta2 :: [a] -> Bool
curta2 xs = if (null xs) then True else (if (curta2Aux xs) <= 2 then True else False)

curta2Aux :: [a] -> Int
curta2Aux = curta2Aux 0
    where curta2Aux a [] = a
          curta2Aux a (_:xs) = curta2Aux (a+1) xs
