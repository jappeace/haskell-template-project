module Interact
  ( main
  )
where

-- https://hackage.haskell.org/package/base-4.18.0.0/docs/Prelude.html#v:interact
interact2   ::  (String -> String) -> IO ()
interact2 f =   do s <- getLine
                   putStrLn (f s)

interaction :: String -> String
interaction "jappie" = "hi"
interaction "jakob" = "hello"
interaction x = "unkown input: " <> x

main :: IO ()
main = interact2  interaction
