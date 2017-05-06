module Msgs exposing (..)

import Models exposing(LanguageTest)
import RemoteData exposing (WebData)

type Msg = OnFetchTests (WebData (List LanguageTest))
