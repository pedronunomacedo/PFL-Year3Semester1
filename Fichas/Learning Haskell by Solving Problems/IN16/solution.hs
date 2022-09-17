main :: IO ()
main = return ()

mPower a t
  | t == 0    = 1
  | t > 0     = a * mPower a (t-1)
  | otherwise = 1 / mPower a (-t)
