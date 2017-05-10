module View exposing (..)

import RemoteData exposing (WebData)
import String
import Array exposing (Array)
import Dict exposing (Dict)
import Html exposing (Html, text, div)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Model, TestSuite, getAnswer, getAnswers)
import Views.Test
import Views.TestSuite
import Views.TestSuiteList
import Views.Results
import Views.Error
import Views.Nav


view : Model -> Html Msg
view model =
  div []
      [ Views.Nav.bar model
      , div [ class "container" ] [ page model ]
      ]


page : Model -> Html Msg
page model = case model.route of
  Models.TestSuitesRoute -> viewTestSuiteList model.testSuites
  Models.TestSuiteRoute testSuiteId -> viewTestSuite testSuiteId model.testSuites
  Models.TestRoute testSuiteId testId -> viewTest testSuiteId testId model
  Models.NotFoundRoute -> Views.Error.view "Page Not Found"


viewTestSuiteList : WebData (Dict String TestSuite) -> Html Msg
viewTestSuiteList webData =
  case webData of
    RemoteData.NotAsked -> text ""
    RemoteData.Loading -> text "loading..."
    RemoteData.Success testSuites -> Views.TestSuiteList.view testSuites
    RemoteData.Failure error -> Views.Error.view (toString error)


viewTestSuite : String -> WebData (Dict String TestSuite) -> Html Msg
viewTestSuite testSuiteId webData =
  case webData of
    RemoteData.NotAsked -> text ""
    RemoteData.Loading -> text "loading..."
    RemoteData.Success testSuites ->
      let mbTestSuite = Dict.get testSuiteId testSuites
      in case mbTestSuite of
        Just testSuite -> Views.TestSuite.view testSuiteId testSuite
        Nothing -> Views.Error.view <| String.concat [ "TestSuite ", testSuiteId, " was not found"]
    RemoteData.Failure error -> Views.Error.view (toString error)


viewTest : String -> Int -> Model -> Html Msg
viewTest testSuiteId testId model =
  case model.testSuites of
    RemoteData.NotAsked -> text ""
    RemoteData.Loading -> text "loading..."
    RemoteData.Success testSuites ->
      let mbTestSuite = Dict.get testSuiteId testSuites
          answer = getAnswer testSuiteId testId model.answers
      in case mbTestSuite of
        Just testSuite ->
          case Array.get testId testSuite.tests of
            Just test -> Views.Test.view answer testSuiteId testId test
            Nothing -> Views.Results.view testSuite (getAnswers testSuiteId model.answers)
        Nothing -> Views.Error.view <| String.concat [ "TestSuite ", testSuiteId, " was not found"]
    RemoteData.Failure error -> Views.Error.view (toString error)
