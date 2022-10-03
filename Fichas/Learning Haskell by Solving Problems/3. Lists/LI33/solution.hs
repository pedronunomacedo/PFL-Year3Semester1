myZip3 :: [a] -> [b] -> [c] -> [(a,b,c)]
myZip3 l1 l2 l3 = [(x,y,z) | (x,(y,z)) <- zip l1 (zip l2 l3)]
