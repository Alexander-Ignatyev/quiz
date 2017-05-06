module Views.Test exposing (view)

import Array
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Models exposing (Test)
import Msgs exposing (Msg)
import Routing exposing (testPath)


view : Maybe Int -> String -> Int -> Test -> Html Msg
view answer testSuiteId testId test =
  let optionFunc = option answer testSuiteId testId
  in div []
         [ div [ class "question" ] [ text test.question ]
         , fieldset [] (Array.toList <| Array.indexedMap optionFunc test.options)
         , buttonNext answer testSuiteId testId
         ]


option : Maybe Int -> String -> Int -> Int -> String -> Html Msg
option answer testSuiteId testId optionId optionText =
  let msg = Msgs.OnOptionSelect testSuiteId testId optionId
      inputId = toString optionId
  in label [ ]
           [ input [ type_ "radio"
                   , id inputId
                   , name testSuiteId
                   , checked (Just optionId == answer)
                   , onClick msg
                   ]
                   []
            , span [ class "label-body" ] [ text optionText ]
            ]

buttonNext : Maybe Int -> String -> Int -> Html Msg
buttonNext answer suiteId testId =
  case answer of
    Just _ ->
      a [ class "button button-primary", href (testPath suiteId (testId+1)) ]
        [ text "Next" ]
    Nothing -> text ""
