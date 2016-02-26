module TicTacToe where

import StartApp.Simple exposing
  ( start
  )
import Html exposing
  ( Html
  , Attribute
  , text
  , span
  , div
  , fromElement
  )
import Html.Attributes exposing
  ( style
  )
import Html.Events exposing
  ( onClick
  )
import Array exposing
  ( Array
  )
import BoardModel exposing (..)


type alias Model =
  { board: Board Player
  , player: Player
  }


type Player
  = X
  | O


type Action
  = NoOp
  | Move Index


main : Signal Html
main =
  start
    { model = init
    , update = update
    , view = view
    }


init : Model
init =
    { board = defaultBoard
    , player = X
    }


update : Action -> Model -> Model
update action model =
  case action of
    NoOp -> model
    Move index ->
      { board = move index model.player model.board
      , player = nextPlayer model.player
      }


nextPlayer : Player -> Player
nextPlayer player =
  case player of
    X -> O
    O -> X


view : Signal.Address Action -> Model -> Html
view address model =
  render address model.board


render : Signal.Address Action -> Board Player -> Html
render address board =
  board
  |> Array.toList
  |> List.indexedMap (\row -> renderRow row address)
  |> div [ boardStyle ]


renderRow : Int -> Signal.Address Action -> Array (Maybe Player) -> Html
renderRow rowPos address row =
  row
  |> Array.toList
  |> List.indexedMap (\col -> renderCell rowPos col address)
  |> div [ rowStyle ]


renderCell : Int -> Int ->  Signal.Address Action -> Maybe Player -> Html
renderCell row col address player =
  div
    [ cellStyle , onClick address (Move (row, col)) ]
    [ text (renderPlayer player) ]


renderPlayer : Maybe Player -> String
renderPlayer player =
  player
  |> Maybe.map toString
  |> Maybe.withDefault ""


boardStyle : Attribute
boardStyle =
  style
    [ ("display", "flex")
    , ("flex-direction", "column")
    , ("flex-basis", "50%")
    , ("width", "50%")
    , ("margin", "auto")
    ]


rowStyle : Attribute
rowStyle =
  style
    [ ("display", "flex")
    , ("margin", "1em")
    , ("flex-direction", "row")
    , ("flex-basis", "4em")
    , ("align-items", "center")
    , ("justify-content", "center")
    ]


cellStyle : Attribute
cellStyle =
  style
    [ ("border", "black 1px solid")
    , ("border-radius", "10%")
    , ("margin", "1em")
    , ("display", "flex")
    , ("padding", "1em")
    , ("flex-basis", "4em")
    ]
