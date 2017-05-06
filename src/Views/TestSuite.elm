module Views.TestSuite exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Msgs exposing (Msg)
import Models exposing (TestSuite)

view : TestSuite -> Html Msg
view suite =
  div [ class "row" ]
      [ div [ class "six columns" ]
            [ text suite.description ]
      , div [ class "six columns" ]
            []
      ]
