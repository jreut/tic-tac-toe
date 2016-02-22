module TicTacToe where


import Array exposing (Array)
import Graphics.Element exposing (
  Element
  , show
  , flow
  , down
  , right
  , container
  , middle
  )
import BoardModel exposing (..)


type Player
  = X
  | O


main : Signal Element
main =
  defaultBoard
  |> move (1,1) X
  |> move (1,1) O
  |> render
  |> Signal.constant


render : Board Player -> Element
render board =
  board
  |> Array.toList
  |> List.map renderRow
  |> flow down


renderRow : Array (Maybe Player) -> Element
renderRow row =
  row
  |> Array.toList
  |> List.map show
  |> List.map (container 100 100 middle)
  |> flow right
