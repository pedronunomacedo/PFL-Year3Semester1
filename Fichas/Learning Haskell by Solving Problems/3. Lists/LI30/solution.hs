myConcat :: [[a]] -> [a]
myConcat l = [x | xs <- l, x <- xs]
