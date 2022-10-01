main :: IO ()
main = return ()

myGcd a b = myGcdAux (max posA posB) (min posA posB)
  where posA = abs a
        posB = abs b

myGcdAux a 0 = a
myGcdAux a b = myGcdAux b (mod a b)
