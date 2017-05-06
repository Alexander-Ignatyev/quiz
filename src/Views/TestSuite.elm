module Views.TestSuite exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, value, href, width, src)
import Msgs exposing (Msg)
import Models exposing (TestSuite)
import Routing exposing (testPath)

view : String -> TestSuite -> Html Msg
view suiteId suite =
  div [ class "row" ]
      [ div [ class "six columns" ]
            [ h1 [] [ text suite.name ]
            , div [ class "description" ] [ text suite.description ]
            , a [ class "button button-primary", href (testPath suiteId 0) ]
                [ text "Start" ]
            ]
      , div [ class "six columns" ]
            [ img [src suite.logo, width 200] [] ]
      ]
