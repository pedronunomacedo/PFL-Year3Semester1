-- a)
isTriangular a b c =
  (a <= b + c) && (b <= a + c) && (c <= b + c)

-- b)
isPhytagorean a b c =
  (a^2 + b^2 = c^2) || (a^2 + c^2 = b^2) || (b^2 + c^2 = a^2)
