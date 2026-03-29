# ⚡ Documentation DAX — Niveaux 2 & 3

> **Auteur** : Khalid Ag Mohamed Aly  
> **Référence** : [dax.guide](https://www.dax.guide) | [SQLBI Patterns](https://www.daxpatterns.com)

---

## Fonctions Utilisées — Tableau de Référence

| Fonction | Catégorie | Niveau | Description | Usage dans ce projet |
|----------|-----------|--------|-------------|---------------------|
| `SUM` | Aggregation | L2 | Somme d'une colonne | Total charges churn |
| `AVERAGE` | Aggregation | L2 | Moyenne arithmétique | Charge jour moyenne |
| `COUNTROWS` | Table | L2 | Compte les lignes d'une table | Volume clients/posts |
| `DIVIDE` | Math | L2 | Division sécurisée (évite /0) | Tous les taux en % |
| `IF` | Logical | L2 | Condition binaire | Catégories de risque |
| `CALCULATE` | Filter | L2 | Modifie le contexte de filtre | Churn par segment |
| `FILTER` | Table | L2 | Retourne une table filtrée | Clients churned only |
| `AVERAGEX` | Iterator | L2 | Moyenne sur expression | Ratio pétale Iris |
| `SUMX` | Iterator | L2 | Somme sur expression | Revenue total |
| `TOTALYTD` | Time Intel | L2 | Cumul year-to-date | Posts YTD |
| `TOTALMTD` | Time Intel | L2 | Cumul month-to-date | Posts MTD |
| `DATEADD` | Time Intel | L2 | Décalage temporel | Croissance MoM |
| `RANKX` | Ranking | L3 | Classement dynamique | États par churn |
| `SWITCH` | Logical | L3 | Condition multiple | Labels performance |
| `LOOKUPVALUE` | Lookup | L3 | Recherche valeur dans table | Nom état complet |
| `VAR` / `RETURN` | Variables | L3 | Variable locale | Optimisation calculs |
| `SELECTEDVALUE` | Filter | L3 | Valeur unique sélectionnée | Contexte slicer |
| `ALLEXCEPT` | Filter | L3 | Efface tous filtres sauf | Calculs cross-filter |

---

## Contexte Row vs Filter Context

### Row Context (Contexte de Ligne)
> S'applique dans les **colonnes calculées** et les fonctions **ITERATOR** (SUMX, AVERAGEX, FILTER)

```dax
// ✅ Row Context — évalue ligne par ligne dans Iris
Petal_Ratio = DIVIDE(Iris[petal_length], Iris[petal_width])
// → Calcule le ratio pour CHAQUE ligne de la table Iris

// ✅ Row Context dans AVERAGEX
Avg Petal Ratio = AVERAGEX(Iris, DIVIDE(Iris[petal_length], Iris[petal_width]))
// → Itère sur chaque ligne, calcule le ratio, puis fait la moyenne
```

### Filter Context (Contexte de Filtre)
> S'applique dans les **mesures** — dicté par les visuels, slicers, et CALCULATE

```dax
// La même mesure donne des résultats DIFFÉRENTS selon le contexte
Churn Rate % = DIVIDE(COUNTROWS(FILTER(Churn, Churn[Churn]="True")), COUNTROWS(Churn))

// Dans un visuel "filtré par State = TX" :
// → Compte seulement les clients du Texas

// CALCULATE crée un nouveau Filter Context :
Intl Plan Churn Rate % = CALCULATE([Churn Rate %], Churn[International plan] = "Yes")
// → Force le filtre International plan = Yes, peu importe le slicer
```

---

## Pattern : DIVIDE pour la sécurité

```dax
// ❌ JAMAIS utiliser / directement
Churn Rate = [Churned] / [Total]   // Erreur si Total = 0

// ✅ TOUJOURS utiliser DIVIDE avec valeur alternative
Churn Rate = DIVIDE([Churned], [Total], 0)   // Retourne 0 si Total = 0
Churn Rate = DIVIDE([Churned], [Total], BLANK())   // Retourne vide si Total = 0
```

---

## Pattern : VAR pour la lisibilité et la performance

```dax
// ❌ Expression répétée deux fois (calcul double)
Revenue Lost = 
    COUNTROWS(FILTER(Churn, Churn[Churn]="True"))
    * AVERAGE(Churn[Total day charge])
    / COUNTROWS(FILTER(Churn, Churn[Churn]="True"))   // Recalcul !

// ✅ VAR calcule une seule fois
Revenue Lost =
VAR ChurnedCount = COUNTROWS(FILTER(Churn, Churn[Churn]="True"))
VAR AvgCharge = AVERAGE(Churn[Total day charge])
RETURN
    ChurnedCount * AvgCharge
```

---

## Pattern : RANKX avec ALL()

```dax
// RANKX nécessite ALL() pour avoir accès à tous les éléments à classer
State Churn Rank =
RANKX(
    ALL(Churn[State]),     // "Tous les états" — pas juste ceux dans le filtre actuel
    [Churn Rate %],        // La mesure à classer
    ,                      // Valeur (vide = utilise la mesure sur la ligne courante)
    DESC,                  // Tri : DESC = 1 = valeur la plus haute
    Dense                  // Dense = pas de trous (1,2,2,3) vs Skip (1,2,2,4)
)
```

---

## Pattern : SWITCH(TRUE()) pour conditions multiples

```dax
// SWITCH(TRUE()) = évaluation de la PREMIÈRE condition vraie
Performance Label =
SWITCH(TRUE(),
    [Churn Rate %] > 30, "Critical",    // Évalué en premier
    [Churn Rate %] > 20, "Severe",      // Si la 1ère est fausse
    [Churn Rate %] > 10, "Moderate",    // Si la 2ème est fausse
    "Good"                              // Valeur par défaut
)

// Équivalent à IF imbriqués, mais plus lisible
```

---

## Bonnes Pratiques — Checklist

```
✅ Toujours utiliser DIVIDE() — jamais l'opérateur /
✅ Nommer les mesures de façon descriptive : [Churn Rate %] pas [CR]
✅ Documenter chaque mesure avec un commentaire // Description
✅ Utiliser des VAR pour les expressions répétées (performance)
✅ Tester avec DIFFÉRENTS filtres actifs (slicer État, Plan, etc.)
✅ Créer des mesures "briques" simples avant les mesures complexes
✅ Préfixer les mesures de debug : [DEBUG Filter Context]
✅ Utiliser BLANK() plutôt que 0 quand "pas de données" ≠ "zéro"
✅ Déclarer les types de retour dans les commentaires pour clarté
✅ Regrouper les mesures dans des dossiers d'affichage (Display Folders)
```

---

## Display Folders Recommandés

Organiser les mesures dans Power BI Desktop (champ "Dossier d'affichage") :

```
📁 KPIs
    → Churn Rate %
    → Total Posts
    → Avg Home Value (USD)

📁 Churn Analysis
    → Count Churned Customers
    → Avg Day Charge Churned
    → Intl Plan Churn Rate %
    → State Churn Rank

📁 Sentiment
    → Positive Sentiment %
    → Posts YTD / MTD

📁 Time Intelligence
    → Posts YTD
    → Posts MoM Growth %
    → Posts 3M Rolling Average

📁 Debug
    → Debug Filter Context
```
