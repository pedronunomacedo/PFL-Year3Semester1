-- a) Function f computes teh sign of a number x, and returns 1, -1 or 0, respectively,
--    if x is positive, negative or null.

-- b)
f' :: (Ord a, Num a, Integral b) => a -> b
f' 0 = 0
f' x = if (x > 0) then 1 else -1
