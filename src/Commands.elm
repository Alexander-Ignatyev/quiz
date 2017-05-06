module Commands exposing (fetchTests)

import Http
import Array exposing (Array)
import Dict exposing (Dict)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing(TestSuite, Test)
import RemoteData


fetchTests : Cmd Msg
fetchTests =
  Http.get testsUrl testSuitesDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchTests


testsUrl : String
testsUrl = "data/tests.json"


testSuitesDecoder : Decode.Decoder (Dict String TestSuite)
testSuitesDecoder = Decode.dict testSuiteDecoder


testSuiteDecoder : Decode.Decoder TestSuite
testSuiteDecoder = decode TestSuite
  |> required "name" Decode.string
  |> required "description" Decode.string
  |> required "logo" Decode.string
  |> required "tests" testsDecoder


testsDecoder : Decode.Decoder (Array Test)
testsDecoder = Decode.array testDecoder


testDecoder : Decode.Decoder Test
testDecoder = decode Test
  |> required "question" Decode.string
  |> required "options" (Decode.array Decode.string)
  |> required "answer" Decode.int
