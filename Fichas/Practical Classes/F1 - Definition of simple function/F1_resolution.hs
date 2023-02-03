import Data.Maybe (fromJust)
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

-- 1.15 a)
mediana x y z
  | ((y <= x && x <= z) || (z <= x && x <= y)) = x
  | ((x <= y && y <= z) || (z <= y && y <= x)) = y
  | ((x <= z && z <= y) || (y <= z && z <= x)) = z
  | otherwise = error "Error"

-- 1.15 b)
mediana2 x y z = (x + y + z) - menores
  where menores
          | ((x <= y && x <= z && y <= z) || (z <= y && z <= x && y <= x)) = x + z
          | ((y <= x && y <= z && x <= z) || (z <= x && z <= y && x <= y)) = y + z
          | ((y <= z && y <= x && z <= x) || (x <= z && x <= y && z <= y)) = x + y

-- 1.16
converte :: Int -> String
converte n
  | n <    0 || n >= maxlim = "ERROR"
  | n >=   0 && n <= 9      = f (n,0)
  | n >=  10 && n <  20     = f (n,1)
  | n >=  20 && n < 100     = f (n `div`  10, 2) +:+ if n `mod`  10 == 0 then "" else converte (n `mod`  10)
  | n == 100                = "cem"  -- caso especial
  | n >  100 && n < 1000    = f (n `div` 100, 3) +:+ if n `mod` 100 == 0 then "" else converte (n `mod` 100)
  | n <= 1000000            = unwords $ map (\(x,y) -> if x `mod` 1000 == 0 then "" else converte x +:+ f (y, is1 x)) (reverse $ zip (reverse $ digs3 n) [0..])
  | otherwise               = error "Number given is bigger than 1000000"

   where
       (+:+) [] [] = []
       (+:+) xs [] = xs
       (+:+) [] ys = ys
       (+:+) xs ys = unwords [xs, ys]

maxlim = (10^) . (*3) $ 5

is1 1 = 5
is1 _ = 4

digs3 0 = []
digs3 x = let d = x `div` 1000
              m = x `mod` 1000
         in digs3 d ++ m:[]

countdigs = length . digits

digits x | x >= 10   = (x `div` 10) : digits (x `mod` 10)
        | otherwise = [x]

fst3 (x,_,_) = x
snd3 (_,x,_) = x
thr3 (_,_,x) = x

f (c,0) = thr3 . fromJust $ lookup c conv100
f (c,1) =        fromJust $ lookup c conv10
f (c,2) = snd3 . fromJust $ lookup c conv100
f (c,3) = fst3 . fromJust $ lookup c conv100
f (c,4) = snd .  fromJust $ lookup c convplus
f (c,5) = fst .  fromJust $ lookup c convplus

{--
converte :: Int -> String
converte n
  | (n >= 0 && n <= 9) = f (n,0)
  | (n >= 10 && n <= 19) = f (n,1)
  | (n >= 20 && n <= 99 && mod n 10 == 0) = f (n,2)
  | (n >= 20 && n <= 99) = f (n,3)
  | (n == 100) = "cem"
  | (n > 100 && n <= 999 && mod (n `div` 10) 10 == 0) = f (n,4) -- 1|9 ++ 0 ++ 1|9
  | (n > 100 && n <= 999 && mod (n `div` 10) 10 == 1) = f (n,5) -- 1|9 ++ 1 ++ 1|9
  | (n > 100 && n <= 999 && mod n 10 == 0) = f (n,6) -- 1|9 ++ 2|9 ++ 0
  | (n > 100 && n <= 999) = f (n,7) -- 1|9 ++ 2|9 ++ 1|9
  | (n == 1000) = "mil"
  | (n > 1000 && n <= 1999 && mod (n `div` 10) 10 == 0 && mod (n `div` 100) 10 == 0) = f (n,8)
  | (n > 1000 && n <= 1999 && mod (n `div` 10) 10 == 1 && mod (n `div` 100) 10 == 0) = f (n,9)
  | (n > 1000 && n <= 1999) = f (n,10)
  | otherwise = "Invalid number!"


fst3 (x,_,_) = x -- 1st element of the tuple
snd3 (_,x,_) = x -- 2nd element of the tuple
thr3 (_,_,x) = x -- 3rd element of the tuple

f (c,0) = thr3 ( fromJust (lookup c conv100) )
f (c,1) =        fromJust (lookup c conv10)
f (c,2) = snd3 ( fromJust (lookup (c `div` 10) conv100) )
f (c,3) = f (c,2) ++ " e " ++ f (mod c 10,0)
f (c,4) = fst3 ( fromJust (lookup (c `div` 100) conv100) ) ++ " e " ++ f (mod c 10,0) -- 1|9 ++ 0 ++ 1|9
f (c,5) = fst3 ( fromJust (lookup (c `div` 100) conv100) ) ++ " e " ++ f (mod c 100,1) -- 1|9 ++ 1 ++ 1|9
f (c,6) = fst3 ( fromJust (lookup (c `div` 100) conv100) ) ++ " e " ++ snd3 ( fromJust (lookup (mod (c `div` 10) 10) conv100) ) -- 1|9 ++ 2|9 ++ 0
f (c,7) = fst3 ( fromJust (lookup (c `div` 100) conv100) ) ++ " e " ++ f (mod c 100,3)
f (c,8) = "mil e " ++ f (mod c 10,0)
f (c,9) = "mil e " ++ f (mod c 100,1)
f (c,10) = "mil " ++ f(mod c 1000,6)
--}

conv10 = zip [10..]["dez", "onze", "doze", "treze", "quatorze", "quinze", "dezasseis", "dezassete", "dezoito", "dezanove"]
conv100 =  zip [0..]
          [("", "", "zero"),
           ("cento", "dez", "um"),
           ("duzentos", "vinte", "dois"),
           ("trezentos", "trinta", "tres"),
           ("quatrozentos", "quarenta", "quatro"),
           ("quinhentos", "cinquenta", "cinco"),
           ("seiscentos", "sessenta", "seis"),
           ("setecentos", "setenta", "sete"),
           ("oitocentos", "oitenta", "oito"),
           ("novecentos", "noventa", "nove")]

convplus = zip [0..]
         [("",                ""),
          ("mil",             "mil"),
          ("milhao",          "milhoes"),
          ("milhar de milhao","milhares de milhoes"),
          ("biliao",          "bilioes")]
