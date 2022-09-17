main :: IO ()
main = return ()

pascal 1 _ = 1

pascal k n
  | (k > 1 && k == n) = 1
  | (k > 1 && k < n) = (pascal (k - 1) (n - 1)) + (pascal k (n - 1))
  | otherwise = error "invalid argument"
