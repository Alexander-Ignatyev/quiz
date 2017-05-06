module Models exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)
import RemoteData exposing (WebData)


type alias Model =
  { testSuites: WebData (Dict String TestSuite)
  , route: Route
  }


type alias Test =
  { question: String
  }


type alias TestSuite =
  { name: String
  , description: String
  , logo: String
  , tests: Array Test
  }


type Route =
  TestSuitesRoute
  | TestSuiteRoute String
  | TestRoute String Int
  | NotFoundRoute


initialModel : Route -> Model
initialModel route =
  { testSuites = RemoteData.Loading
  , route = route
  }
