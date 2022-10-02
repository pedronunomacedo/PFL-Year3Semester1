-- a)
myZip :: [a] -> [Char] -> [(a,Char)]

myZip [] l = []
myZip l [] = []
myZip (x:xs) (y:ys) = (x,y):(myZip xs ys)

-- b)
myZip3 :: [a] -> [Char] -> [a] -> [(a,Char,a)]

myZip3 [] _ _ = []
myZip3 _ [] _ = []
myZip3 _ _ [] = []

myZip3 (x:xs) (y:ys) (z:zs) = (x,y,z):(myZip3 xs ys zs)
