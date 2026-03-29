# ✍️ Brouillons de Posts LinkedIn — Internship Codveda

---

## POST PRINCIPAL (Publication après soumission)

---

🚀 **Internship Accompli : Power BI Data Analytics @ Codveda Technologies**

Je suis fier de partager la finalisation de mon projet d'internship avec @Codveda — un pipeline complet d'analyse de données développé avec Power BI Desktop.

**📊 Ce que j'ai accompli :**

✅ Nettoyage et transformation de **5 datasets hétérogènes** via Power Query (M)
✅ Résolution d'un problème critique : regroupement de **150+ labels de sentiment** en 3 macro-catégories cohérentes
✅ Création de **12+ mesures DAX** pour l'analyse prédictive (churn, sentiment, pricing immobilier)
✅ Identification d'un insight clé : **42% de churn chez les clients avec International Plan** — soit 3,8× le taux standard
✅ Architecture Star Schema avec relations Many-to-One et intelligence temporelle (YTD, MTD, MoM)
✅ Documentation complète sur GitHub avec code M et DAX production-ready

**🔧 Stack technique :**
• Power BI Desktop + Power Query (M Language)
• DAX : DIVIDE · CALCULATE · FILTER · RANKX · SWITCH · LOOKUPVALUE · VAR
• 5 datasets : Churn Télécom · Sentiment Social Media · Iris · Boston Housing
• GitHub pour versioning et portfolio

**💡 L'insight qui m'a le plus marqué :**
En analysant le dataset Churn (3 333 clients), j'ai découvert que les abonnés avec un International Plan churnent à **42% contre 11%** pour les autres. Un seul feature explique une part majeure du churn — c'est exactement ce que la data analysis permet de révéler pour orienter des décisions business concrètes.

**🌍 Pourquoi ça compte :**
Maîtriser ces compétences, c'est pouvoir demain analyser des données de santé publique au Sahel, évaluer l'impact de politiques climatiques, ou aider des startups africaines à passer de l'intuition à la décision data-driven.

🔗 **Repository GitHub** : [Ajouter le lien]
🎥 **Vidéo démo** : [Ajouter le lien]

Un grand merci à l'équipe Codveda pour cet encadrement de qualité ! 🙏

---

#CodvedaJourney #CodvedaExperience #FutureWithCodveda #PowerBI #DAX #PowerQuery #DataAnalytics #AfricanTech #TechForHumanity #DataScience #BusinessIntelligence

---

## POST ALTERNATIF (Ton plus technique, pour réseau data)

---

🔍 **Ce que j'ai appris en nettoyant 4 763 lignes de données réelles**

Dans le cadre de mon internship @Codveda, j'ai confronté 3 problèmes data "classiques" qui ne le sont pas tant que ça :

**Problème 1 : 150+ labels de sentiment incohérents**
Dataset Social Media · 732 posts · "Positive", "Joy", "Happiness", "Happy"... tous overlapping.
Solution : Colonne conditionnelle Power Query M → 3 macro-catégories propres en 20 lignes de code.

**Problème 2 : Dataset sans en-têtes**
Boston Housing · 505 lignes · 14 colonnes nommées Column1 à Column14.
Solution : Renommage manuel en Power Query + documentation dans housing_column_names.txt.

**Problème 3 : Churn split 80/20 dans deux fichiers séparés**
Churn BigML · 2 666 + 667 lignes à fusionner.
Solution : Table.Combine() en M — 3 lignes de code, 3 333 lignes unifiées.

**Le plus intéressant ?**
Après nettoyage, la mesure DAX `CALCULATE([Churn Rate %], Churn[International plan]="Yes")` a révélé 42% de churn sur ce segment vs 11% global. Le feature le plus prédictif était visible... dans les données propres.

Code disponible sur GitHub → [lien]

---

#PowerBI #PowerQuery #DAX #DataCleaning #ETL #CodvedaJourney

---

## POST COURT (Partage de milestone)

---

📊 Dashboard Power BI complété — Internship @Codveda ✅

5 datasets · 4 763 enregistrements · 12 mesures DAX · Un insight qui change tout : 42% de churn sur les clients International Plan (3.8× la normale).

Tout le code est sur GitHub. Lien en commentaires 👇

#CodvedaJourney #PowerBI #DataAnalytics
