module Views.TestSuite exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, value, href, width, src)
import Msgs exposing (Msg)
import Models exposing (TestSuite)

view : TestSuite -> Html Msg
view suite =
  div [ class "row" ]
      [ div [ class "six columns" ]
            [ h1 [] [ text suite.name ]
            , text suite.description ]
      , div [ class "six columns" ]
            [ img [src suite.logo, width 200] [] ]
      ]
