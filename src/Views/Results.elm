module Views.Results exposing (view)

import Array
import Dict exposing (Dict)
import Html exposing (Html, div, h1, ol, li, span, text, a)
import Html.Attributes exposing (class, href)
import Models exposing (TestSuite, Test)
import Msgs exposing (Msg)
import Markdown


view : TestSuite -> Dict Int Int -> Html Msg
view suite answers =
  div [ class "row" ]
      [ h1 [] [ text "Results" ]
      , ol [ class "result-list" ]
           (Array.indexedMap (testResult answers) suite.tests |> Array.toList)
      , a [ class "button primary-button", href "#"] [ text "Start again" ]
      ]


testResult : Dict Int Int -> Int -> Test -> Html Msg
testResult answers testId test =
  li []
     [ case Dict.get testId answers of
        Just a ->
          if a == test.answer
            then correct test
            else incorrect test
        Nothing -> notAnswered test
     ]


correct : Test -> Html Msg
correct test = span []
                   [ Markdown.toHtml [] test.question
                   , span [ class "correct result" ]
                          [ text " is correct" ]
                   ]


incorrect : Test -> Html Msg
incorrect test = span []
                   [ Markdown.toHtml [] test.question
                   , span [ class "incorrect result" ]
                          [ text " is incorrect" ]
                   ]


notAnswered : Test -> Html Msg
notAnswered test = span []
                   [ Markdown.toHtml [] test.question
                   , span [ class "not answered question" ]
                          [ text " is not answered" ]
                   ]
