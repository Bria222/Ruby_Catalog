require_relative './modules/preserver_module'
require './modules/book_module'
require_relative './classes/book'
require_relative './classes/label'
require './modules/game_module'
require_relative './classes/game'

class App
  include PreserverModule
  include BookModule
  include GameModule
  attr_reader :books

  def initialize
    @books = []
    @albums = []
    @authors = []
    @genres = []
    @labels = []
    @sources = []
    @games = []

    load_data
  end

  def start_program
    puts 'Welcome to the catalog app'
    until list_of_options
      input = gets.chomp
      if input == '0'
        preserve_files
        puts 'Thank you for using our app'
        break
      end
      option(input)
    end
  end

  def list_all_books
    puts "\nNote: No Books available." if @books.empty?
    puts "\nALL BOOKS\n\n"
    puts "\nPublisher \t| Publish Date \t| Cover State"
    @books.each do |book|
      puts "#{book['publisher']} \t\t| #{book['publish_date']} \t| #{book['cover_state']}"
      puts "\n-------------------------------------------------"
    end
  end

  def list_all_labels
    puts "\nNote: No Label available." if @labels.empty?
    puts "\nALL LABELS\n\n"
    puts "\nLabels \t| Color"
    @labels.each do |label|
      puts "#{label['title'].strip} \t| #{label['color']}"
      puts "\n----------------------------"
    end
  end

  def list_all_albums
    puts 'No available albums' if @albums.empty?
    @albums.each { |album| puts "genre: #{album.genre}, published on: #{album.publish_date}" }
  end

  def list_all_games
    puts "\nNote: No games available." if @games.empty?

    puts "\nALL GAMES\n\n"
    puts "\Games \t| Multiplayer \t| Last Played At"
    @games.each do |game|
      puts "\t #{game['game_name']} \t#{game['last_played_at']} \t| #{game['multiplayer']}"
      puts "\n-------------------------------------------------"
    end
  end

  def list_all_genres
    puts 'No available genre' if @genres.empty?
    @genres.each { |genre| puts "genre: #{genre.name}" }
  end

  def list_all_authors
    puts "\nNote: No authors available." if @authors.empty?
    puts "\nALL AUTHORS\n\n"
    puts "\First Name \t| Last Name"
    @authors.each do |author|
      puts "#{author['first_name']} \t| #{author['last_name']}"
      puts "\n-------------------------------------------------"
    end
  end

  def add_book(new_book)
    new_book_instance = Book.new(*new_book)
    hash = {
      'publisher' => new_book_instance.publisher,
      'publish_date' => new_book_instance.publish_date,
      'cover_state' => new_book_instance.cover_state
    }
    @books << hash
  end

  def add_label(new_label)
    new_label_instance = Label.new(*new_label)
    hash = {
      'title' => new_label_instance.title,
      'color' => new_label_instance.color
    }
    @labels << hash
  end

  def add_author(new_author)
    new_author_instance = Author.new(*new_author)
    hash = {
      'first_name' => new_author_instance.first_name,
      'last_name' => new_author_instance.last_name
    }
    @authors << hash
  end

  def add_game(new_game)
    new_game_instance = Game.new(*new_game)
    hash = {
      'game_name' => new_game_instance.game_name,
      'last_played_at' => new_game_instance.last_played_at,
      'multiplayer' => new_game_instance.multiplayer
    }
    @games << hash
  end

  def preserve_files
    save_data_as_json(@books, 'books')
    save_data_as_json(@labels, 'labels')
    save_data_as_json(@albums, 'albums')
    save_data_as_json(@genres, 'genres')
    save_data_as_json(@games, 'games')
    save_data_as_json(@authors, 'authors')
  end

  private

  def load_data
    @books = load_file('books')
    @labels = load_file('labels')
    @albums = load_file('albums')
    @genres = load_file('genres')
    @games = load_file('games')
    @authors = load_file('authors')
  end
end
