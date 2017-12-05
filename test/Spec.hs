import State
import Bfs

board1 = [ -- ┌───┬───┬───┬───┬───┬───┐
    H 2 1  -- │ 1 │   │   │ 3 │   │ 5 │
  , H 2 2  -- ├───┼───┼───┼───┼───┼───┤
  , H 3 3  -- │ 1 │ a │ a │ 3 │   │ 5 │
  , H 2 5  -- ├───┼───┼───┼───┼───┼───┤
  , H 2 5  -- │ 1 │   │ b │ b │ 4 │   │
  , V 3 0  -- ├───┼───┼───┼───┼───┼───┤
  , V 2 2  -- │ c │ c │ c │   │ 4 │ 6 │
  , V 2 3  -- ├───┼───┼───┼───┼───┼───┤
  , V 3 4  -- │   │   │ 2 │   │ 4 │ 6 │
  , V 2 5  -- ├───┼───┼───┼───┼───┼───┤
  , V 2 5  -- │ d │ d │ 2 │ e │ e │   │
  ]        -- └───┴───┴───┴───┴───┴───┘
startState1 = [1,2,0,0,3,0,4,0,2,0,3]

board2 = [ -- ┌───┬───┬───┬───┬───┬───┐
    H 2 1  -- │   │   │ 2 │   │   │ 5 │
  , H 2 2  -- ├───┼───┼───┼───┼───┼───┤
  , H 2 3  -- │ a │ a │ 2 │   │   │ 5 │
  , H 2 5  -- ├───┼───┼───┼───┼───┼───┤
  , V 2 0  -- │ 1 │   │ 2 │ b │ b │ 5 │
  , V 3 2  -- ├───┼───┼───┼───┼───┼───┤
  , V 3 3  -- │ 1 │   │   │ 3 │ c │ c │
  , V 2 4  -- ├───┼───┼───┼───┼───┼───┤
  , V 3 5  -- │   │ d │ d │ 3 │ 4 │   │
  ]        -- ├───┼───┼───┼───┼───┼───┤
           -- │   │   │   │ 3 │ 4 │   │
           -- └───┴───┴───┴───┴───┴───┘
startState2 = [0,3,4,1,2,0,3,4,0]

board3 = [ -- ┌───┬───┬───┬───┬───┬───┐
    H 2 0  -- │   │ a │ a │ 4 │   │ 6 │
  , H 2 2  -- ├───┼───┼───┼───┼───┼───┤
  , H 2 3  -- │ 1 │   │   │ 4 │   │ 6 │
  , H 2 4  -- ├───┼───┼───┼───┼───┼───┤
  , H 2 5  -- │ 1 │   │ 3 │ b │ b │ 6 │
  , V 2 0  -- ├───┼───┼───┼───┼───┼───┤
  , V 2 1  -- │   │ 2 │ 3 │ c │ c │   │
  , V 3 2  -- ├───┼───┼───┼───┼───┼───┤
  , V 2 3  -- │   │ 2 │ 3 │ 5 │ d │ d │
  , V 2 3  -- ├───┼───┼───┼───┼───┼───┤
  , V 3 5  -- │ e │ e │   │ 5 │   │   │
  ]        -- └───┴───┴───┴───┴───┴───┘
startState3 = [1,3,3,4,0,1,3,2,0,4,0]

board4 = [ -- ┌───┬───┬───┬───┬───┬───┐
    H 2 0  -- │   │   │ 2 │ a │ a │   │
  , H 2 2  -- ├───┼───┼───┼───┼───┼───┤
  , H 2 4  -- │   │   │ 2 │ 3 │   │ 4 │
  , H 3 5  -- ├───┼───┼───┼───┼───┼───┤
  , V 3 0  -- │ b │ b │ 2 │ 3 │   │ 4 │
  , V 3 2  -- ├───┼───┼───┼───┼───┼───┤
  , V 2 3  -- │ 1 │   │   │   │   │ 4 │
  , V 3 5  -- ├───┼───┼───┼───┼───┼───┤
  ]        -- │ 1 │   │ c │ c │   │   │
           -- ├───┼───┼───┼───┼───┼───┤
           -- │ 1 │   │ d │ d │ d │   │
           -- └───┴───┴───┴───┴───┴───┘
startState4 = [3,0,2,2,3,0,1,1]

board5 = [ -- ┌───┬───┬───┬───┬───┬───┐
    H 2 0  -- │ 1 │ a │ a │   │ 4 │   │
  , H 3 1  -- ├───┼───┼───┼───┼───┼───┤
  , H 2 2  -- │ 1 │ b │ b │ b │ 4 │   │
  , H 2 3  -- ├───┼───┼───┼───┼───┼───┤
  , H 3 4  -- │ c │ c │ 2 │   │ 4 │ 5 │
  , H 2 5  -- ├───┼───┼───┼───┼───┼───┤
  , H 2 5  -- │   │   │ 2 │ d │ d │ 5 │
  , V 2 0  -- ├───┼───┼───┼───┼───┼───┤
  , V 2 2  -- │ e │ e │ e │ 3 │   │ 5 │
  , V 2 3  -- ├───┼───┼───┼───┼───┼───┤
  , V 3 4  -- │   │ f │ f │ 3 │ g │ g │
  , V 3 5  -- └───┴───┴───┴───┴───┴───┘
  ]
