{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric     #-}

module Lib
  ( runServer
  ) where

import Web.Scotty
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics

data Block = H Int Int | V Int Int deriving (Show, Generic)
instance ToJSON Block
instance FromJSON Block

type Board = [Block]
type State = [Int]

data Start = Start { board :: Board, state :: State } deriving (Show, Generic)
instance ToJSON Start
instance FromJSON Start

start1 :: Start
start1 = Start
  { board =
    [ H 2 1
    , H 2 2
    , H 3 3
    , H 2 5
    , H 2 5
    , V 3 0
    , V 2 2
    , V 2 3
    , V 3 4
    , V 2 5
    , V 2 5
    ]
  , state = [1,2,0,0,3,0,4,0,2,0,3]
  }

test = json start1  

result1 :: [State]
result1 =
  [ [3,0,2,2,3,0,1,1]
  , [3,0,2,3,3,0,1,1]
  , [4,0,2,3,3,0,1,1]
  , [4,0,3,3,3,0,1,1]
  , [4,0,3,3,3,3,1,1]
  , [4,0,3,3,3,3,0,1]
  , [4,3,3,3,3,3,0,1]
  , [4,3,3,3,3,0,0,1]
  , [4,3,3,1,3,0,0,1]
  , [4,3,3,1,3,0,0,3]
  , [4,4,3,1,3,0,0,3]    
  ]

routes :: ScottyM ()
routes = do
  -- curl http://localhost:5000/test
  get "/test" $ do
    text "=== TEST ==="
  -- curl -d '{"state":[1,2,0,0,3,0,4,0,2,0,3],"board":[{"tag":"H","contents":[2,1]},{"tag":"H","contents":[2,2]},{"tag":"H","contents":[3,3]},{"tag":"H","contents":[2,5]},{"tag":"H","contents":[2,5]},{"tag":"V","contents":[3,0]},{"tag":"V","contents":[2,2]},{"tag":"V","contents":[2,3]},{"tag":"V","contents":[3,4]},{"tag":"V","contents":[2,5]},{"tag":"V","contents":[2,5]}]}' -H "Content-Type: application/json" -X POST http://localhost:5000/start1
  post "/start1" $ do
    start <- jsonData :: ActionM Start
    json start
  -- curl -H "Content-Type: application/json" -X POST http://localhost:5000/start2
  post "/start2" $ do
    json result1
  
runServer :: IO ()
runServer = do
  putStrLn "starting Server..."
  scotty 5000 routes
