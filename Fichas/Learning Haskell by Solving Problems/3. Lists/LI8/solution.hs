myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (x:xs) = (myConcatAux x) ++ (myConcat xs)

myConcatAux :: [a] -> [a]
myConcatAux [] = []
myConcatAux (x:xs) = [x] ++ (myConcatAux xs)
