# 📌 Valdoise Email Scrapper

A Ruby application that scrapes email addresses from all city halls in the Val-d’Oise region and saves them in multiple formats (JSON, CSV, Google Spreadsheet).

## 🎯 Project Goal

This project automatically extracts the email addresses of all Val-d’Oise town halls from a public online directory, then saves the collected data in:

JSON → db/emails.json

CSV → db/emails.csv

Google Spreadsheet → created or updated via Google APIs

The entire project is written using Object-Oriented Programming (OOP) and demonstrates how to scrape data and persist it in different storage formats.

## ⚙️ Installation
### 1️⃣ Install Ruby dependencies
```ruby
bundle install
```

Main gems used:
nokogiri, open-uri, json, csv, google_drive.

### 🔑 Google API Configuration (Spreadsheet Export)

To enable Google Spreadsheet saving, you must configure the Google Drive & Sheets APIs:

Go to https://console.cloud.google.com

Create or select a project

Enable:

Google Drive API

Google Sheets API

Create an OAuth 2.0 Client ID – Desktop App

Download the JSON credentials file and place it here:

config/client_secret.json


When saving to a Spreadsheet for the first time, the program will display an authorization URL.
Open it, grant access, copy the authorization code, and paste it back into the terminal.

The spreadsheet ID will then be saved automatically for future use.

### ▶️ Usage

Run the program:
```ruby
ruby app.rb
```

You will be presented with an interactive menu:

1 - Scrape and save as JSON
2 - Scrape and save as CSV
3 - Scrape and save as Google Spreadsheet
4 - Save in all formats
q - Quit


The scraper retrieves:

the city name

the city hall’s email address

or "email_not_found" if none is detected

or "email_error" in case of scraping issues

## 🧪 Tests (RSpec)

Run tests with:

rspec


Tests cover:

email extraction

data format consistency

scraper behavior

❗ Common Issues & Fixes
❌ client_id or client_secret is missing

Your client_secret.json is missing or incorrectly placed.

❌ PERMISSION_DENIED: Drive API has not been used

Wait a few minutes after enabling the API in Google Cloud.

❌ storageQuotaExceeded

Your Google Drive account is full.

❌ invalid_client

Credentials do not match the Google Cloud project you configured.

### ✔️ Conclusion

This project demonstrates:

Web scraping with Nokogiri

Writing and handling JSON and CSV files

Working with Google Drive & Sheets APIs

Structuring a Ruby project with OOP best practices

Automating data collection and storage

A great exercise to strengthen your Ruby, scraping, and file management skills.