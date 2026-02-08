{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RebindableSyntax #-}
module Template
  ( myTenProgram
  , myFiveProgram
  )
where

import Prelude (fromInteger, Int, Char, Functor)
import GHC.TypeLits (type (+), type (<=), Nat)

newtype MyInstruct (i :: Nat) a = MyInstruct a
  deriving (Functor)


pure :: a -> MyInstruct i a
pure a = MyInstruct a

(>>=) :: (i + j) <= 10 => MyInstruct i a -> (a -> MyInstruct j b) -> MyInstruct (i + j) b
(>>=) (MyInstruct a) fab = case fab a of
  MyInstruct res -> MyInstruct res

(>>) :: (i + j) <= 10 =>  MyInstruct i a -> MyInstruct j b -> MyInstruct (i + j) b
(>>) a b = a >>= \_ -> b

mov :: Char -> MyInstruct 1 ()
mov _ = pure ()

render :: Int -> MyInstruct 2 ()
render _ = pure ()


myTenProgram :: MyInstruct 11 ()
myTenProgram = do
  mov 'x'
  render 3
  mov 'x'
  render 3
  mov 'x'
  render 3
  mov 'x'
  mov 'x'

myFiveProgram :: MyInstruct 5 ()
myFiveProgram = do
  mov 'x'
  mov 'x'
  render 3
  mov 'x'


