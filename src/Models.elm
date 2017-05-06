module Models exposing (..)

type alias Language =
  { name: String
  , logo: String }


type alias LanguageTest =
  { language: Language
  }

type alias Model =
  { tests: List LanguageTest }
