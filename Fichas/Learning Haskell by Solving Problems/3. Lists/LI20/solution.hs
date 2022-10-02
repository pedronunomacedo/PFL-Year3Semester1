mySubsequences :: [a] -> [[a]]
mySubsequences [] = [[]]
mySubsequences (x:xs) = addOrNotToHead x ( mySubsequences xs)

addOrNotToHead :: a -> [[a]] -> [[a]]
addOrNotToHead h [] = []
addOrNotToHead h (l:ls) = l:(h:l):( addOrNotToHead h ls)
