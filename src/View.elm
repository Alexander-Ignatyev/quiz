module View exposing (..)

import Html exposing (Html, div, text, img, h3)
import Html.Attributes exposing (class, src, width)
import Msgs exposing (Msg)
import Models exposing (Model, Language, LanguageTest)

view : Model -> Html Msg
view model = languageListTest model.tests


languageListTest : List LanguageTest -> Html Msg
languageListTest tests = div [] (List.map languageTest tests)

languageTest : LanguageTest -> Html Msg
languageTest test = language test.language

language : Language -> Html Msg
language lang =
  div [class "row"]
      [ div [class "two columns"]
            [h3 [] [text lang.name]]
      , div [class "six columns"]
            [img [src lang.logo, width 120] [] ]]
