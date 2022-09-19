-- a)
evaluateLength :: [a] -> String

evaluateLength l
  | length l <= 1 = "Short"
  | length l <= 3 = "Medium-Sized"
  | otherwise     = "Long"

-- b)
evaluateLength' [] = "Short"
evaluateLength' [_] = "Short"
evaluateLength' [_,_] = "Medium_Sized"
evaluateLength' [_,_,_] = "Medium_Sized"
evaluateLength' _ = "Long"
