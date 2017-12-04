{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric     #-}

module Server
  ( runServer
  ) where

import System.ReadEnvVar (readEnvDef)
import qualified Web.Scotty as W
import Data.Aeson
import GHC.Generics
import State
import Bfs

instance ToJSON Block where
  toJSON (H x y) = object ["dir" .= 'h', "len" .= x, "row" .= y]
  toJSON (V x y) = object ["dir" .= 'v', "len" .= x, "row" .= y]

instance FromJSON Block where
  parseJSON  = withObject "h or v" $ \o -> do
    dir <- o .: "dir"
    case dir of
      "h" -> H <$> o .: "len" <*> o .: "row"
      "v" -> V <$> o .: "len" <*> o .: "row"
      _   -> fail ("unknown dir: " ++ dir)

data Target = Target { index :: Int, position :: Int } deriving (Show, Generic)
instance ToJSON Target
instance FromJSON Target

data Start = Start
  { board :: Board
  , state :: State
  , target :: Target
  } deriving (Show, Generic)

instance ToJSON Start
instance FromJSON Start

routes :: W.ScottyM ()
routes = do
  -- curl http://localhost:5000/
  W.get "/" $ do
    W.text "=== ESCAPE BLOCK SOLVER ==="

  -- curl -X GET -d @test/01.json http://localhost:5000/backtrack
  W.get "/backtrack" $ do
    Start board state (Target index position) <- W.jsonData :: W.ActionM Start
    W.json $ bfsBacktrack (nextState board) ((position ==) . (!! index)) state

  -- curl -X GET -d @test/01.json http://localhost:5000/backtrack-length
  W.get "/backtrack-length" $ do
    Start board state (Target index position) <- W.jsonData :: W.ActionM Start
    W.json . length $ bfsBacktrack (nextState board) ((position ==) . (!! index)) state

  -- curl -X GET -d @test/01.json http://localhost:5000/length
  W.get "/length" $ do
    Start board state _ <- W.jsonData :: W.ActionM Start
    W.json . length $ bfs (nextState board) state

runServer :: IO ()
runServer = do
  port <- readEnvDef "PORT" 5000
  putStrLn "starting Server..."
  W.scotty port routes
