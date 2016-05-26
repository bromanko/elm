import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random
import Svg exposing (..)
import Svg.Attributes exposing (viewBox, x, y, fill, stroke, strokeWidth, cx, cy, r, fill)

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

dieSize = 280
dieColor = "#ff8a65"

view : Model -> Html Msg
view model =
  div []
    [ img [ src model.dieFace ] []
    , Svg.svg [ Svg.Attributes.height "300", Svg.Attributes.width "300", viewBox "0 0 300 300" ]
    [ rect [ x "2"
           , y "2"
           , Svg.Attributes.height (toString dieSize)
           , Svg.Attributes.width (toString dieSize)
           , fill "none"
           , stroke dieColor
           , strokeWidth "4"]
           []
    , circle [ cx (toString (dieSize/2)), cy (toString (dieSize/2)), r "30", fill dieColor ] []
    ]
    , br [] []
    , button [ onClick Roll ] [ Html.text "Roll" ]
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
