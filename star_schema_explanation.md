# 🗄️ Modélisation des Données — Star Schema

> **Niveau 2 — Task 1 : Creating Relationships and Data Modeling**

---

## Architecture Recommandée : Star Schema

```
                    ┌─────────────────┐
                    │   DimDate       │
                    │─────────────────│
                    │ DateKey (PK)    │
                    │ Date            │
                    │ Year            │
                    │ Month           │
                    │ MonthName       │
                    │ Quarter         │
                    │ DayOfWeek       │
                    └────────┬────────┘
                             │ 1
                             │
          ┌──────────────────┼──────────────────┐
          │                  │                  │
          │ *                │ *                │ *
┌─────────┴──────┐  ┌────────┴───────┐  ┌──────┴──────────┐
│ FactChurn      │  │ FactSentiment  │  │ FactHousing     │
│────────────────│  │────────────────│  │─────────────────│
│ ChurnID (PK)   │  │ PostID (PK)    │  │ HouseID (PK)    │
│ StateKey (FK)  │  │ DateKey (FK)   │  │ CRIM            │
│ Account length │  │ PlatformKey(FK)│  │ ZN, INDUS, CHAS │
│ Intl Plan      │  │ CountryKey(FK) │  │ NOX, RM, AGE    │
│ VM Plan        │  │ Sentiment      │  │ DIS, RAD, TAX   │
│ Day/Eve/Night  │  │ Macro_Sentmt   │  │ PTRATIO, B      │
│ Charges        │  │ Retweets, Likes│  │ LSTAT           │
│ Svc Calls      │  │ Hashtags       │  │ MEDV ← target   │
│ Churn (bool)   │  └────────────────┘  └─────────────────┘
└────────┬───────┘
         │ * ──────────────── 1
         │
┌────────┴───────────┐
│ DimState           │
│────────────────────│
│ StateCode (PK)     │
│ StateName          │
│ Region             │ (Northeast/South/Midwest/West)
│ AreaCode           │
└────────────────────┘
```

---

## Tables de Dimension

### DimDate (Table de dates — Power BI)
```dax
// Créer dans Power BI : Modélisation > Nouvelle table
DimDate = 
CALENDAR(
    DATE(2023, 1, 1),
    DATE(2023, 12, 31)
)
```

Puis ajouter les colonnes calculées :
```dax
Year = YEAR(DimDate[Date])
Month = MONTH(DimDate[Date])
MonthName = FORMAT(DimDate[Date], "MMMM")
Quarter = "Q" & QUARTER(DimDate[Date])
DayOfWeek = FORMAT(DimDate[Date], "dddd")
```

### DimState (Mapping codes → noms complets)
| StateCode | StateName | Region |
|-----------|-----------|--------|
| TX | Texas | South |
| NJ | New Jersey | Northeast |
| MD | Maryland | Northeast |
| MI | Michigan | Midwest |
| NY | New York | Northeast |
| CA | California | West |
| ... | ... | ... |

---

## Relations entre Tables

| Table de Faits | Clé de Faits | Table de Dimension | Clé de Dimension | Type |
|---------------|--------------|-------------------|-----------------|------|
| FactChurn | State | DimState | StateCode | Many-to-One |
| FactSentiment | Date (date part) | DimDate | DateKey | Many-to-One |
| FactSentiment | Platform | DimPlatform | PlatformKey | Many-to-One |
| FactSentiment | Country | DimCountry | CountryKey | Many-to-One |

**Type de cardinalité utilisé** : Plusieurs-à-un (N:1) — modèle en étoile classique  
**Direction du filtre croisé** : Unidirectionnelle (dimension → faits)

---

## Schéma Snowflake (Extension possible)

Si `DimState` est étendue avec une table `DimRegion` :

```
DimRegion (1) ←── DimState (N) ←── FactChurn (N)
               RegionID          StateCode
```

Cette extension permet des analyses "drill-down" : Région → État → Client.

---

## Bonnes Pratiques Appliquées

1. **Pas de relations Many-to-Many directes** — toujours via une table de jonction
2. **Clés de substitution** (surrogate keys) plutôt que clés naturelles composites
3. **Table DimDate complète** — recommandée par Microsoft pour l'intelligence temporelle
4. **Colonnes calculées dans les dimensions**, pas dans les faits — améliore les performances
5. **Désactiver la date automatique** : Fichier > Options > Chargement des données > Décocher "Intelligence temporelle automatique"
