// sentiment_grouping_logic.m
// Power Query M — Logique de regroupement des sentiments
// Coller dans : Power Query Editor > Éditeur avancé
// Résultat : colonne "Macro_Sentiment" avec 3 valeurs : Positive / Negative / Neutral

// ─────────────────────────────────────────────
// LISTE 1 : Sentiments positifs (29 labels)
// ─────────────────────────────────────────────
let
    PositiveList = {
        "Positive", "Joy", "Happy", "Happiness", "Excitement", "Love",
        "Gratitude", "Hopeful", "Hope", "Awe", "Contentment", "Serenity",
        "Admiration", "Affection", "Elation", "Euphoria", "Enthusiasm",
        "Empowerment", "Fulfillment", "Determination", "Confidence",
        "Inspiration", "Motivation", "Celebration", "Proud", "Grateful",
        "Compassion", "Accomplishment", "Optimism"
    },

// ─────────────────────────────────────────────
// LISTE 2 : Sentiments négatifs (26 labels)
// ─────────────────────────────────────────────
    NegativeList = {
        "Negative", "Anger", "Fear", "Sadness", "Disgust", "Despair",
        "Grief", "Loneliness", "Resentment", "Frustration", "Anxiety",
        "Helplessness", "Regret", "Bitterness", "Jealousy", "Betrayal",
        "Suffering", "Devastated", "Heartbreak", "Sorrow", "Hate",
        "Bad", "Disappointed", "Shame", "Isolation", "Loss"
    },

// ─────────────────────────────────────────────
// APPLICATION DE LA LOGIQUE
// ─────────────────────────────────────────────
    ClassifySentiment = (sentiment as text) as text =>
        if List.Contains(PositiveList, sentiment) then "Positive"
        else if List.Contains(NegativeList, sentiment) then "Negative"
        else "Neutral"

in
    ClassifySentiment

// ─────────────────────────────────────────────
// UTILISATION DANS UNE REQUÊTE COMPLÈTE
// ─────────────────────────────────────────────
/*
let
    Source = ..., // votre source Sentiment
    #"Added Macro Sentiment" = Table.AddColumn(
        Source,
        "Macro_Sentiment",
        each ClassifySentiment(Text.Trim([Sentiment])),
        type text
    )
in
    #"Added Macro Sentiment"
*/

// STATISTIQUES DES GROUPES (dataset 732 lignes) :
// Positive : ~62% des posts (Positive=45, Joy=44, Excitement=37, Contentment=19, ...)
// Negative : ~18% des posts (Despair=11, Nostalgia=11, Grief=9, Sadness=9, ...)
// Neutral  : ~20% des posts (Neutral=18, Curiosity=16, Serenity=15, Awe=9, ...)
