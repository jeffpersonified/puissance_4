require 'sqlite3'

module DB

  def self.db(filename = 'development.db')
    SQLite3::Database.new(filename)
  end

  def self.create(filename = "development.db")
    filename = File.expand_path(filename, '../db/')

    unless File.exists?(filename)
      system("touch #{filename}")
    end
  end

  def self.purge_data(filename = "development.db")
    db(filename).execute("DELETE FROM players")
  end

  def self.load_schema(opts = {})
    # puts %x[pwd]
    database = opts.fetch(:database) { '../db/development.db' }
    # p database
    schema = opts.fetch(:schema) { '../db/players.sql'}
    # p schema
    system("cat #{schema} | sqlite3 #{database}")
  end


end