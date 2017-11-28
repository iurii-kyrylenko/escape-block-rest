--
-- https://artyom.me/aeson
--

{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Serialization where

import GHC.Generics
import Data.Aeson

data Block = H Int Int | V Int Int deriving (Show)
type Board = [Block]
type State = [Int]

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

t1 = encode (H 2 3)
t2 = decode "{\"dir\":\"h\",\"len\":2,\"row\":3}" :: Maybe Block
t3 = decode "{\"dir\":\"v\",\"len\":7,\"row\":9}" :: Maybe Block
t4 = decode "[{\"dir\":\"h\",\"len\":2,\"row\":3}, {\"dir\":\"v\",\"len\":7,\"row\":9}]" :: Maybe Board
t5 = encode [H 2 3, V 7 9]

data Start = Start { board :: Board, state :: State } deriving (Show, Generic)

instance ToJSON Start
instance FromJSON Start

t6 = encode Start { board = [ H 2 1
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
t7 = decode t6 :: Maybe Start
