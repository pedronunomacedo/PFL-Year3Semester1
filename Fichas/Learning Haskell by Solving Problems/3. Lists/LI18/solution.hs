myTranspose :: [[a]] -> [[a]]

myTranspose ([]:_) = []
myTranspose l = (map head l):(myTranspose (map tail l))
