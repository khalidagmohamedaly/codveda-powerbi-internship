# 🔧 Power Query — Étapes de Transformation Documentées

> **Niveau 1 — Task 3 : Data Cleaning & Transformation**  
> Toutes les transformations sont reproductibles dans Power Query Editor (Power BI Desktop)

---

## Dataset 1 : Churn Télécom (churn-bigml-80 + churn-bigml-20)

### Étape 1 — Import et fusion des deux fichiers

```powerquery
let
    // Import fichier 80%
    Source80 = Csv.Document(
        File.Contents("01_Datasets/churn-bigml-80.csv"),
        [Delimiter=",", Columns=20, Encoding=65001, QuoteStyle=QuoteStyle.None]
    ),
    Headers80 = Table.PromoteHeaders(Source80, [PromoteAllScalars=true]),

    // Import fichier 20%
    Source20 = Csv.Document(
        File.Contents("01_Datasets/churn-bigml-20.csv"),
        [Delimiter=",", Columns=20, Encoding=65001, QuoteStyle=QuoteStyle.None]
    ),
    Headers20 = Table.PromoteHeaders(Source20, [PromoteAllScalars=true]),

    // Fusion des deux datasets
    Combined = Table.Combine({Headers80, Headers20})
in
    Combined
```

**Résultat** : 3 333 lignes (2 666 + 667) avec 20 colonnes.

---

### Étape 2 — Conversion des types de données

```powerquery
#"Changed Type" = Table.TransformColumnTypes(Combined, {
    {"State", type text},
    {"Account length", Int64.Type},
    {"Area code", Int64.Type},
    {"International plan", type text},
    {"Voice mail plan", type text},
    {"Number vmail messages", Int64.Type},
    {"Total day minutes", type number},
    {"Total day calls", Int64.Type},
    {"Total day charge", Currency.Type},
    {"Total eve minutes", type number},
    {"Total eve calls", Int64.Type},
    {"Total eve charge", Currency.Type},
    {"Total night minutes", type number},
    {"Total night calls", Int64.Type},
    {"Total night charge", Currency.Type},
    {"Total intl minutes", type number},
    {"Total intl calls", Int64.Type},
    {"Total intl charge", Currency.Type},
    {"Customer service calls", Int64.Type},
    {"Churn", type text}
})
```

---

### Étape 3 — Ajout de colonnes calculées

```powerquery
// Colonne : Segment d'ancienneté client
#"Added Tenure Group" = Table.AddColumn(
    #"Changed Type",
    "Customer_Tenure_Group",
    each
        if [Account length] <= 50 then "New (0-50)"
        else if [Account length] <= 100 then "Regular (51-100)"
        else "Loyal (101+)",
    type text
),

// Colonne : Catégorie de risque de churn
#"Added Risk Category" = Table.AddColumn(
    #"Added Tenure Group",
    "Churn_Risk_Category",
    each
        if [International plan] = "Yes" and [Customer service calls] >= 4 then "Very High Risk"
        else if [International plan] = "Yes" then "High Risk"
        else if [Customer service calls] >= 4 then "Medium Risk"
        else "Low Risk",
    type text
)
```

---

### Étape 4 — Gestion des valeurs nulles

```powerquery
// Remplacement des nulls par 0 sur les colonnes numériques critiques
#"Replaced Nulls" = Table.ReplaceValue(
    #"Added Risk Category",
    null, 0,
    Replacer.ReplaceValue,
    {
        "Total day charge", "Total eve charge",
        "Total night charge", "Total intl charge",
        "Customer service calls"
    }
)
```

---

## Dataset 2 : Boston Housing (housing_boston_no_header.csv)

> ⚠️ **Problème critique** : Ce dataset ne contient PAS d'en-têtes. Il faut renommer manuellement les 14 colonnes.

### Étape 1 — Import sans promotion d'en-têtes

```powerquery
let
    Source = Csv.Document(
        File.Contents("01_Datasets/housing_boston_no_header.csv"),
        [Delimiter=" ", Encoding=65001, QuoteStyle=QuoteStyle.None]
    )
in
    Source
```

> **Note** : Le séparateur est une espace (pas une virgule). Plusieurs espaces consécutives peuvent nécessiter un split supplémentaire ou l'utilisation de `Text.SplitAny`.

---

### Étape 2 — Renommage des 14 colonnes

```powerquery
#"Renamed Columns" = Table.RenameColumns(
    Source,
    {
        {"Column1",  "CRIM"},     // Per capita crime rate by town
        {"Column2",  "ZN"},       // Proportion residential land zoned >25,000 sq.ft
        {"Column3",  "INDUS"},    // Proportion non-retail business acres per town
        {"Column4",  "CHAS"},     // Charles River dummy variable (1 if borders river)
        {"Column5",  "NOX"},      // Nitric oxides concentration (parts per 10M)
        {"Column6",  "RM"},       // Average rooms per dwelling
        {"Column7",  "AGE"},      // Proportion units built prior to 1940
        {"Column8",  "DIS"},      // Weighted distances to 5 Boston employment centres
        {"Column9",  "RAD"},      // Index of accessibility to radial highways
        {"Column10", "TAX"},      // Full-value property-tax rate per $10,000
        {"Column11", "PTRATIO"},  // Pupil-teacher ratio by town
        {"Column12", "B"},        // 1000(Bk - 0.63)² — Bk = proportion Black residents
        {"Column13", "LSTAT"},    // % lower status of the population
        {"Column14", "MEDV"}      // Median value of homes in $1,000s (TARGET)
    }
)
```

