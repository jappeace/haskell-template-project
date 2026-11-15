{-# LANGUAGE RequiredTypeArguments #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE UnboxedTuples #-}
module Template
  ( main
  , prompt
  , promptTag
  )
where

import Prelude(error, ($), Int, (.), fmap)
import Data.Elevator
import GHC.Types(IO(..))
import GHC.Exts(State#, RealWorld)
import GHC.Prim(PromptTag#, newPromptTag#, prompt#, control0#)

main :: IO ()
main = do
  tag <- promptTag Int
  error "we didn't use it"


promptTag :: forall a -> IO (Lazy (PromptTag# a))
promptTag a = IO $ \ realWorld ->
  case newPromptTag# realWorld of
    (# rw, unboxedPromtTag #) -> (# rw, Lazy unboxedPromtTag #)

prompt :: Lazy (PromptTag# a) -> IO a -> IO a
prompt tag iob =
  case iob of
    IO iobFun ->
      case tag of
        Lazy unliftedTag ->
          IO $
            prompt# unliftedTag iobFun

control0 :: Lazy (PromptTag# a) -> ((IO b -> IO a) -> IO a) -> IO b
control0 tag cont =
  case tag of
    Lazy unliftedTag ->
      IO $ control0# unliftedTag (unIO  . cont . unwrapInner )

unwrapInner :: ((State# RealWorld -> (# State# RealWorld, b #)) -> (State# RealWorld -> (# State# RealWorld, a #))) -> IO b -> IO a
unwrapInner inner =
  IO . inner . unIO

unIO :: IO a -> (State# RealWorld -> (# State# RealWorld, a #))
unIO = \case IO res -> res

-- bind :: IO a -> (a -> IO b) -> IO b
-- bind ma amb =
--   control0#
