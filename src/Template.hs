module Template
  ( main
  )
where

-- make sure NOT to use safe exceptions (they'll neglect async)
import Control.Exception(try, Exception)

import Control.Concurrent.MVar
import Control.Monad.Reader


main :: IO ()
main = putStrLn "hello, world flaky"

data MyIO a = MyIO { unMy :: ReaderT (MVar ()) IO a }
   deriving (Functor)

instance Applicative MyIO where
  (<*>) fab fa = do
     ab <- fab
     a <- fa
     pure (ab a)
  pure a = MyIO { unMy = pure a }

data TakeABreak = TakeABreak
   deriving (Eq, Show)

instance Exception TakeABreak
instance Monad MyIO where
   (>>=) (MyIO ma) aMb = MyIO {
       unMy = do
          breakyTime <- ask
          eA <- liftIO $ try (runReaderT ma breakyTime)
          case eA of
             Left TakeABreak -> do
                breakyTime <- ask
                liftIO $ takeMVar breakyTime
                a <- ma
                unMy $ aMb a
             Right a -> unMy $ aMb a }