---

### Étape 3 — Conversion et enrichissement

```powerquery
// Conversion des types
#"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns", {
    {"CRIM", type number}, {"ZN", type number}, {"INDUS", type number},
    {"CHAS", Int64.Type}, {"NOX", type number}, {"RM", type number},
    {"AGE", type number}, {"DIS", type number}, {"RAD", Int64.Type},
    {"TAX", Int64.Type}, {"PTRATIO", type number},
    {"B", type number}, {"LSTAT", type number}, {"MEDV", type number}
}),

// Colonne calculée : valeur réelle en dollars
#"Added Real Value" = Table.AddColumn(
    #"Changed Type",
    "MEDV_USD",
    each [MEDV] * 1000,
    Currency.Type
),

// Colonne calculée : catégorie de prix
#"Added Price Category" = Table.AddColumn(
    #"Added Real Value",
    "Price_Category",
    each
        if [MEDV] < 15 then "Budget (<$15K)"
        else if [MEDV] < 25 then "Mid-Range ($15-25K)"
        else if [MEDV] < 35 then "Premium ($25-35K)"
        else "Luxury ($35K+)",
    type text
)
```

---

## Dataset 3 : Sentiment Social Media (sentiment_social_media.csv)

> ⚠️ **Problème critique** : 150+ labels de sentiment incohérents → nécessité d'une macro-catégorisation.

### Étape 1 — Import et nettoyage de base

```powerquery
let
    Source = Csv.Document(
        File.Contents("01_Datasets/sentiment_social_media.csv"),
        [Delimiter=",", Encoding=65001]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),

    // Suppression de la colonne index inutile
    #"Removed Index" = Table.RemoveColumns(Headers, {"", "Unnamed: 0"}),

    // Trim des espaces sur colonnes textuelles
    #"Trimmed Text" = Table.TransformColumns(#"Removed Index", {
        {"Text", Text.Trim},
        {"Sentiment", Text.Trim},
        {"Platform", Text.Trim},
        {"Country", Text.Trim}
    })
in
    #"Trimmed Text"
```

---

### Étape 2 — Macro-catégorisation des sentiments

```powerquery
#"Added Macro Sentiment" = Table.AddColumn(
    #"Trimmed Text",
    "Macro_Sentiment",
    each
        if [Sentiment] in {
            "Positive", "Joy", "Happy", "Happiness", "Excitement", "Love",
            "Gratitude", "Hopeful", "Hope", "Awe", "Contentment", "Serenity",
            "Admiration", "Affection", "Elation", "Euphoria", "Enthusiasm",
            "Empowerment", "Fulfillment", "Determination", "Confidence",
            "Inspiration", "Motivation", "Celebration", "Proud", "Grateful",
            "Compassion", "Kindness", "Accomplishment", "Optimism", "Radiance"
        } then "Positive"
        else if [Sentiment] in {
            "Negative", "Anger", "Fear", "Sadness", "Disgust", "Despair",
            "Grief", "Loneliness", "Resentment", "Frustration", "Anxiety",
            "Helplessness", "Regret", "Bitterness", "Jealousy", "Betrayal",
            "Suffering", "Devastated", "Heartbreak", "Sorrow", "Hate",
            "Bad", "Disappointed", "Shame", "Isolation", "Desolation", "Loss"
        } then "Negative"
        else "Neutral",
    type text
),

// Normalisation des noms de pays
#"Normalized Countries" = Table.ReplaceValue(
    #"Added Macro Sentiment",
    "United States", "USA",
    Replacer.ReplaceText, {"Country"}
)
```

---

### Étape 3 — Extraction de la date

```powerquery
// Conversion de la colonne Timestamp en type DateTime
#"Changed Timestamp Type" = Table.TransformColumnTypes(
    #"Normalized Countries",
    {{"Timestamp", type datetime}}
),

// Extraction de composants date pour l'intelligence temporelle
#"Added Date Column" = Table.AddColumn(
    #"Changed Timestamp Type",
    "Date",
    each DateTime.Date([Timestamp]),
    type date
)
```

---

## Dataset 4 : Iris (iris.csv)

Le dataset Iris est déjà propre. Transformations minimales :

```powerquery
let
    Source = Csv.Document(File.Contents("01_Datasets/iris.csv"), [Delimiter=","]),
    Headers = Table.PromoteHeaders(Source),
    #"Changed Type" = Table.TransformColumnTypes(Headers, {
        {"sepal_length", type number}, {"sepal_width", type number},
        {"petal_length", type number}, {"petal_width", type number},
        {"species", type text}
    }),

    // Colonne calculée : ratio pétales (discriminant de classification)
    #"Added Petal Ratio" = Table.AddColumn(
        #"Changed Type",
        "Petal_Ratio",
        each if [petal_width] = 0 then null
             else [petal_length] / [petal_width],
        type number
    )
in
    #"Added Petal Ratio"
```

---

## Bonnes Pratiques Power Query Appliquées

| Pratique | Justification |
|----------|--------------|
| Nommer chaque étape avec `#"..."` | Lisibilité et débogage |
| Utiliser `Currency.Type` pour les montants | Précision financière |
| Trim systématique sur colonnes textuelles | Évite les doublons invisibles |
| Remplacer nulls avant calculs | Évite les erreurs DAX en aval |
| Documenter le séparateur exact | Prévient les erreurs d'import |
| Créer colonnes calculées en M plutôt qu'en DAX quand possible | Performance (calcul au refresh, pas à la volée) |
