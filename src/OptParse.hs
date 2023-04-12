{-# LANGUAGE BangPatterns #-}
module OptParse
  ( main
  )
where

import Options.Applicative
import qualified Interact
import Data.Foldable(fold)

data OptParseOptions = OptParseOptions
  { hello      :: String
  , quiet      :: Bool
  , enthusiasm :: Int }

cliParser :: Parser OptParseOptions
cliParser = OptParseOptions
      <$> strOption
          ( long "hello"
         <> metavar "TARGET"
         <> help "Target for the greeting" )
      <*> switch
          ( long "direction"
         <> short 'd'
         <> help "Go forward or backward true time" )
      <*> option auto
          ( long "enthusiasm"
         <> help "How enthusiastically to greet"
         <> showDefault
         <> value 1
         <> metavar "INT" )


data Program = CLI OptParseOptions
             | Interact
             | Yesod


cliOptions :: Parser Program
cliOptions = CLI <$> cliParser

programParser :: Parser Program
programParser = subparser $ fold
      [ command "cli" (info cliOptions (progDesc "Greet the user"))
      , command "yesod" (info (pure Yesod) (progDesc "Start yesod server"))
      , command "interact" (info (pure Interact) (progDesc "interact"))
      ]

main :: IO ()
main = program =<< customExecParser parserPrefs opts
  where
    opts = info (programParser <**> helper)
      ( fullDesc
     <> progDesc "Print a greeting for TARGET"
     <> header "hello - a test for optparse-applicative" )
    parserPrefs = prefs showHelpOnError

program :: Program -> IO ()
program = \case
  CLI opts -> greet opts
  Interact -> Interact.main
  Yesod -> pure ()

greet :: OptParseOptions -> IO ()
greet (OptParseOptions h False n) = putStrLn $ "Hello, " ++ h ++ replicate n '!'
greet (OptParseOptions h True n) = putStrLn $ "Bai, " ++ h ++ replicate n '!'
