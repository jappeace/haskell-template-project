{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE AllowAmbiguousTypes #-}

module Template
  ( main
  )
where

import Data.Text
import GHC.Generics
import GHC.TypeLits(symbolVal, KnownSymbol )
import Data.Proxy

data Address = Address {
  street :: Text,
  postalCode :: Text
  } deriving (Generic, Show)

data Person = Person {
  homeAddress :: Address,
  workAddress :: Address,
  name :: Text
  } deriving (Generic, Show)

firstPerson :: Person
firstPerson = Person {
  workAddress = Address {
      street = "ponton",
      postalCode = "8882NN"
  },
  homeAddress = Address {
      street = "wayaka",
      postalCode = "8482NK"
  },
  name = "Albertus"
  }

secondPerson :: Person
secondPerson = Person {
  workAddress = Address {
      street = "ponton",
      postalCode = "8882NN"
  },
  homeAddress = Address {
      street = "walashali",
      postalCode = "8432NK"
  },
  name = "Hendrik"
  }

main :: IO ()
main = do
  putStrLn "show magic"
  print secondPerson
  putStrLn "generic magic"
  print (from secondPerson)
  putStrLn "disection"
  print $ disectPerson @Person $ (from secondPerson)

-- this won't work because it leaks out the generic represnetation to
-- the callsite, so it's not generic in fact.
disectPerson :: forall a name a0 b0 c0 d0 . (KnownSymbol name, Rep a ~  M1 D (MetaData name a0 b0 c0) d0) => Rep a () -> [Text]
disectPerson
  x =
  [getDataTypeConstructorName x]


getDataTypeConstructorName :: forall name a b c d e . (KnownSymbol name) => D1 ('MetaData name a b c) d e -> Text
getDataTypeConstructorName _ = pack $ symbolVal (Proxy @name)
