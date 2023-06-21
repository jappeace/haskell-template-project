module XXXInternal
  ( XXX(..)
  )
where

import qualified Prelude
import Prelude(($), IO)
import Data.Set

newtype XXX a = MXXX [a]

instance Prelude.Foldable XXX where
  foldMap fa (MXXX ta) = Prelude.foldMap fa ta