startState5 = [1,1,0,3,0,1,4,0,2,4,0,2]

board6 = [ -- ┌───┬───┬───┬───┬───┬───┐
    H 2 0  -- │ 1 │ a │ a │   │ 4 │   │
  , H 3 1  -- ├───┼───┼───┼───┼───┼───┤
  , H 2 2  -- │ 1 │ b │ b │ b │ 4 │   │
  , H 2 3  -- ├───┼───┼───┼───┼───┼───┤
  , H 3 4  -- │ c │ c │ 2 │   │ 4 │   │
  , H 2 5  -- ├───┼───┼───┼───┼───┼───┤
  , H 2 5  -- │   │   │ 2 │ d │ d │ 5 │
  , V 2 0  -- ├───┼───┼───┼───┼───┼───┤
  , V 2 2  -- │ e │ e │ e │ 3 │   │ 5 │
  , V 2 3  -- ├───┼───┼───┼───┼───┼───┤
  , V 3 4  -- │ f │ f │   │ 3 │ g │ g │
  , V 2 5  -- └───┴───┴───┴───┴───┴───┘
  ]
startState6 = [1,1,0,3,0,0,4,0,2,4,0,3]

allStates1 = bfs (nextState board1) startState1 -- length allStates1 = 1799
allStates2 = bfs (nextState board2) startState2 -- length allStates2 = 8859
allStates3 = bfs (nextState board3) startState3 -- length allStates3 = 15651
allStates4 = bfs (nextState board4) startState4 -- length allStates4 = 5297
allStates5 = bfs (nextState board5) startState5 -- length allStates5 = 6761
allStates6 = bfs (nextState board6) startState6 -- length allStates6 = 10636

bt1 = bfsBacktrack (nextState board1) ((4 ==) . (!! 1)) startState1 -- length bt1 = 17
bt2 = bfsBacktrack (nextState board2) ((4 ==) . (!! 1)) startState2 -- length bt2 = 28
bt3 = bfsBacktrack (nextState board3) ((4 ==) . (!! 1)) startState3 -- length bt3 = 19
bt4 = bfsBacktrack (nextState board4) ((4 ==) . (!! 1)) startState4 -- length bt4 = 11
bt5 = bfsBacktrack (nextState board5) ((4 ==) . (!! 2)) startState5 -- length bt5 = 27
bt6 = bfsBacktrack (nextState board6) ((4 ==) . (!! 2)) startState6 -- length bt6 = 26

display :: [State] -> IO ()
display = sequence_ . fmap (putStrLn . show)

eq :: (Eq a, Show a) => String -> a -> a -> IO ()
eq s x y = do
  let act = "actual " ++ show x
  putStr $ s ++ ": "
  if x == y
    then putStrLn "ok"
    else error act

main :: IO ()
main = do
  putStrLn ""
  putStrLn "---- all states length ----"
  eq "length allStates1 == 1799" (length allStates1) 1799
  eq "length allStates2 == 8859" (length allStates2) 8859
  eq "length allStates3 == 15651" (length allStates3) 15651
  eq "length allStates4 == 5297" (length allStates4) 5297
  eq "length allStates5 == 6761" (length allStates5) 6761
  eq "length allStates6 == 10636" (length allStates6) 10636
  putStrLn "---- back track length ----"
  eq "length bt1 == 17" (length bt1) 17
  eq "length bt2 == 28" (length bt2) 28
  eq "length bt3 == 19" (length bt3) 19
  eq "length bt4 == 11" (length bt4) 11
  eq "length bt5 == 27" (length bt5) 27
  eq "length bt6 == 26" (length bt6) 26
  putStrLn "---- exit condition -------"
  eq "bt1 !! 16 !! 1 == 4" (bt1 !! 16 !! 1) 4
  eq "bt2 !! 27 !! 1 == 4" (bt2 !! 27 !! 1) 4
  eq "bt3 !! 18 !! 1 == 4" (bt3 !! 18 !! 1) 4
  eq "bt4 !! 10 !! 1 == 4" (bt4 !! 10 !! 1) 4
  eq "bt5 !! 26 !! 2 == 4" (bt5 !! 26 !! 2) 4
  eq "bt6 !! 25 !! 2 == 4" (bt6 !! 25 !! 2) 4
  putStrLn "---- back track 4 ---------"
  display bt4
  putStrLn "---------------------------"
