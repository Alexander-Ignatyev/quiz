module Views.TestSuiteList exposing (view)

import Dict exposing (Dict)
import Html exposing (Html, div, text, img, h3)
import Html.Attributes exposing (class, src, width)
import Msgs exposing (Msg)
import Models exposing (TestSuite)


view : Dict String TestSuite -> Html Msg
view tests = Dict.map testSuite tests
  |> Dict.values
  |> div []



testSuite : String -> TestSuite -> Html Msg
testSuite id suite =
  div [class "row"]
    [ div [class "two columns"]
          [h3 [] [text suite.name]]
    , div [class "six columns"]
          [img [src suite.logo, width 120] [] ]]
