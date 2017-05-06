module View exposing (..)

import RemoteData exposing (WebData)
import Array exposing (Array)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Msgs exposing (Msg)
import Models exposing (Model, TestSuite, getAnswer, getAnswers)
import Views.Test
import Views.TestSuite
import Views.TestSuiteList
import Views.Results


view : Model -> Html Msg
view model = case model.route of
  Models.TestSuitesRoute -> viewTestSuiteList model.testSuites
  Models.TestSuiteRoute testSuiteId -> viewTestSuite testSuiteId model.testSuites
  Models.TestRoute testSuiteId testId -> viewTest testSuiteId testId model
  _ -> text "TODO:"


viewTestSuiteList : WebData (Dict String TestSuite) -> Html Msg
viewTestSuiteList webData =
  case webData of
    RemoteData.NotAsked -> text ""
    RemoteData.Loading -> text "loading..."
    RemoteData.Success testSuites -> Views.TestSuiteList.view testSuites
    RemoteData.Failure error -> text (toString error)


viewTestSuite : String -> WebData (Dict String TestSuite) -> Html Msg
viewTestSuite testSuiteId webData =
  case webData of
    RemoteData.NotAsked -> text ""
    RemoteData.Loading -> text "loading..."
    RemoteData.Success testSuites ->
      let mbTestSuite = Dict.get testSuiteId testSuites
      in case mbTestSuite of
        Just testSuite -> Views.TestSuite.view testSuiteId testSuite
        Nothing -> text <| "TestSuite " ++ testSuiteId ++ " was not found"
    RemoteData.Failure error -> text (toString error)


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
        Nothing -> text <| "TestSuite " ++ testSuiteId ++ " was not found"
    RemoteData.Failure error -> text (toString error)
