module Siren exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes
import Html.Events



-- TYPES


type State
    = Initial
    | BadLength
    | Invalid
    | Valid
    | BadCharacters


type Action
    = SirenUpdated String
    | ResetSirenNumber
    | SetSirenNumber



-- MODEL


type alias Model =
    { sirenNumber : String
    , state : State
    }


initialModel : Model
initialModel =
    Model "" Initial



-- HELPERS


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
                Just _ ->
                    List.map characterToInteger (splitEachCharacters sirenNumber)
                        |> List.indexedMap multiplyDigitAtOddIndex
                        |> List.map addDigits
                        |> List.foldl (+) 0
                        |> checkSum

                Nothing ->
                    BadCharacters

        _ ->
            BadLength



-- UPDATE


update : Action -> Model -> Model
update action model =
    case action of
        SirenUpdated newSirenNumber ->
            { model
                | sirenNumber = String.trim newSirenNumber
                , state = newSirenNumber |> String.trim |> validateSirenNumber
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



-- VIEW


viewHint : State -> Html Action
viewHint state =
    case state of
        Initial ->
            Html.p [] [ Html.text "Le numéro SIREN - également appelé numéro unique d'identification - est un numéro à 9 chiffres qui permet d'identifier une entreprise." ]

        BadLength ->
            Html.p [] [ Html.text "Indice : la taille d'un numéro SIREN est de 9 caractères." ]

        Invalid ->
            Html.p [] [ Html.text "SIREN invalide. Merci de vérifier votre saisie." ]

        Valid ->
            Html.p [] [ Html.text "SIREN valide." ]

        BadCharacters ->
            Html.p [] [ Html.text "Indice : le numéro SIREN est composé de chiffres uniquement." ]


view : Model -> Html Action
view model =
    Html.div
        [ Html.Attributes.class "wrapper" ]
        [ Html.main_
            [ Html.Attributes.class "container" ]
            [ Html.div
                [ Html.Attributes.class "input-field" ]
                [ Html.input
                    [ Html.Attributes.autofocus True
                    , Html.Attributes.placeholder "Exemple : 732829320"
                    , Html.Events.onInput SirenUpdated
                    , Html.Attributes.value model.sirenNumber
                    , Html.Attributes.id "siren"
                    , Html.Attributes.class "input"
                    ]
                    []
                , Html.label
                    [ Html.Attributes.for "siren"
                    , Html.Attributes.class "input-label"
                    ]
                    [ Html.text "Valider mon SIREN "
                    ]
                ]
            , Html.div
                [ Html.Attributes.class "buttons-wrapper" ]
                [ Html.button
                    [ Html.Events.onClick ResetSirenNumber
                    , Html.Attributes.class "button"
                    ]
                    [ Html.text "réinitialiser" ]
                , Html.button
                    [ Html.Attributes.class "button"
                    , Html.Events.onClick SetSirenNumber
                    ]
                    [ Html.text "exemple" ]
                ]
            , viewHint model.state
            ]
        , Html.footer
            []
            [ Html.a
                [ Html.Attributes.class "button"
                , Html.Attributes.target "blank"
                , Html.Attributes.href "https://github.com/aminnairi/siren/"
                ]
                [ Html.text "github" ]
            ]
        ]



-- MAIN


main : Program () Model Action
main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }
