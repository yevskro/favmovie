@u1 = User.create(name: "admin", password: "1234567", email: "dur@hotmail.com", role: :admin)
@u2 = User.create(name: "root", password: "1234567", email: "root@root.com", role: :user)

@u1.movies.create(name: "Casanova", year: 2005, ww_gross: "$36,204,403", rt_rating: 44, genres_names: ["Comedy"])
@u1.movies.create(name: "The Godfather", year: 1972, ww_gross: "$268,500,000", rt_rating: 99, genres_names: ["Drama"])
@u2.movies.create(name: "There's Something About Mary", year: 1998, ww_gross: "$360,099,999", rt_rating: 83, genres_names: ["Comedy"])

@u1.movies.first.directors.create(name: "Lasse Hallström", birth_date: "June 2, 1946", birth_place: "Stockholm, Stockholms län, Sweden")   # casanova
@u1.movies.last.directors.create(name: "Francis Ford Coppola", birth_date: "April 7, 1939", birth_place: "Detroit, Michigan, USA")        # the godfather
@u2.movies.first.directors.create(name: "Bobby Farrelly", birth_date: "June 17, 1958", birth_place: "Cumberland, Rhode Island, USA")       # theres something about mary
@u2.movies.first.directors.create(name: "Peter Farrelly", birth_date: "December 17, 1956", birth_place: "Phoenixville, Pennsylvania, USA") # theres something about mary

@u1.movies.first.screenwriters.create(name: "Jeffrey Hatcher", birth_date: "Unknown", birth_place: "Unknown") #casanova
@u1.movies.first.screenwriters.create(name: "Kimberly Simi", birth_date: "Unknown", birth_place: "Unknown")   #casanova
@u1.movies.last.screenwriters.create(name: "Mario Puzo", birth_date: "October 15, 1920", birth_place: "Manhattan, New York City, New York, USA") # the godfather
@u1.movies.last.screenwriters.create(name: "Francis Ford Coppola", birth_date: "April 7, 1939", birth_place: "Detroit, Michigan, USA")           # the godfather
@u2.movies.first.screenwriters.create(name: "Bobby Farrelly", birth_date: "June 17, 1958", birth_place: "Cumberland, Rhode Island, USA")       # theres something about mary
@u2.movies.first.screenwriters.create(name: "Peter Farrelly", birth_date: "December 17, 1956", birth_place: "Phoenixville, Pennsylvania, USA") # theres something about mary
@u2.movies.first.screenwriters.create(name: "Ed Decter", birth_date: "? ?, 1959", birth_place: "Unknown")                   #theres something about mary
@u2.movies.first.screenwriters.create(name: "John J. Strauss", birth_date: "? ?, 1957", birth_place: "Unknown")             #theres something about mary

# --- casanova ---
@u1.movies.first.actors.create(name: "Heath Ledger", birth_date: "April 4, 1979", birth_place: "Perth, Western Australia, Australia")
@u1.movies.first.actors.create(name: "Sienna Miller", birth_date: " December 28, 1981", birth_place: "New York City, New York, USA")
@u1.movies.first.actors.create(name: "Jeremy Irons", birth_date: "September 19, 1948", birth_place: "Cowes, Isle of Wight, England, UK")
@u1.movies.first.actors.create(name: "Oliver Platt", birth_date: "January 12, 1960", birth_place: "Windsor, Ontario, Canada")
# ----------------
# --- the godfather ---
@u1.movies.last.actors.create(name: "Marlon Brando", birth_date: "April 3, 1924", birth_place: "Omaha, Nebraska, USA")
@u1.movies.last.actors.create(name: "Al Pacino", birth_date: "April 25, 1940", birth_place: "Manhattan, New York City, New York, USA")
@u1.movies.last.actors.create(name: "James Caan", birth_date: "March 26, 1940", birth_place: "The Bronx, New York, USA")
@u1.movies.last.actors.create(name: "Robert Duvall", birth_date: "January 5, 1931", birth_place: "San Diego, California, USA")
@u1.movies.last.actors.create(name: "Diane Keaton", birth_date: "January 5, 1946", birth_place: "Los Angeles, California, USA")
@u1.movies.last.actors.create(name: "Talia Shire", birth_date: "April 25, 1946", birth_place: "Lake Success, Long Island, New York, USA")
# ---------------------
# --- there's something about mary ---
@u2.movies.first.actors.create(name: "Cameron Diaz", birth_date: "August 30, 1972", birth_place: "San Diego, California, USA")
@u2.movies.first.actors.create(name: "Matt Dillon", birth_date: "February 18, 1964", birth_place: "New Rochelle, New York, USA")
@u2.movies.first.actors.create(name: "Ben Stiller", birth_date: "November 30, 1965", birth_place: "New York City, New York, USA")
@u2.movies.first.actors.create(name: "Lee Evans", birth_date: "February 25, 1964", birth_place: "Avonmouth, Bristol, England, UK")
@u2.movies.first.actors.create(name: "Chris Elliott", birth_date: "May 31, 1960", birth_place: "New York City, New York, USA")
# ------------------------------------
# --- genres ---
Genre.create(name: "Horror")
Genre.create(name: "Fantasy")
Genre.create(name: "Action")
Genre.create(name: "Suspense")
# --------------
