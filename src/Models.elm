module Models exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)
import RemoteData exposing (WebData)


type alias AnswerDict = Dict String (Dict Int Int)

type alias Model =
  { testSuites: WebData (Dict String TestSuite)
  , route: Route
  , answers : AnswerDict
  }


type alias Test =
  { question: String
  , options: Array String
  , answer: Int
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
  , answers = Dict.empty
  }


getAnswer : String -> Int -> AnswerDict -> Maybe Int
getAnswer suiteId testId answers =
  case Dict.get suiteId answers of
    Just suiteAnswers -> Dict.get testId suiteAnswers
    Nothing -> Nothing


getAnswers : String -> AnswerDict -> Dict Int Int
getAnswers suiteId answers =
  case Dict.get suiteId answers of
    Just suiteAnswers -> suiteAnswers
    Nothing -> Dict.empty


setAnswer : String -> Int -> Int -> AnswerDict -> AnswerDict
setAnswer suiteId testId answer dict =
  let suiteAnswers = getAnswers suiteId dict
  in Dict.insert suiteId (Dict.insert testId answer suiteAnswers) dict
