# 🔐 Row-Level Security (RLS) — Niveau 3

> **Task 2 — Niveau 3** : Implement role-based access to restrict data visibility  
> Documentation de conception pour implémentation dans Power BI Service

---

## Architecture de Sécurité Proposée — Dataset Churn

### Rôles définis

| Rôle | Filtre appliqué | Utilisateurs cibles |
|------|----------------|---------------------|
| `Regional_Manager_Northeast` | State IN {"NJ", "NY", "MD", "CT", "MA"} | Managers région NE |
| `Regional_Manager_South` | State IN {"TX", "FL", "GA", "LA", "MS"} | Managers région S |
| `Regional_Manager_West` | State IN {"CA", "WA", "OR", "NV", "AZ"} | Managers région W |
| `National_Director` | (aucun filtre — accès total) | Direction nationale |
| `Analyst_ReadOnly` | Churn[Churn] = "False" | Analystes sans accès données sensibles |

---

## Implémentation dans Power BI Desktop

### Étape 1 : Définir les rôles statiques

```
Modélisation > Gérer les rôles > Créer un rôle
```

**Rôle : Regional_Manager_Northeast**
```dax
// Filtre sur la table Churn
[State] IN { "NJ", "NY", "MD", "CT", "MA", "PA", "RI", "VT", "NH", "ME" }
```

**Rôle : Regional_Manager_South**
```dax
[State] IN { "TX", "FL", "GA", "LA", "MS", "AL", "SC", "NC", "VA", "TN", "AR", "OK" }
```

---

### Étape 2 : RLS Dynamique avec USERNAME()

```dax
// Table de mapping nécessaire : DimUserRegion
// Colonnes : UserEmail (text) | AllowedRegion (text)

// Filtre dynamique sur DimState (qui filtre FactChurn en cascade)
[Region] = LOOKUPVALUE(
    DimUserRegion[AllowedRegion],
    DimUserRegion[UserEmail], USERNAME()
)
```

**Avantage du RLS dynamique** : un seul rôle `Dynamic_Regional_Access` suffit pour tous les managers — pas besoin de créer un rôle par région.

---

### Étape 3 : Test du RLS

Dans Power BI Desktop :
```
Modélisation > Afficher comme > Sélectionner un rôle > Regional_Manager_Northeast
```

Vérifier que :
- Seuls les états Northeast apparaissent dans les visuels
- Les KPIs (Churn Rate %, Total Customers) reflètent seulement le périmètre autorisé
- Le filtre est invisible pour l'utilisateur final

---

### Étape 4 : Déploiement dans Power BI Service

1. Publier le rapport `.pbix` sur Power BI Service
2. Aller dans **Jeu de données > Sécurité**
3. Assigner les membres à chaque rôle :
   ```
   Regional_Manager_Northeast → john.smith@company.com, marie.dupont@company.com
   Regional_Manager_South → carlos.garcia@company.com
   ```
4. Tester via **"Tester en tant que rôle"**

---

## Matrice de Visibilité des Données

| Données | National_Director | Reg. Manager | Analyst_ReadOnly |
|---------|:-----------------:|:------------:|:----------------:|
| Clients churned (périmètre) | ✅ Tous | ✅ Sa région | ❌ Masqués |
| Clients retenus | ✅ Tous | ✅ Sa région | ✅ Tous |
| Charges financières | ✅ | ✅ | ✅ |
| Données personnelles | ✅ | ✅ | ❌ |
| Agrégats nationaux | ✅ | ❌ | ✅ |

---

## Bonnes Pratiques RLS

```
✅ Toujours tester avec "Afficher comme rôle" avant publication
✅ Documenter chaque rôle et ses utilisateurs assignés
✅ Préférer RLS dynamique à RLS statique pour la maintenabilité
✅ USERNAME() retourne l'email UPN — vérifier le format dans Azure AD
✅ Les mesures respectent automatiquement le RLS — pas besoin de les filtrer
✅ Les visuels de totaux affichent seulement les données visibles par l'utilisateur
✅ Tester avec un compte réel (pas seulement "Afficher comme") avant déploiement
```
