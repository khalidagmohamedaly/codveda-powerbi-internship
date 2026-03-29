# 📊 Codveda Power BI Internship — Data Analysis Dashboard

> **Auteur** : Khalid Ag Mohamed Aly  
> **Institution** : Université Centrale de Tunis  
> **Organisation** : Codveda Technologies  
> **Période** : Mars 2026  
> **Statut** : ✅ Niveaux 1 & 2 complétés

---

## 🎯 Vue d'Ensemble

Ce projet démontre la maîtrise complète du pipeline Power BI — de l'import des données brutes jusqu'aux insights actionnables — dans le cadre du programme d'internship Codveda Technologies.

**5 datasets analysés · 4 763 enregistrements · 12+ mesures DAX · Dashboard interactif HTML**

---

## ✅ Tâches Complétées

### Niveau 1 — Task 3 : Data Cleaning & Transformation (Power Query)
- [x] Import de 5 datasets CSV hétérogènes (formats, encodages, structures variés)
- [x] Correction des en-têtes manquants — Boston Housing Dataset (14 colonnes renommées)
- [x] Regroupement de 150+ labels de sentiment en 3 macro-catégories cohérentes
- [x] Fusion des datasets churn split 80/20 via `Table.Combine()`
- [x] Gestion des valeurs nulles, conversion de types, colonnes conditionnelles
- [x] Documentation complète des transformations M (Power Query)

### Niveau 2 — Task 2 : DAX Basics
- [x] 10+ mesures DAX production-ready couvrant SUM, AVERAGE, COUNT, IF
- [x] Maîtrise de `DIVIDE`, `CALCULATE`, `FILTER`, `COUNTROWS`
- [x] Compréhension et application des contextes Row vs Filter
- [x] Fonctions d'intelligence temporelle : `TOTALYTD`, `TOTALMTD`
- [x] Mesures avancées : `RANKX`, `SWITCH`, `LOOKUPVALUE`
- [x] Documentation complète avec exemples et bonnes pratiques

---

## 📁 Structure du Projet

```
codveda-powerbi-internship/
│
├── 📄 README.md                          ← Ce fichier
├── 📄 .gitignore
│
├── 📂 01_Datasets/                       ← Données sources brutes
│   ├── churn-bigml-80.csv               (2 666 lignes)
│   ├── churn-bigml-20.csv               (667 lignes)
│   ├── sentiment_social_media.csv       (732 lignes)
│   ├── iris.csv                         (150 lignes)
│   └── housing_boston_no_header.csv     (505 lignes — sans en-têtes)
│
├── 📂 02_PowerQuery_Transformations/     ← Code M documenté
│   ├── power_query_steps.md
│   ├── housing_column_names.txt
│   └── sentiment_grouping_logic.m
│
├── 📂 03_DataModel/                      ← Modélisation des données
│   ├── star_schema_explanation.md
│   └── calculated_columns.dax
│
├── 📂 04_DAX_Measures/                   ← Bibliothèque de mesures
│   ├── level2_basic_measures.dax
│   ├── level3_advanced_measures.dax
│   └── dax_documentation.md
│
├── 📂 05_Reports/                        ← Rapports et dashboard
│   ├── codveda_powerbi_dashboard.html   ← Dashboard interactif
│   └── dashboard_screenshots/
│
├── 📂 06_Security_Automation/            ← Niveau 3 (RLS + Power Automate)
│   ├── rls_roles_definition.md
│   └── power_automate_flow.md
│
├── 📂 07_Documentation/                  ← Livrables finaux
│   ├── video_script.md
│   └── linkedin_post_draft.md
│
└── 📂 assets/
```

---

## 🔑 Insights Clés

### 📉 Churn Télécom (3 333 clients)
> **42% de churn** chez les abonnés avec International Plan vs **11%** sans → risque **3,8× plus élevé**  
> États les plus à risque : TX, NJ, MD, MI, NY  
> Charge journalière moyenne des churners : **$36.2** vs $29.8 pour les clients fidèles

### 💬 Sentiment Social Media (732 posts)
> **62% de sentiment positif** — mais 150+ labels incohérents nécessitent une normalisation Power Query  
> Pic de posts en **janvier-février**, baisse notable en décembre  
> Répartition équilibrée entre Twitter (33%), Instagram (35%), Facebook (32%)

### 🏠 Boston Housing (505 propriétés)
> Valeur médiane des maisons : **$22 500** (en milliers de dollars)  
> Dataset sans en-têtes — transformation Power Query critique avant toute analyse

### 🌸 Iris (150 échantillons)
> Distribution parfaitement équilibrée : 50 échantillons par espèce  
> Ratio pétales = meilleur discriminant entre espèces (DAX : `DIVIDE([petal_length], [petal_width])`)

---

## 🚀 Utilisation

### Prérequis
- Power BI Desktop (version recommandée : mars 2026+)
- Navigateur moderne pour le dashboard HTML interactif

### Démarrage rapide

```bash
# Cloner le repository
git clone https://github.com/votre-username/codveda-powerbi-internship.git
cd codveda-powerbi-internship

# Ouvrir le dashboard interactif (aucune installation requise)
open 05_Reports/codveda_powerbi_dashboard.html
```

Pour le fichier `.pbix` Power BI Desktop :
1. Ouvrir Power BI Desktop
2. `Fichier > Ouvrir` → `05_Reports/Codveda_Dashboard.pbix`
3. Actualiser les chemins de données si nécessaire (`Transformer les données > Paramètres de la source`)

---

## 🛠️ Stack Technique

| Outil | Usage |
|-------|-------|
| **Power BI Desktop** | Modélisation, visualisation, publication |
| **Power Query (M)** | ETL, nettoyage, transformation |
| **DAX** | Mesures calculées, intelligence temporelle |
| **Chart.js** | Dashboard HTML interactif |
| **GitHub** | Versioning, collaboration, portfolio |

---

## 📚 Ressources de Référence

- [Documentation Power Query M](https://learn.microsoft.com/fr-fr/powerquery-m/)
- [DAX Guide — SQLBI](https://www.dax.guide/)
- [Bonnes pratiques Star Schema](https://learn.microsoft.com/fr-fr/power-bi/guidance/star-schema)
- [Codveda Technologies](https://www.codveda.com)

---

## 🎥 Présentation Vidéo

> 🔗 *Lien vidéo LinkedIn à ajouter après l'enregistrement*

Script complet disponible : [`07_Documentation/video_script.md`](07_Documentation/video_script.md)

---

## 📬 Contact

- 🔗 [LinkedIn — Khalid Ag Mohamed Aly](https://linkedin.com/in/khalid-ag-mohamed-aly)
- 🐙 [GitHub](https://github.com/votre-username)
- ✉️ khalid.aly@example.com

---

## 🏷️ Tags

`#CodvedaJourney` `#CodvedaExperience` `#FutureWithCodveda` `#PowerBI` `#DAX` `#PowerQuery` `#DataAnalytics` `#AfricanTech`

---

> *Projet développé dans le cadre de l'internship Codveda Technologies — Mars 2026*
