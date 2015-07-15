# Load/create our database for this program.
DATABASE = SQLite3::Database.new("commuters.db")
DATABASE.execute("PRAGMA foreign_keys = ON;")

# Make the tables.
DATABASE.execute("CREATE TABLE IF NOT EXISTS cyclists (id INTEGER PRIMARY KEY, user_name TEXT UNIQUE NOT NULL, password TEXT NOT NULL, first_name TEXT NOT NULL, last_name TEXT NOT NULL, nickname TEXT);")

DATABASE.execute("CREATE TABLE IF NOT EXISTS bikes (id INTEGER PRIMARY KEY, cyclist_id INTEGER NOT NULL, bike_name TEXT, description TEXT, FOREIGN KEY (cyclist_id) REFERENCES cyclists(id));")

DATABASE.execute("CREATE TABLE IF NOT EXISTS rides (id INTEGER PRIMARY KEY, cyclist_id INTEGER NOT NULL, bike_id INTEGER NOT NULL, ride_name TEXT, miles DECIMAL (4,1) NOT NULL, period DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (cyclist_id) REFERENCES cyclists(id), FOREIGN KEY (bike_id) REFERENCES bikes(id));")

# Get results as an Array of Hashes.
DATABASE.results_as_hash = true
