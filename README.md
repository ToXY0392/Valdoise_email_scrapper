📌 Valdoise Email Scrapper

Scraper les adresses email des mairies du Val-d’Oise et les sauvegarder dans différents formats (JSON, CSV, Google Spreadsheet).

📚 Objectif du projet

Ce programme récupère automatiquement les emails des mairies du Val-d’Oise depuis l’annuaire en ligne, puis les enregistre dans trois formats :

JSON → db/emails.json

CSV → db/emails.csv

Google Spreadsheet → via l’API Google Drive / Sheets

Le projet est intégralement développé en POO (Programmation Orientée Objet), avec une structure propre et modulaire.

🏛 Structure du projet
valdoise_email_scrapper
├── app.rb
├── Gemfile
├── Gemfile.lock
├── .gitignore
├── config
│   └── client_secret.json      # (non versionné)
├── db
│   ├── emails.json
│   ├── emails.csv
│   └── emails_spreadsheet_id.txt
├── lib
│   └── app
│       └── scrapper.rb
├── spec
│   ├── scrapper_spec.rb
│   └── spec_helper.rb
└── .rspec

⚙️ Installation
1️⃣ Installer les dépendances Ruby
bundle install

2️⃣ Installer les gems nécessaires (déjà dans le Gemfile)

nokogiri

open-uri

json

csv

google_drive

🔑 Configuration Google API (Spreadsheet)

Aller sur : https://console.cloud.google.com

Créer un projet

Activer les API suivantes :

Google Drive API

Google Sheets API

Créer des identifiants :
ID Client OAuth 2.0 (Application de bureau)

Télécharger le fichier et le renommer :

config/client_secret.json


Lors de la première exécution avec l’option Spreadsheet, l’application affichera une URL d’autorisation Google.
Ouvrir le lien → accepter → copier le code → le coller dans le terminal.

Le scrapper enregistrera ensuite l’ID du spreadsheet dans :

db/emails_spreadsheet_id.txt

▶️ Utilisation

Lancer l’application :

ruby app.rb


Un menu apparaît :

1 - Scraper et sauvegarder en JSON
2 - Scraper et sauvegarder en CSV
3 - Scraper et sauvegarder en Google Spreadsheet
4 - Scraper et sauvegarder dans les trois formats
q - Quitter

🧠 Fonctionnement du Scrapper

La classe Scrapper se charge de :

📌 1. Scraper les mairies

Télécharge la page du Val-d’Oise

Récupère les liens de chaque mairie

Scrape chaque page individuelle

Extrait l’adresse email (ou renvoie email_non_trouve)

📌 2. Sauvegarder les données

Méthodes disponibles :

save_as_json(hash)
save_as_csv(hash)
save_as_spreadsheet(hash)


Toutes les sauvegardes se font dans le dossier db.

🧪 Tests (RSpec)

Pour lancer les tests :

rspec


Les tests couvrent :

l’extraction d’email

le format du hash retourné

la cohérence du scrapping

❗ Problèmes fréquents & solutions
❌ client_id or client_secret is missing

→ Le fichier config/client_secret.json n’est pas présent ou mal nommé.

❌ storageQuotaExceeded

→ Votre Google Drive est plein. Vider ou changer de compte.

❌ PERMISSION_DENIED: Drive API has not been used

→ Attendre quelques minutes après activation des API dans Google Cloud.

✔️ Conclusion

Ce projet met en pratique :

Scraping web en Ruby avec Nokogiri

POO propre et structurée

Manipulation de JSON & CSV

Intégration de l’API Google Drive/Sheets

Organisation d’un projet Ruby complet

Si tu veux une version anglaise, une version “projet THP” format PDF, ou une version

fais le readme sans la structure

Voici ton README.md propre, concis, sans la structure du dossier, parfait pour un rendu THP.
Tu peux le copier tel quel.

📌 Valdoise Email Scrapper

Scraper les adresses email des mairies du Val-d’Oise et les sauvegarder dans différents formats (JSON, CSV, Google Spreadsheet).

🎯 Objectif du projet

Ce programme récupère automatiquement toutes les adresses email des mairies du Val-d’Oise depuis l’annuaire public, puis enregistre les données dans :

JSON → db/emails.json

CSV → db/emails.csv

Google Spreadsheet → créé ou mis à jour automatiquement

Le projet est entièrement codé en POO et sert d’application pratique pour manipuler des fichiers et automatiser la sauvegarde de données.

⚙️ Installation
1️⃣ Installer les dépendances Ruby
bundle install


Les gems utilisées sont :
nokogiri, open-uri, json, csv, google_drive.

🔑 Configuration Google API (Spreadsheet)

Pour utiliser l’enregistrement dans Google Spreadsheet :

Aller sur https://console.cloud.google.com

Créer un projet (ou utiliser un existant)

Activer :

Google Drive API

Google Sheets API

Créer un identifiant OAuth 2.0 – Application de bureau

Télécharger le fichier JSON et le placer dans :

config/client_secret.json


Lors de la première sauvegarde Spreadsheet, une URL s’affichera dans le terminal :
→ ouvrir le lien, accepter l’accès
→ récupérer le code
→ le coller dans le terminal

L’ID du fichier Google Sheet sera ensuite enregistré automatiquement.

▶️ Utilisation

Lancer l’application :

ruby app.rb


Un menu interactif apparaît :

1 - Scraper et sauvegarder en JSON
2 - Scraper et sauvegarder en CSV
3 - Scraper et sauvegarder en Google Spreadsheet
4 - Scraper et sauvegarder dans les trois formats
q - Quitter


Le scrapping extrait :

le nom de chaque ville

l’adresse email de la mairie

ou "email_non_trouve" en cas d’absence

ou "email_erreur" en cas d’exception

🧪 Tests (RSpec)

Lancer les tests :

rspec


Les tests vérifient principalement :

le format des données retournées

la méthode de scrapping email

la cohérence du hash final

❗ Problèmes fréquents & solutions
❌ client_id or client_secret is missing

→ Mauvais fichier dans config/
→ Mauvais nom
→ Mauvais format JSON

❌ PERMISSION_DENIED: Drive API has not been used

→ Attendre ~2 minutes après activation des API Google

❌ storageQuotaExceeded

→ Le Drive est plein

❌ invalid_client

→ L’ID client OAuth ne correspond pas au bon projet

✔️ Conclusion

Ce projet met en pratique :

Le scraping web avec Nokogiri

L’écriture de fichiers JSON et CSV

La manipulation de Google Sheets via l’API

Une structure Ruby propre et orientée objet

Les bonnes pratiques de séparation du code

Projet parfait pour s’entraîner à manipuler des données et automatiser des tâches en Ruby.