module TicTacToe where


import Graphics.Element exposing (Element, show)
import BoardModel exposing (..)


type Player
  = X
  | O


main : Signal Element
main =
  defaultBoard
  |> move (1,1) X
  |> show
  |> Signal.constant
