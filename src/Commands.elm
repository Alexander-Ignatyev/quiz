module Commands exposing (fetchTests)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing(LanguageTest, Language)
import RemoteData


fetchTests : Cmd Msg
fetchTests =
  Http.get testsUrl testsDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchTests


testsUrl : String
testsUrl = "data/tests.json"


testsDecoder : Decode.Decoder (List LanguageTest)
testsDecoder = Decode.list testDecoder


testDecoder : Decode.Decoder LanguageTest
testDecoder = decode LanguageTest
  |> required "language" languageDecoder


languageDecoder : Decode.Decoder Language
languageDecoder = decode Language
  |> required "name" Decode.string
  |> required "logo" Decode.string
