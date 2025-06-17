-- A simple Haskell program to implement a text-based Tic Tac Toe game

module Main where

import Data.List (intercalate, transpose)

type Board = [[String]]

defaultBoard :: Board
defaultBoard = replicate 3 (replicate 3 " ")

printBoard :: Board -> IO ()
printBoard board = do
    putStrLn $ intercalate "\n-+-+-\n" (map (intercalate "|") board)

isValidMove :: Board -> Int -> Int -> Bool
isValidMove board row col =
  let isInBounds = row >= 0 && row < 3 && col >= 0 && col < 3
      isEmptySpace = (board !! row !! col == " ")
   in isInBounds && isEmptySpace


makeMove :: Board -> Int -> Int -> String -> Board
makeMove board row col player =
  zipWith
    ( \rowIndex curRow ->
        zipWith
          ( \colIndex val ->
              if row == rowIndex && col == colIndex
                then player
                else val
          )
          [0 ..]
          curRow
    )
    [0 ..]
    board

checkWinner :: Board -> String -> Bool
checkWinner board player =
    any (all (== player)) board || -- Rows
    any (all (== player)) (transpose board) || -- Columns
    all (== player) [board !! i !! i | i <- [0..2]] || -- Diagonal
    all (== player) [board !! i !! (2 - i) | i <- [0..2]] -- Anti-diagonal

playGame :: Board -> String -> IO ()
playGame board currentPlayer = do
    printBoard board
    putStrLn $ "Player " ++ currentPlayer ++ ", enter your move (row and column separated by a space):"
    input <- getLine
    let [row, col] = map read (words input)
    if isValidMove board row col
        then do
            let newBoard = makeMove board row col currentPlayer
            if checkWinner newBoard currentPlayer
                then do
                    printBoard newBoard
                    putStrLn $ "Player " ++ currentPlayer ++ " wins!"
                else playGame newBoard (if currentPlayer == "X" then "O" else "X")
        else do
            putStrLn "Invalid move. Try again."
            playGame board currentPlayer

main :: IO ()
main = do
    putStrLn "Welcome to Tic Tac Toe!"
    playGame defaultBoard "X"