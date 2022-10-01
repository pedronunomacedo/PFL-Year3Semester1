-- a)
  -- i)
  zip [1,2] "abc" :: [(Integer,Char)]

  -- ii)
  [[1],[2]] :: [[Int]] --  (Integer can represent arbitrarily large integers, up
                       --  to using all of the storage on your machine. Int can
                       --  only represent integers in a finite range)

  -- iii)
  [succ 'a'] :: [Char] -- (Function succ returns the next integer or char
                       --  In this case, it would be 'b')

  -- iv)
  [1,2,3,4,5.5] :: [Float]

  -- v)
  [1,2] == [2,1] :: Bool

  -- vi)
  zip (zip "abc""abc")"abc" :: [(Char,Char),Char]

-- b) ????
