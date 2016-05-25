import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
  { dieFace : String
  }

view : Model -> Html Msg
view model =
  div []
    [ img [ src model.dieFace ] []
    , br [] []
    , button [ onClick Roll ] [ text "Roll" ]
    ]

type Msg
  = Roll
  | NewFace Int

dieFaceUrl : Int -> String
dieFaceUrl face =
  "http://www.wpclipart.com/recreation/games/dice/die_face_" ++ toString face ++ ".png"

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.int 1 6))

    NewFace newFace ->
      (Model (dieFaceUrl newFace), Cmd.none)

init : (Model, Cmd Msg)
init =
  (Model (dieFaceUrl 1), Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
