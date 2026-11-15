{-# LANGUAGE RequiredTypeArguments #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE UnboxedTuples #-}
{-# LANGUAGE RankNTypes #-}
module Template
  ( main
  , prompt
  , promptTag
  )
where

import Prelude(error, ($), Int, (.), fmap, putStrLn, print, pure, Show, getLine)
import Data.Elevator
import GHC.Types(IO(..))
import GHC.Exts(State#, RealWorld)
import GHC.Prim(PromptTag#, newPromptTag#, prompt#, control0#)

-- | we used a team of stientist and they told us error codes
-- would be the way forward.
--
-- whenever you stand in front of your dishwasher and see error 512
-- you immediatly think, yes, the water suply.
-- stience!!!
data ContinuationTag = MkMyException { ezUnderstandErrorCode :: Int }
                 | Success
                 deriving Show

main :: IO ()
main = do
  tag <- promptTag ContinuationTag

  exception11 <- prompt tag $ do
    putStrLn "nothing ever happens"
    res <- getLine
    case res of
        "izhacker" -> control0 tag $ \restore -> pure (MkMyException 5)
        else'  -> putStrLn else'

    pure Success


  print exception11



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
