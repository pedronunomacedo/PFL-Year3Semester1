dropN :: Eq a => [a] -> Integer -> [a]
dropN l a = [x |x <- head l, x > 0]
