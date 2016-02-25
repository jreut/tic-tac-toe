module TicTacToe where

import StartApp.Simple exposing (start)
import Html exposing (Html
  , Attribute
  , text
  , span
  , div
  , fromElement
  )
import Html.Attributes exposing (
  style
  )
import Html.Events exposing (
  onClick
  )
import Array exposing (
  Array
  )
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
view address  model =
  render address model.board


render : Signal.Address Action -> Board Player -> Html
render address board =
  board
  |> Array.toList
  |> List.map (renderRow address)
  |> div [ boardStyle ]


renderRow : Signal.Address Action -> Array (Maybe Player) -> Html
renderRow address row =
  row
  |> Array.toList
  |> List.map (renderCell address)
  |> div [ rowStyle ]


renderCell : Signal.Address Action -> Maybe Player -> Html
renderCell address player =
  div
    [ cellStyle
    , onClick address (Move (0,0))
    ] [ text (toString player) ]


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
    , ("flex-direction", "row")
    , ("border", "red 1px dotted")
    , ("flex-basis", "4em")
    , ("align-items", "center")
    , ("justify-content", "center")
    ]


cellStyle : Attribute
cellStyle =
  style
    [ ("border", "black 1px solid")
    , ("display", "flex")
    , ("padding", "1em")
    , ("flex-basis", "4em")
    ]
