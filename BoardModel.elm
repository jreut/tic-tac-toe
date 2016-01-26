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
  = Array a


type alias Index
  = (Int, Int)


defaultSize : Int
defaultSize = 3


initBoard : Int -> a -> Board a
initBoard size marker =
  Array.repeat size (Array.repeat size marker)

emptyBoard : Int -> Board (Maybe a)
emptyBoard size =
  Array.repeat size (Array.repeat size Nothing)


defaultBoard : Board (Maybe a)
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


-- Set an element of the board, returning the unchanged board if out of bounds.
set : Index -> a -> Board a -> Board a
set index marker board =
  Array.get (row index) board
  |> Maybe.map (\oldRow -> Array.set (col index) marker oldRow)
  |> Maybe.map (\newRow -> Array.set (row index) newRow board)
  |> Maybe.withDefault board


move : Index -> a -> Board (Maybe a) -> Board (Maybe a)
move index player board =
  set index (Just player) board

