# app.rb

require "bundler"
Bundler.require

# Ajoute le dossier lib au LOAD_PATH pour pouvoir faire require "app/scrapper"
$:.unshift File.expand_path("./lib", __dir__)
require "app/scrapper"

def display_menu
  puts "================================="
  puts "  VALDOISE EMAIL SCRAPPER"
  puts "================================="
  puts "Que veux-tu faire ?"
  puts "1 - Scraper et sauvegarder en JSON"
  puts "2 - Scraper et sauvegarder en CSV"
  puts "3 - Scraper et sauvegarder en Google Spreadsheet"
  puts "4 - Scraper et sauvegarder dans les trois formats"
  puts "q - Quitter"
  print "> "
end

loop do
  display_menu
  choice = STDIN.gets&.chomp

  break if choice == "q"

  case choice
  when "1", "2", "3", "4"
    scrapper = Scrapper.new
    data = scrapper.perform # Hash { "VILLE" => "email" }

    case choice
    when "1"
      scrapper.save_as_json(data)

    when "2"
      scrapper.save_as_csv(data)

    when "3"
      begin
        scrapper.save_as_spreadsheet(data)
      rescue ArgumentError => e
        puts "❌ Impossible d'enregistrer sur Google Spreadsheet : #{e.message}"
        puts "   Vérifie le fichier config/client_secret.json et ta config Google API."
      rescue StandardError => e
        puts "❌ Erreur inattendue lors de la sauvegarde Spreadsheet : #{e.message}"
      end

    when "4"
      scrapper.save_as_json(data)
      scrapper.save_as_csv(data)

      begin
        scrapper.save_as_spreadsheet(data)
      rescue ArgumentError => e
        puts "❌ Impossible d'enregistrer sur Google Spreadsheet : #{e.message}"
        puts "   Vérifie le fichier config/client_secret.json et ta config Google API."
      rescue StandardError => e
        puts "❌ Erreur inattendue lors de la sauvegarde Spreadsheet : #{e.message}"
      end
    end

    puts "\n✅ Action terminée.\n\n"
  else
    puts "\nChoix invalide, recommence.\n\n"
  end
end

puts "👋 Fin du programme."
