data Arv a = Vazia | No a (Arv a) (Arv a) deriving (Show)

-- 4.1
sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No x left right) = x + (sumArv left) + (sumArv right)

-- 4.2
listar :: Arv a -> [a]
listar Vazia = []
listar (No x left right) = (listar right)++[x]++(listar left)

-- 4.3
nivel :: Int -> Arv a -> [a]
nivel 0 (No x _ _) = [x]
nivel n (No x left right) = (nivel (n-1) left)++(nivel (n-1) right)

-- 4.4 a)
construir :: Ord a => [a] -> Arv a
construir [] = Vazia
construir (x:xs) = inserir x (construir xs)

inserir :: Ord a => a -> Arv a -> Arv a
inserir a Vazia = No a Vazia Vazia
inserir x (No y left right)
  | (x == y) = No y levt right
  | (x < y) = No y (inserir x left) right
  | (x > y) = No y left (inserir x right)

construir' :: [a] -> Arv a -- Partições binárias (divide the list given in 2)
construir' [] = Vazia
construir' l = No x (construir' xs') (construir' xs)
              where n = lenght l `div` 2
                    xs' = take n l
                    (x:xs) = drop n l

altura :: (Num b, Ord a) => Arv a -> b
altura Vazia = 0
altura (No left right) = 1 + (max (altura left) (altura right))
