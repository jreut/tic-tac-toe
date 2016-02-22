module BoardModel
  ( Board
  , move
  , defaultBoard
  ) where


import Array exposing (Array)
import Maybe exposing (..)


type alias Board a
  = Array (Row a)


type alias Row a
  = Array (Maybe a)


type alias Index
  = (Int, Int)


defaultSize : Int
defaultSize = 3


initBoard : Int -> a -> Board a
initBoard size marker =
  Array.repeat size (Array.repeat size (Just marker))

emptyBoard : Int -> Board a
emptyBoard size =
  Array.repeat size (Array.repeat size Nothing)


defaultBoard : Board a
defaultBoard =
  emptyBoard defaultSize


index : Int -> Int -> Index
index row col =
  (row, col)


row : Index -> Int
row index =
  fst index


col : Index -> Int
col index =
  snd index


-- Get an element of the board, returning Nothing if out of bounds.
get : Index -> Board a -> Maybe a
get index board =
  Array.get (row index) board `andThen` Array.get (col index)
    |> Maybe.withDefault Nothing


-- Set an element of the board, returning the unchanged board if out of bounds.
set : Index -> a -> Board a -> Board a
set index marker board =
  let
      oldRow = Array.get (row index) board
      newRow = Maybe.map (\r -> Array.set (col index) (Just marker) r) oldRow
      newBoard = Maybe.map (\r -> Array.set (row index) r board) newRow
  in 
      Maybe.withDefault board newBoard


move : Index -> a -> Board a -> Board a
move index player board =
  let
      occupant = get index board
  in set index (Maybe.withDefault player occupant) board
