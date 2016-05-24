import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String
import Char

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- Model
type alias Model =
  { name : String
  , age : Int
  , password : String
  , passwordAgain : String
  , color : String
  , message : String
  }

model : Model
model =
  Model "" 0 "" "" "" ""

-- Update
type Msg
  = Name String
  | Age String
  | Password String
  | PasswordAgain String
  | Submit

update action model =
  case action of
    Name name ->
      { model | name = name }
    Age age ->
      { model | age = Result.withDefault 0 (String.toInt age) }
    Password password ->
      { model | password = password }
    PasswordAgain password ->
      { model | passwordAgain = password }

    Submit ->
      if not (model.age > 0) then
        { model | color = "red", message = "Age must be above 0" }
      else if String.length model.password < 8 then
        { model | color = "red", message = "Password must be at least 8 characters" }
      else if not (String.any Char.isDigit model.password) then
        { model | color = "red", message = "Passwords must contain at least one numeric character" }
      else if not (String.any Char.isUpper model.password) then
        { model | color = "red", message = "Passwords must contain at least one upper case character" }
      else if not (String.any Char.isLower model.password) then
        { model | color = "red", message = "Passwords must contain at least one lower case character" }
      else if model.password /= model.passwordAgain then
        { model | color = "red", message = "Passwords do not match" }
      else
        { model | color = "green", message = "OK" }


-- View

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "text", placeholder "Age", onInput Age ] []
    , input [ type' "text", placeholder "Password", onInput Password ] []
    , input [ type' "text", placeholder "Re-Enter Password", onInput PasswordAgain ] []
    , button [ onClick Submit ] [ text "Submit" ]
    , viewValidation model
    ]

viewValidation : Model -> Html msg
viewValidation model =
    div [ style [("color", model.color)] ] [ text model.message ]
