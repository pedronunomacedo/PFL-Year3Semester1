myCycle :: [a] -> [a]
myCycle l = l ++ (myCycle l)
