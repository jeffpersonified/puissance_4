require 'simplecov'
SimpleCov.start

require 'sqlite3'
require_relative '../lib/db'

describe DB do
  DB_FILE = '../db/test.db'

  before(:all) do
    DB.create(DB_FILE)
    DB.load_schema(:database => DB_FILE)
  end

  after(:all) do
    DB.purge_data(DB_FILE)
  end

  context "#update_player" do

    it "saves a new record to the database when a user name doesn't exist" do
      expect { DB.update_player('random_user') }.to change( DB.row_count('players')).by(1)
    end

  end


end