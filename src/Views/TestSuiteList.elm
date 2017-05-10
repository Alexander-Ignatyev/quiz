module Views.TestSuiteList exposing (view)

import Dict exposing (Dict)
import Html exposing (Html, div, text, img, a, figure, figcaption)
import Html.Attributes exposing (class, src, width, href)
import Msgs exposing (Msg)
import Models exposing (TestSuite)
import Routing exposing (testSuitePath)


view : Dict String TestSuite -> Html Msg
view suites = Dict.map testSuite suites
  |> Dict.values
  |> div [ class "row" ]


testSuite : String -> TestSuite -> Html Msg
testSuite id suite =
  figure [ class "four columns u-max-full-width test-suite" ]
         [ figcaption [] [ text suite.name ]
         , logo id suite
         , button id
         ]


logo : String -> TestSuite -> Html Msg
logo id suite = a [ href (testSuitePath id) ]
                  [ img [ src suite.logo, class "grouping" ] [] ]


button : String -> Html Msg
button id = div [] [ a [ href (testSuitePath id), class "button" ]
                       [ text "Open" ] ]
