module Template
  ( main
  )
where

import qualified Prelude
import Prelude(($), IO)
import Data.Set
import XXX

main :: IO ()
main = do
  let unsorted = MXXX [10,9..1]
  Prelude.putStrLn $ Prelude.show $ maximum unsorted
