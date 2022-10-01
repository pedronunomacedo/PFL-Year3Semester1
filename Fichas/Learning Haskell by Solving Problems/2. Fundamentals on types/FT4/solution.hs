-- a)
distance2 :: Floating a => (a, a) -> (a, a) -> a
distance2 (x1,y1) (x2,y2) = sqrt ((x1-x2)^2 + (y1-y2)^2)

-- b)
distanceInf :: (Num a, Ord a) => (a, a) -> (a, a) -> a
distanceInf (x1,y1) (x2,y2) = max (abs(x1-x2)) (abs(y1-y2))
