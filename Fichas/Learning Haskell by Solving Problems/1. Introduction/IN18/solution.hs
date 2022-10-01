main :: IO ()
main = return ()

ackerman 0 n = n +1
ackerman m 0 = ackerman (m-1) 1

ackerman m n
  | (m > 0 && n > 0) = ackerman(m - 1) (ackerman m (n - 1))
  | otherwise = error "negative argument"
