module Siren exposing (main)

import Browser
import Html exposing (Html, button, div, input, label, p, text)
import Html.Attributes exposing (autofocus, class, for, id, placeholder, value)
import Html.Events exposing (onClick, onInput)


type State
    = Initial
    | BadLength
    | Invalid
    | Valid
    | BadCharacters


type alias Model =
    { sirenNumber : String
    , state : State
    }


type Action
    = SirenUpdated String
    | ResetSirenNumber
    | SetSirenNumber


initialModel : Model
initialModel =
    Model "" Initial


characterToInteger : String -> Int
characterToInteger character =
    case String.toInt character of
        Just digit ->
            digit

        Nothing ->
            0


multiplyDigitAtOddIndex : Int -> Int -> Int
multiplyDigitAtOddIndex index digit =
    if modBy 2 index /= 0 then
        digit * 2

    else
        digit


addDigits : Int -> Int
addDigits digits =
    if digits > 9 then
        digits - 9

    else
        digits


checkSum : Int -> State
checkSum sum =
    if modBy 10 sum == 0 then
        Valid

    else
        Invalid


splitEachCharacters : String -> List String
splitEachCharacters string =
    String.split "" string


validateSirenNumber : String -> State
validateSirenNumber sirenNumber =
    case String.length sirenNumber of
        0 ->
            Initial

        9 ->
            case String.toInt sirenNumber of
                Just sirenNumberInteger ->
                    List.map characterToInteger (splitEachCharacters sirenNumber)
                        |> List.indexedMap multiplyDigitAtOddIndex
                        |> List.map addDigits
                        |> List.foldl (+) 0
                        |> checkSum

                Nothing ->
                    BadCharacters

        _ ->
            BadLength


update : Action -> Model -> Model
update action model =
    case action of
        SirenUpdated newSirenNumber ->
            { model
                | sirenNumber = String.trim newSirenNumber
                , state = validateSirenNumber <| String.trim newSirenNumber
            }

        ResetSirenNumber ->
            { model
                | sirenNumber = ""
                , state = Initial
            }

        SetSirenNumber ->
            { model
                | sirenNumber = "732829320"
                , state = Valid
            }


hint : State -> Html Action
hint state =
    case state of
        Initial ->
            p [] [ text "Le numéro SIREN - également appelé numéro unique d'identification - est un numéro à 9 chiffres qui permet d'identifier une entreprise." ]

        BadLength ->
            p [] [ text "Indice : la taille d'un numéro SIREN est de 9 caractères." ]

        Invalid ->
            p [] [ text "SIREN invalide. Merci de vérifier votre saisie." ]

        Valid ->
            p [] [ text "SIREN valide." ]

        BadCharacters ->
            p [] [ text "Indice : le numéro SIREN est composé de chiffres uniquement." ]


view : Model -> Html Action
view model =
    div
        [ class "container" ]
        [ div
            [ class "input-field" ]
            [ input
                [ autofocus True
                , placeholder "Exemple : 732829320"
                , onInput SirenUpdated
                , value model.sirenNumber
                , id "siren"
                , class "input"
                ]
                []
            , label
                [ for "siren"
                , class "input-label"
                ]
                [ text "Valider mon SIREN "
                ]
            ]
        , div
            [ class "buttons-wrapper" ]
            [ button
                [ onClick ResetSirenNumber
                , class "button"
                ]
                [ text "réinitialiser" ]
            , button
                [ class "button"
                , onClick SetSirenNumber
                ]
                [ text "exemple" ]
            ]
        , hint model.state
        ]


main : Program () Model Action
main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }
