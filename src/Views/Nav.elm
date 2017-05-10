module Views.Nav exposing (bar)

import Html exposing (Html, header, nav, ul, li, a, text)
import Html.Attributes exposing (href)
import Models exposing (..)
import Auth


bar : Model -> Html msg
bar model =
  header []
         [ nav []
               [ ul []
                    [ li [] [ a [ href "#" ] [ text "Home" ] ]
                    , li [] [ loginButton model ]
                    ]
               ]
         ]


loginButton : Model -> Html msg
loginButton model =
  case model.authToken of
    Just _ -> text "Logged In"
    Nothing -> a [ href <| Auth.googleAuthUrl model.href ] [ text "Log In" ]
