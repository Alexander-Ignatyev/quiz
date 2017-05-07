module Views.TestSuiteList exposing (view)

import Dict exposing (Dict)
import Html exposing (Html, div, text, img, h3, a, table, thead, tbody, tr, th, td, figure, figcaption)
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
         , logo suite
         , div [ class "clear" ] []
         , button id ]


logo : TestSuite -> Html Msg
logo suite = img [ src suite.logo ] []


button : String -> Html Msg
button id = td [] [ a [ href (testSuitePath id), class "button" ]
                         [ text "Start" ] ]
