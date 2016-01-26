module TicTacToe where


import Graphics.Element exposing (Element, show)
import BoardModel exposing (..)


main : Signal Element
main =
  defaultBoard
  |> set (1,1) (Just xPlayer)
  |> show
  |> Signal.constant
