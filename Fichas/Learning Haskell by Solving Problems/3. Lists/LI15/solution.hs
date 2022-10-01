-- a)
myInits :: [a] -> [[a]]
myInits [] = [[]]
myInits (x:xs) = []:(addHeadToAll x (myInits xs))

addHeadToAll :: a -> [[a]] -> [[a]]
addHeadToAll _ [] = []
addHeadToAll h (l:ls) = (h:l):(addHeadToAll h ls)
-- b
myTails :: [a] -> [[a]]
myTails [] = [[]]
myTails (x:xs) = (x:t):t:ts
  where (t:ts) = myTails xs
