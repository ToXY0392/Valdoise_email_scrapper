# lib/app/scrapper.rb

require "open-uri"
require "nokogiri"
require "json"
require "csv"
require "google_drive"

class Scrapper
  VAL_DOISE_URL = "https://www.annuaire-des-mairies.com/val-d-oise.html"
  DB_FOLDER     = "db"
  JSON_PATH     = File.join(DB_FOLDER, "emails.json")
  CSV_PATH      = File.join(DB_FOLDER, "emails.csv")

  SPREADSHEET_TITLE = "emails_valdoise"

  def initialize
    @cities = {}
  end

  def perform
    create_db_folder_if_needed
    scrap_val_doise
    @cities
  end

  # ===========================
  # SCRAPPING
  # ===========================

  def scrap_val_doise
    puts "📡 Scrapping des mairies du Val-d'Oise..."
    doc = Nokogiri::HTML(URI.open(VAL_DOISE_URL))

    links = doc.css("a.lientxt")

    links.each do |link|
      city = link.text.strip.upcase
      relative = link["href"]
      city_url = build_full_url(relative)

      email = scrap_email(city_url)

      @cities[city] = email
      puts "✔ #{city} → #{email}"
    end

    puts "➡️ Scrapping terminé : #{@cities.length} mairies."
  end

  def build_full_url(relative)
    if relative.start_with?("./")
      base = File.dirname(VAL_DOISE_URL)
      "#{base}/#{relative[2..]}"
    else
      URI.join(VAL_DOISE_URL, relative).to_s
    end
  end

  def scrap_email(url)
    page = Nokogiri::HTML(URI.open(url))
    email = page.xpath('//td[contains(text(), "@")]').text.strip
    return "email_non_trouve" if email.empty?
    email
  rescue
    "email_erreur"
  end

  # ===========================
  # SAVE JSON
  # ===========================

  def save_as_json(hash)
    File.open(JSON_PATH, "w") do |file|
      file.write(JSON.pretty_generate(hash))
    end
    puts "💾 JSON sauvegardé → #{JSON_PATH}"
  end

  # ===========================
  # SAVE CSV
  # ===========================

  def save_as_csv(hash)
    CSV.open(CSV_PATH, "wb") do |csv|
      csv << ["City", "Email"]
      hash.each { |city, email| csv << [city, email] }
    end
    puts "💾 CSV sauvegardé → #{CSV_PATH}"
  end

  # ===========================
  # GOOGLE SPREADSHEET
  # ===========================

  def save_as_spreadsheet(hash)
    session = GoogleDrive::Session.from_config("config/client_secret.json")

    sheet = session.spreadsheet_by_title(SPREADSHEET_TITLE)
    sheet ||= session.create_spreadsheet(SPREADSHEET_TITLE)

    ws = sheet.worksheets[0]

    # reset
    ws.delete_rows(1, ws.num_rows) if ws.num_rows > 0

    ws[1, 1] = "City"
    ws[1, 2] = "Email"

    row = 2
    hash.each do |city, email|
      ws[row, 1] = city
      ws[row, 2] = email
      row += 1
    end

    ws.save
    puts "💾 Spreadsheet mis à jour : #{SPREADSHEET_TITLE}"
  end

  private

  def create_db_folder_if_needed
    Dir.mkdir(DB_FOLDER) unless Dir.exist?(DB_FOLDER)
  end
end
gem "logger"   # optionnel mais ça enlèvera aussi le warning logger