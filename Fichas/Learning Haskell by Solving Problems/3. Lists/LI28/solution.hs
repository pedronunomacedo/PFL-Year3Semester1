infL :: Integral a => [a]
infL = 1:[2*prev + n -1 | (n, prev) <- zip [2..] infL]
