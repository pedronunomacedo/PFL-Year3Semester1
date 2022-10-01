-- a)
-- Function f returns a pair with the third element of the input list l and the sublist of l starting
-- at the fourth element.

--b)
f' :: [a] -> (a,[a])

f' l = (l !! 2, drop 3 l) -- The "!!2" corresponds to the element of index 2 (the 3rd element of list l)
                          -- and the "drop 3 l" function takes the element on index 3 until the last
                          -- element of the list l
