-- version with if-then-else

min3 x y z =
  if (x <= y && x = z)
    then x
    else if (y <= x && y <= z)
      then y
      else z


-- version with guards

min3' x y z
  | x < y && x < x   = x
  | y < x && y < z   = y
  | otherwise        = z
