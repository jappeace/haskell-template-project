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
import GHC.TypeLits (type (+), type (<=) , Nat)

newtype MyInstruct (i :: Nat) (j :: Nat) a = MyInstruct a
  deriving (Functor)


pure :: a -> MyInstruct i j a
pure a = MyInstruct a

(>>=) :: MyInstruct i j a -> (a -> MyInstruct j k b) -> MyInstruct i k b
(>>=) (MyInstruct a) fab = case fab a of
  MyInstruct res -> MyInstruct res

(>>) ::  MyInstruct i j a -> MyInstruct j k b -> MyInstruct i k b
(>>) a b = a >>= \_ -> b

start :: MyInstruct 0 0 ()
start = pure ()

mov :: (i + 1) <= 32 => Char -> MyInstruct i (i + 1) ()
mov _ = pure ()

render :: (8 <= (i + 2) , (i + 2) <= 32)  => Int -> MyInstruct i (i + 2) ()
render _ = pure ()


myTenProgram :: MyInstruct 0 17 ()
myTenProgram = do
  start
  mov 'x'
  mov 'x'
  mov 'x'
  mov 'x'
  mov 'x'
  mov 'x'
  mov 'x'
  render 3
  mov 'x'
  render 3
  mov 'x'
  render 3
  mov 'x'
  mov 'x'

myFiveProgram :: MyInstruct 0 12 ()
myFiveProgram = do
  start
  mov 'x'
  mov 'x'
  mov 'x'
  mov 'x'
  mov 'x'
  mov 'x'
  mov 'x'
  mov 'x'
  mov 'x'
  render 3
  mov 'x'


