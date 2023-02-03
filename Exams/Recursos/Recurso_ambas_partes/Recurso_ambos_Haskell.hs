import Data.List (sortBy)
import Control.Arrow (ArrowChoice(right))
-- 1)
accumulatedTime :: [Int] -> Int -> Int
accumulatedTime list n = sum (take n list)

-- 2)
pilotTotalTimes :: [(String,[Int])] -> Int -> [(String,Int)]
pilotTotalTimes pilotsList n = map (\(p, l) -> (p, accumulatedTime l n)) pilotsList

-- 3)
orderPilots :: [(String,Int)] -> [(String,Int)]
orderPilots pilotsList = sortBy (\(_, t1) (_, t2) -> compare t1 t2) pilotsList

-- 4)
rankPilots :: [(String,[Int])] -> Int -> [[(String,Int)]]
rankPilots listPairs numRounds = map (\n -> orderPilots (map (\(person, listPerson) -> (person, accumulatedTime listPerson n)) listPairs)) [1..numRounds]

-- 5) D) É possível determinar que uma função retorna uma lista infinita pela sua declaração de tipo.
-- EXPLANATION: A afirmação d. "É possível determinar que uma função retorna uma lista infinita pela sua declaração de tipo" está errada. A declaração de 
--              tipo de uma função não indica se ela retorna uma lista finita ou infinita, apenas o tipo de dados do resultado. Para determinar se uma função 
--              retorna uma lista infinita, é preciso examinar sua implementação.

-- 6) B) Apenas A e C.

-- 7) Determines how many vocals are in a phrase.

-- Information
data SyntaxTree a = Const a 
                | Unary (a -> a) (SyntaxTree a)
                | Binary (a -> a -> a) (SyntaxTree a) (SyntaxTree a)

-- 8) 
compute :: SyntaxTree a -> a
compute (Const leaf) = leaf
compute (Unary f node) = f (compute node)
compute (Binary f left right) = f (compute left) (compute right)