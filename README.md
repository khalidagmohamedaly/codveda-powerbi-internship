# 📊 Codveda Power BI Internship — Data Analysis Dashboard

![Power BI](https://img.shields.io/badge/Power_BI-Desktop-F2C811?logo=microsoft-power-bi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-Advanced-0078D4?logo=microsoft)
![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Status](https://img.shields.io/badge/Status-Levels_1_%26_2_Completed-success)
![Last Commit](https://img.shields.io/github/last-commit/khalidagmohamedaly/codveda-powerbi-internship)

> **Auteur** : Khalid Ag Mohamed Aly  
> **Institution** : Université Centrale de Tunis & African Development University  
> **Organisation** : Codveda Technologies  
> **Période** : Mars 2026  
> **Statut** : ✅ Niveaux 1 & 2 complétés | 🔄 Niveau 3 en cours

---

## 📑 Table des Matières

1. [Vue d'Ensemble](#-vue-densemble)
2. [Structure du Projet](#-structure-du-projet)
3. [Installation](#-installation)
4. [Aperçu du Dashboard](#-aperçu-du-dashboard)
5. [Insights Clés](#-insights-clés)
6. [Documentation Technique](#-documentation-technique)
7. [Tâches Codveda Complétées](#-tâches-codveda-complétées)
8. [Stack Technique](#-stack-technique)
9. [Vidéo de Présentation](#-vidéo-de-présentation)
10. [Contact](#-contact)

---

## 🎯 Vue d'Ensemble

Ce projet démontre la maîtrise complète du pipeline Power BI — de l'import des données brutes jusqu'aux insights actionnables. Un dashboard interactif analysant **4,763 enregistrements** répartis sur **5 datasets** différents.

**Datasets analysés** :
- 📉 **Churn Telecom** (3,333 clients) — Analyse prédictive de l'attrition
- 💬 **Sentiment Social Media** (732 posts) — Analyse des émotions sur Twitter, Instagram, Facebook
- 🌸 **Iris Dataset** (150 fleurs) — Classification botanique
- 🏠 **Boston Housing** (505 maisons) — Régression immobilière
- 📊 **Overview** — Synthèse et qualité des données

**Compétences démontrées** :
- ✅ Power Query : Nettoyage et transformation de données (M Language)
- ✅ DAX : 12+ mesures avancées (DIVIDE, CALCULATE, RANKX, SWITCH, TOTALYTD)
- ✅ Data Modeling : Star Schema et relations optimisées
- ✅ Visualisations : Chart.js interactives et design professionnel
- ✅ Row-Level Security (RLS) : Gestion des accès par rôles (Niveau 3)
  

---

## 📁 Structure du Projet
codveda-powerbi-internship/
├── 📄 README.md # Documentation principale
├── 📄 LICENSE # Licence MIT
├── 📄 .gitignore # Fichiers ignorés
│
├── 📁 01_Datasets/ # Données brutes
│ ├── churn-bigml-80.csv # 2,666 clients (80%)
│ ├── churn-bigml-20.csv # 667 clients (20%)
│ ├── sentiment_social_media.csv # 732 posts
│ ├── iris.csv # 150 fleurs
│ └── logement_boston_sans_en-tête.csv # 505 maisons
│
├── 📁 02_DAX_Measures/ # Mesures DAX
│ ├── level2_basic_measures.dax # Niveau 2 : SUM, AVERAGE, IF
│ ├── level3_advanced_measures.dax # Niveau 3 : RANKX, SWITCH
│ └── colonnes_calculees.dax # Colonnes calculées
│
├── 03_Documentation/ # Guides techniques
│ ├── power_query_steps.md # Étapes de transformation
│ ├── dax_documentation.md # Référence DAX
│ ├── star_schema_explanation.md # Modélisation
│ └── rls_roles_definition.md # Row-Level Security
│
├── 04_PowerQuery/ # Code M
│ ├── logique_de_regroupement_des_sentiments.m
│ └── noms_colonnes_logement.txt
│
├── 📁 05_Reports/ # Rapports
│ └── codveda_powerbi_dashboard.html # Dashboard interactif
│
└── assets/ # Médias
├── dashboard_overview.png
├── dashboard_churn.png
├── dashboard_sentiment.png
└── logo_codveda.png

---

## 🚀 Installation

### Prérequis
- Navigateur web moderne (Chrome, Firefox, Edge)
- Ou Power BI Desktop (pour ouvrir les fichiers .pbix)

### Méthode 1 : Dashboard HTML (Recommandé)

1. **Cloner le repository** :
   ```bash
   git clone https://github.com/khalidagmohamedaly/codveda-powerbi-internship.git
   cd codveda-powerbi-internship
   # Double-cliquez sur le fichier HTML
05_Reports/codveda_powerbi_dashboard.html
Naviguer dans les onglets :
📊 Overview
📉 Churn Analysis
💬 Sentiment
🌸 Iris Dataset
🏠 House Prices
⚡ DAX Reference
Méthode 2 : Power BI Desktop
Télécharger et installer Power BI Desktop
Importer les datasets depuis 01_Datasets/
Appliquer les transformations Power Query (voir 03_Documentation/power_query_steps.md)
Créer les mesures DAX (voir 02_DAX_Measures/)
📊 Aperçu du Dashboard
Vue d'Ensemble


Synthèse des 5 datasets avec KPIs principaux et qualité des données
Analyse Churn


Identification des facteurs de risque : International Plan = 42% de churn
Analyse Sentiment


Répartition des émotions sur les réseaux sociaux (62% positif)
Référence DAX


Bibliothèque de mesures DAX prêtes à l'emploi
🔑 Insights Clés
📉 Churn Telecom — Insight Majeur
🎯 Découverte : Les clients avec un International Plan ont un taux de churn de 42% vs 11% pour les autres.
📊 Impact : 3.8× plus de risque de départ
💡 Recommandation : Réviser la tarification des forfaits internationaux
Mesure DAX utilisée :
Churn Rate = 
DIVIDE(
  COUNTROWS(FILTER(Churn, Churn[Churn] = "True")),
  COUNTROWS(Churn),
  0
) * 100
💬 Sentiment Analysis — Qualité des Données
⚠️ Problème : 150+ labels de sentiment uniques (incohérents)
✅ Solution : Regroupement en 3 macro-catégories via Power Query
📈 Résultat : 62% de sentiment positif sur 732 posts
Transformation Power Query :
Macro_Sentiment = 
if [Sentiment] in {"Positive", "Joy", "Happy", "Excitement"} then "Positive"
else if [Sentiment] in {"Negative", "Anger", "Fear", "Sadness"} then "Negative"
else "Neutral"

🏠 Boston Housing — Nettoyage Requis
🔧 Action : Dataset sans en-têtes → Renommage manuel des 14 colonnes requis
📋 Colonnes : CRIM, ZN, INDUS, CHAS, NOX, RM, AGE, DIS, RAD, TAX, PTRATIO, B, LSTAT, MEDV
🎯 Cible : MEDV (Median Value of homes en $1,000s)
🔐 Row-Level Security (Niveau 3)
👥 Rôles implémentés :
Regional_Manager (accès par région géographique)
National_Director (accès total)
Analyst_ReadOnly (données agrégées uniquement)
Filtre RLS Dynamique :
[Region] = LOOKUPVALUE(
    DimUserRegion[AllowedRegion],
    DimUserRegion[UserEmail], USERNAME()
)
📚 Documentation Technique
Power Query (Niveau 1 - Task 3)
Étapes de transformation
Import CSV avec encoding UTF-8
Gestion des en-têtes manquants
Regroupement des sentiments
Fusion des datasets (churn 80/20)
Code M - Regroupement Sentiments
Transformation de 150+ labels → 3 catégories
DAX Measures (Niveau 2 - Task 2)
Mesures de base
Churn Rate, Avg Day Charge, Positive Sentiment %
Fonctions : SUM, AVERAGE, COUNT, IF, DIVIDE
Mesures avancées
RANKX, SWITCH, LOOKUPVALUE, TOTALYTD
Calculs avec VAR pour optimisation
Documentation DAX
Référence des fonctions utilisées
Bonnes pratiques
Data Modeling
Star Schema
Tables de faits et dimensions
Relations optimisées
Row-Level Security
Rôles statiques et dynamiques
Implémentation USERNAME()
Matrice de visibilité
✅ Tâches Codveda Complétées
Niveau 1 - Task 3 : Data Cleaning & Power Query ✅
✅ Import de 5 datasets CSV hétérogènes
✅ Gestion des en-têtes manquants (Boston Housing)
✅ Regroupement de 150+ labels de sentiment en 3 catégories
✅ Fusion de datasets split (churn 80/20)
✅ Documentation complète des transformations M
✅ Gestion des valeurs nulles et incohérentes
Niveau 2 - Task 2 : DAX Basics ✅
✅ 12+ mesures DAX production-ready
✅ Maîtrise de DIVIDE, CALCULATE, FILTER, IF
✅ Compréhension des contextes Row/Filter
✅ Mesures temporelles (TOTALYTD)
✅ Colonnes calculées (Petal Ratio, Tenure Group)
Niveau 3 - Task 2 : Row-Level Security 🔄
✅ Définition de 5 rôles (Regional Managers, Director, Analyst)
✅ Implémentation RLS statique
✅ Conception RLS dynamique avec USERNAME()
✅ Matrice de visibilité des données
⏳ Déploiement dans Power BI Service (en attente)
🛠️ Stack Technique
Outil
Usage
Niveau
Power BI Desktop
Visualisation & reporting
Avancé
Power Query (M)
ETL & transformation
Avancé
DAX
Calculs & mesures
Intermédiaire-Avancé
Chart.js
Visualisations HTML
Intermédiaire
GitHub
Versioning & collaboration
Intermédiaire
HTML/CSS/JS
Dashboard interactif
Intermédiaire
Fonctions DAX Maîtrisées
Catégorie
Fonctions
Aggregation
SUM, AVERAGE, COUNT, COUNTROWS, MIN, MAX
Filter
FILTER, CALCULATE, ALL, VALUES
Logical
IF, SWITCH, AND, OR, IN
Iterator
RANKX, SUMX, AVERAGEX
Time Intelligence
TOTALYTD, TOTALMTD, DATEADD
Math
DIVIDE, ROUND, ABS
Text
FORMAT, CONCATENATE, LEFT, RIGHT
Lookup
LOOKUPVALUE, RELATED, RELATEDTABLE

📝 Livrables
✅ Terminés
5 datasets nettoyés et documentés
12+ mesures DAX fonctionnelles
Dashboard interactif (HTML + visualisations Chart.js)
Documentation Power Query complète
Documentation DAX complète
Conception Row-Level Security
Repository GitHub organisé et professionnel

🔗 Liens Utiles
LinkedIn : linkedin.com/in/khalid-ag-mohamed-aly
Codveda : www.codveda.com
Power BI Docs : learn.microsoft.com/power-bi
DAX Guide : www.dax.guide
Power Query M : learn.microsoft.com/powerquery-m
🏷️ Hashtags
#CodvedaJourney #CodvedaExperience #FutureWithCodveda #PowerBI #DataAnalytics #DAX #PowerQuery #TechForHumanity #RowLevelSecurity #DataVisualization
📧 Contact
Khalid Ag Mohamed Aly
Étudiant en IA et Science Politique
🏛️ Université Centrale de Tunis & African Development University
📧 ## 📧 Contact
**Khalid Ag Mohamed Aly**  
📧 alansarymohamed38@gmail.com  
🔗 [GitHub](https://github.com/khalidagmohamedaly) | [LinkedIn](https://linkedin.com/in/khalid-ag-mohamed-aly)
📄 License
Distribué sous la licence MIT. Voir LICENSE pour plus d'informations.
⚡ Projet développé dans le cadre de l'internship Codveda Technologies — Mars 2026
🎓 Université Centrale de Tunis & African Development University
💡 Tech for Humanity — Empowering Africa through Innovation
🙏 Remerciements
Un grand merci à Codveda Technologies pour cet accompagnement de qualité et cette opportunité d'apprentissage.
Merci à l'équipe pédagogique de l'Université Centrale de Tunis pour leur soutien.
<div align="center">

⭐ Si ce projet vous a plu, n'hésitez pas à mettre une étoile sur GitHub !
Made with ❤️ by Khalid Ag Mohamed Aly
</div>
```
