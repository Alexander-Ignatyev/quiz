module Views.Error exposing (view)

import Html exposing (Html, h1, p, div, a, text)
import Html.Attributes exposing (class, href)


view : String -> Html msg
view message =
  div [ class "error" ]
      [ h1 [] [ text "Error" ]
      , p [] [ text message ]
      , a [ class "button button-primary", href "#" ]
          [ text "Start again" ]
      ]
