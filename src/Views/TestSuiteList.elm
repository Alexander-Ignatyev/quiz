module Views.TestSuiteList exposing (view)

import Dict exposing (Dict)
import Html exposing (Html, div, text, img, h3, a, table, thead, tbody, tr, th, td)
import Html.Attributes exposing (class, src, width, href)
import Msgs exposing (Msg)
import Models exposing (TestSuite)
import Routing exposing (testSuitePath)


view : Dict String TestSuite -> Html Msg
view = testSuiteTable


testSuiteTable : Dict String TestSuite -> Html Msg
testSuiteTable suites =
  table [ class "u-full-width" ]
        [ thead [] [tableRow suites headerCell]
        , tbody []
                [ tableRow suites logoCell
                , tableRow suites buttonCell
                ]
        ]


tableRow : Dict String TestSuite -> (String -> TestSuite -> Html Msg) -> Html Msg
tableRow suites cellFunc = Dict.map cellFunc suites
  |> Dict.values
  |> tr []


headerCell : String -> TestSuite -> Html Msg
headerCell _ suite = th [] [ text suite.name ]


logoCell : String -> TestSuite -> Html Msg
logoCell _ suite = td [] [ img [src suite.logo, width 120] [] ]


buttonCell : String -> TestSuite -> Html Msg
buttonCell id _ = td [] [ a [ href (testSuitePath id), class "button" ]
                            [ text "Start" ] ]
