module Msgs exposing (..)

import Models exposing (TestSuite)
import Navigation exposing (Location)
import Dict exposing (Dict)
import RemoteData exposing (WebData)


type Msg
  = OnFetchTests (WebData (Dict String TestSuite))
  | OnLocationChange Location
  | OnOptionSelect String Int Int
