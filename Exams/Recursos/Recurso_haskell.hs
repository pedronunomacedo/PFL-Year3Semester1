import Data.Maybe (fromJust)
import Data.List
main :: IO ()
main = return ()

-- 1
beatThisTime :: [Int] -> Int -> Bool
beatThisTime lapTimes maxTime = any (< maxTime) lapTimes

-- 2
cityLaps :: [(String,Int)] -> String -> Maybe Int
cityLaps pairs city = lookup city pairs

-- 3
accumulatedTime :: [Int] -> Int -> Int
accumulatedTime list i = sum (take i list)

-- 4
pilotTotalTimes :: [(String,[Int])] -> Int -> [(String,Int)]
pilotTotalTimes list i = map (\(p, l) -> (p, accumulatedTime l i)) list

-- 5
orderPilots :: [(String,Int)] -> [(String,Int)]
orderPilots pilots = sortOn snd pilots

-- 6
rankPilots :: [(String,[Int])] -> Int -> [[(String,Int)]]
rankPilots pilots turns = map (\i -> orderPilots (pilotTotalTimes pilots i)) [1..turns]

-- 7
secondFastestLap :: [Int] -> Int
secondFastestLap lapTimes = minimum firstRemove
                            where min1 = minimum lapTimes
                                  firstRemove = delete min1 lapTimes -- [t | t <- lapTimes, t /= min1]

removeValue :: Eq a => a -> [a] -> [a]
removeValue x xs = [y | y <- xs, y /= x]

-- 15
func2'' :: [Int] -> Int
func2'' list = sum $ map succ list
-- Information
data SyntaxTree a = Const a 
                  | Unary (a -> a) (SyntaxTree a)
                  | Binary (a -> a -> a) (SyntaxTree a) (SyntaxTree a)

-- 16
countConsts :: (Num b) => SyntaxTree a -> b
countConsts (Const _) = 1 -- leaf -- node
countConsts (Unary _ t) = countConsts t -- unary (for example, negate, abs, not, and sqrt. )
countConsts (Binary _ t1 t2) = countConsts t1 + countConsts t2

testTree1 :: SyntaxTree Integer
testTree1 = Binary (*) (Binary (+) (Const 2) (Const 3)) (Binary div (Unary negate (Const 169)) (Const 13))

testTree2 :: SyntaxTree Integer
testTree2 = Unary negate (Const 42)

testTree3 :: SyntaxTree Integer
testTree3 = Binary (-) (Const 4) (Unary negate (Unary abs (Const (-3))))

-- test1_1 = countConsts testTree1_1 -- Output: 4
-- test1_2 = countConsts testTree1_2 -- Output: 1
-- test1_3 = countConsts testTree1_3 -- Output: 2

-- 17
compute :: SyntaxTree a -> a
compute (Const x) = x -- leaf -- node
compute (Unary f t) = f (compute t) -- unary (for example, negate, abs, not, and sqrt. )
compute (Binary f t1 t2) = f (compute t1) (compute t2)

-- testTree1 :: SyntaxTree Integer
-- testTree1 = Binary (*) (Binary (+) (Const 2) (Const 3)) (Binary div (Unary negate (Const 169)) (Const 13))

-- testTree2 :: SyntaxTree Integer
-- testTree2 = Unary negate (Const 42)

-- testTree3 :: SyntaxTree Integer
-- testTree3 = Binary (-) (Const 4) (Unary negate (Unary abs (Const (-3))))

test1 = countConsts testTree1 -- Output: 4
test2 = countConsts testTree2 -- Output: 1
test3 = countConsts testTree3 -- Output: 2