module Bfs(
  bfs,
  bfsBacktrack
) where

{- http://aleph.nz/post/search_in_haskell/ -}

import           Data.Hashable
import qualified Data.HashSet  as S
import qualified Data.Sequence as Q
import           Data.List (unfoldr)

bfs :: (Hashable a, Eq a, Ord a)
  => (a -> [a])
  -> a
  -> [(a,a)]
bfs adj start = bfs' adj seen queue
  where
    seen  = S.singleton start
    queue = Q.singleton (start, start)

bfs' :: (Hashable a, Eq a, Ord a)
  => (a -> [a])
  -> S.HashSet a
  -> Q.Seq (a,a)
  -> [(a,a)]
bfs' adj seen queue = unfoldr (bfs_step adj) (seen, queue)

bfs_step :: (Hashable a, Eq a, Ord a)
  => (a -> [a])
  -> (S.HashSet a, Q.Seq (a,a))
  -> Maybe ((a,a), (S.HashSet a, Q.Seq (a,a)))
bfs_step neighbours (seen, queue)
  | Q.null queue = Nothing
  | otherwise    = Just ((parent, current), next)
    where
      ((parent, current) Q.:< remaining) = Q.viewl queue
      next = (seen', queue')
      seen' = S.union seen descendents
      queue' = remaining Q.>< (Q.fromList . map ((,) current) . S.toList) descendents
      descendents = S.difference (S.fromList $ neighbours current) seen

bfsBacktrack :: (Hashable a, Eq a, Ord a)
  => (a -> [a])
  -> (a -> Bool)
  -> a
  -> [a]
bfsBacktrack adj end start =
  let (as, bs) = break (end . snd) (bfs adj start)
      search = case bs of
        []   -> []
        h :_ -> h : reverse as
      bt []         = []
      bt ((f,s):xs) = s : bt (snd (break ((== f) . snd) xs))
  in (reverse . bt) search
