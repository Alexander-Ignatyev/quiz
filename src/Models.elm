module Models exposing (..)

import RemoteData exposing (WebData)


type alias Language =
  { name: String
  , logo: String
  }


type alias LanguageTest =
  { language: Language
  }


type alias Model =
  { tests: WebData (List LanguageTest)
  }

initialModel : Model
initialModel =
  { tests = RemoteData.Loading
  }
