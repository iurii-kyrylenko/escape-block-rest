{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric     #-}

module Server
  ( runServer
  ) where

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

data Start = Start { board :: Board, state :: State } deriving (Show, Generic)

instance ToJSON Start
instance FromJSON Start
      
routes :: W.ScottyM ()
routes = do
  -- curl http://localhost:5000/
  W.get "/" $ do
    W.text "=== ESCAPE BLOCK SOLVER ==="
  -- curl -X POST -d @test/t-01.json http://localhost:5000/start
  W.post "/start" $ do
    Start { board = b, state = s } <- W.jsonData :: W.ActionM Start
    W.json $ bfsBacktrack (nextState b) ((4 ==) . (!! 1)) s
  
runServer :: IO ()
runServer = do
  putStrLn "starting Server..."
  W.scotty 5000 routes
