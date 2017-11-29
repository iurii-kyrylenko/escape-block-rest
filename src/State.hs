module State(
  Block(..), Board, State, nextState
) where

data Block = H Int Int | V Int Int deriving (Show)
type Board = [Block]
type State = [Int]
type BoardState = [(Block, Int)]

nextState :: Board -> State -> [State]
nextState board state = freeStates state (freePositions $ board `zip` state)

-- [1,2,0,0,3,0,4,0,2,0,3]
-- [[],[1,3],[],[],[],[],[],[],[],[],[]]
-- [[1,1,0,0,3,0,4,0,2,0,3],[1,3,0,0,3,0,4,0,2,0,3]]

freeStates :: State -> [[Int]] -> [State]
freeStates s xss =
  let f1 (i, xs) = map (\x -> take i s ++ [x] ++ drop (i+1) s) xs
  in  f1 =<< zip [0..] xss

freePositions :: BoardState -> [[Int]]
freePositions boardState =
  let g f w r p = f r [p - 1, p - 2 .. 0] ++ map (+ (1 - w)) (f r [p + w .. 5])
      f1 (H w r, p) = g f2 w r p
      f1 (V h c, p) = g f3 h c p
      f2 = takeWhile . isCellFree boardState
      f3 = takeWhile . flip (isCellFree boardState)
  in  map f1 boardState

isCellFree :: BoardState -> Int -> Int -> Bool
isCellFree boardState row col =
  let outside a x d = x < a || x > a + d - 1
      process (H w r, p) result | r == row = result && outside p col w
      process (V h c, p) result | c == col = result && outside p row h
      process _          result            = result
  in foldr process True boardState
