module View exposing (..)

import RemoteData exposing (WebData)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Msgs exposing (Msg)
import Models exposing (Model, TestSuite)
import Views.TestSuite
import Views.TestSuiteList


view : Model -> Html Msg
view model = case model.route of
  Models.TestSuitesRoute -> viewTestSuiteList model.testSuites
  Models.TestSuiteRoute testSuiteId -> viewTestSuite testSuiteId model.testSuites
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
        Just testSuite -> Views.TestSuite.view testSuite
        Nothing -> text <| "TestSuite " ++ testSuiteId ++ " was not found"
    RemoteData.Failure error -> text (toString error)
