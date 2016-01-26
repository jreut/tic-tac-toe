module BoardModel
  ( Board
  , Marker, Player
  , index, row, col
  , get, set
  , defaultBoard
  , xPlayer, oPlayer
  ) where


import Array exposing (Array)
import Maybe exposing (..)


type alias Board
  = Array Row


type alias Row
  = Array (Marker)


type alias Marker
  = Maybe Player


type Player
  = X
  | O


type alias Index
  = (Int, Int)


defaultSize : Int
defaultSize = 3


initBoard : Int -> Marker -> Board
initBoard size marker =
  Array.repeat size (Array.repeat size marker)


emptyBoard : Int -> Board
emptyBoard size =
  Array.repeat size (Array.repeat size Nothing)


defaultBoard : Board
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
get : Index -> Board -> Maybe Marker
get index board =
  Array.get (row index) board `andThen` Array.get (col index)


-- Set an element of the board, returning the unchanged board if out of bounds.
set : Index -> Marker -> Board -> Board
set index marker board =
  Array.get (row index) board
  |> Maybe.map (\oldRow -> Array.set (col index) marker oldRow)
  |> Maybe.map (\newRow -> Array.set (row index) newRow board)
  |> Maybe.withDefault board


xPlayer = X
oPlayer = O
