module Bfs(
  bfs,
  bfsBacktrack
) where

{- http://aleph.nz/post/search_in_haskell/ -}

-- import           Data.Hashable
import qualified Data.Set  as S
import qualified Data.Sequence as Q
import           Data.List (unfoldr)

bfs :: (Eq a, Ord a)
  => (a -> [a])
  -> a
  -> [(a,a)]
bfs adj start = bfs' adj seen queue
  where
    seen  = S.singleton start
    queue = Q.singleton (start, start)

bfs' :: (Eq a, Ord a)
  => (a -> [a])
  -> S.Set a
  -> Q.Seq (a,a)
  -> [(a,a)]
bfs' adj seen queue = unfoldr (bfs_step adj) (seen, queue)

bfs_step :: (Eq a, Ord a)
  => (a -> [a])
  -> (S.Set a, Q.Seq (a,a))
  -> Maybe ((a,a), (S.Set a, Q.Seq (a,a)))
bfs_step neighbours (seen, queue)
  | Q.null queue = Nothing
  | otherwise    = Just ((parent, current), next)
    where
      ((parent, current) Q.:< remaining) = Q.viewl queue
      next = (seen', queue')
      seen' = S.union seen descendents
      queue' = remaining Q.>< (Q.fromList . map ((,) current) . S.toList) descendents
      descendents = S.difference (S.fromList $ neighbours current) seen

bfsBacktrack :: (Eq a, Ord a)
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
