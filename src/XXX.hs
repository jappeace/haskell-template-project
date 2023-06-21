module XXX
  ( XXX.XXX(..)
  , maximum
  -- eg other functions
  , XXX.foldMap
  )
where

import qualified Prelude
import Prelude(($), IO)
import Data.Set
import qualified XXXInternal as XXX

-- lmfao, this won't work cuz typeclasses get auto exported
-- even if the module is internal and hides it.
{-# WARNING maximum "This is a partial function, it throws an error on empty lists. Use pattern matching or Data.List.uncons instead. Consider refactoring to use Data.List.NonEmpty." #-}
maximum :: Prelude.Ord a => XXX.XXX a -> a
maximum ta = XXX.maximum ta
