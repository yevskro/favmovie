require 'spec_helper'

RSpec.describe 'movie model_spec', type: :model do
  before do
    User.create(name: "admin", email: "admin@admin.com", password: "adminroot", admin: true)

    Movie.create(name: "Casanova", year: 2005, ww_gross: "$36,204,403", rt_rating: 44)
    Movie.create(name: "The Godfather", year: 1972, ww_gross: "$268,500,000", rt_rating: 99)
    Movie.create(name: "There's Something About Mary", year: 1998, ww_gross: "$360,099,999", rt_rating: 83)

    Director.create(name: "Lasse Hallström", birth_date: "June 2, 1946", birth_place: "Stockholm, Stockholms län, Sweden")   # casanova
    Director.create(name: "Francis Ford Coppola", birth_date: "April 7, 1939", birth_place: "Detroit, Michigan, USA")        # the godfather
    Director.create(name: "Bobby Farrelly", birth_date: "June 17, 1958", birth_place: "Cumberland, Rhode Island, USA")       # theres something about mary
    Director.create(name: "Peter Farrelly", birth_date: "December 17, 1956", birth_place: "Phoenixville, Pennsylvania, USA") # theres something about mary

    Screenwriter.create(name: "Jeffrey Hatcher", birth_date: "Unknown", birth_place: "Unknown") #casanova
    Screenwriter.create(name: "Kimberly Simi", birth_date: "Unknown", birth_place: "Unknown")   #casanova
    Screenwriter.create(name: "Mario Puzo", birth_date: "October 15, 1920", birth_place: "Manhattan, New York City, New York, USA") # the godfather
    Screenwriter.create(name: "Francis Ford Coppola", birth_date: "April 7, 1939", birth_place: "Detroit, Michigan, USA")           # the godfather
    Screenwriter.create(name: "Bobby Farrelly", birth_date: "June 17, 1958", birth_place: "Cumberland, Rhode Island, USA")       # theres something about mary
    Screenwriter.create(name: "Peter Farrelly", birth_date: "December 17, 1956", birth_place: "Phoenixville, Pennsylvania, USA") # theres something about mary
    Screenwriter.create(name: "Ed Decter", birth_date: "? ?, 1959", birth_place: "Unknown")                   #theres something about mary
    Screenwriter.create(name: "John J. Strauss", birth_date: "? ?, 1957", birth_place: "Unknown")             #theres something about mary

    # --- casanova ---
    Actor.create(name: "Heath Ledger", birth_date: "April 4, 1979", birth_place: "Perth, Western Australia, Australia")
    Actor.create(name: "Sienna Miller", birth_date: " December 28, 1981", birth_place: "New York City, New York, USA")
    Actor.create(name: "Jeremy Irons", birth_date: "September 19, 1948", birth_place: "Cowes, Isle of Wight, England, UK")
    Actor.create(name: "Oliver Platt", birth_date: "January 12, 1960", birth_place: "Windsor, Ontario, Canada")
    # ----------------
    # --- the godfather ---
    Actor.create(name: "Marlon Brando", birth_date: "April 3, 1924", birth_place: "Omaha, Nebraska, USA")
    Actor.create(name: "Al Pacino", birth_date: "April 25, 1940", birth_place: "Manhattan, New York City, New York, USA")
    Actor.create(name: "James Caan", birth_date: "March 26, 1940", birth_place: "The Bronx, New York, USA")
    Actor.create(name: "Robert Duvall", birth_date: "January 5, 1931", birth_place: "San Diego, California, USA")
    Actor.create(name: "Diane Keaton", birth_date: "January 5, 1946", birth_place: "Los Angeles, California, USA")
    Actor.create(name: "Talia Shire", birth_date: "April 25, 1946", birth_place: "Lake Success, Long Island, New York, USA")
    # ---------------------
    # --- there's something about mary ---
    Actor.create(name: "Cameron Diaz", birth_date: "August 30, 1972", birth_place: "San Diego, California, USA")
    Actor.create(name: "Matt Dillon", birth_date: "February 18, 1964", birth_place: "New Rochelle, New York, USA")
    Actor.create(name: "Ben Stiller", birth_date: "November 30, 1965", birth_place: "New York City, New York, USA")
    Actor.create(name: "Lee Evans", birth_date: "February 25, 1964", birth_place: "Avonmouth, Bristol, England, UK")
    Actor.create(name: "Chris Elliott", birth_date: "May 31, 1960", birth_place: "New York City, New York, USA")
    # ------------------------------------
    # --- genres ---
    Genre.create(name: "Comedy")
    Genre.create(name: "Horror")
    Genre.create(name: "Fantasy")
    Genre.create(name: "Action")
    Genre.create(name: "Suspense")
    Genre.create(name: "Action")
    Genre.create(name: "Romance")
    # --------------
  end

  it 'movie has a name, year, gross and rating' do
    @m = Movie.all[0]
    expect(@m.name).to eq("Casanova")
    expect(@m.year).to eq(2005)
    expect(@m.ww_gross).to eq("$36,204,403")
    expect(@m.rt_rating).to eq(44)
  end

  it 'actor has a name, birth_date, birth_place' do
    @a = Actor.all[0]
    expect(@a.name).to eq("Heath Ledger")
    expect(@a.birth_date).to eq("April 4, 1979")
    expect(@a.birth_place).to eq("Perth, Western Australia, Australia")
  end

  it 'director has a name, birth_date, birth_place' do
    @d = Director.all[0]
    expect(@d.name).to eq("Lasse Hallström")
    expect(@d.birth_date).to eq("June 2, 1946")
    expect(@d.birth_place).to eq("Stockholm, Stockholms län, Sweden")
  end

  it 'screenwriter has a name, birth_date, birth_place' do
    @s = Screenwriter.all[0]
    expect(@s.name).to eq("Jeffrey Hatcher")
    expect(@s.birth_date).to eq("Unknown")
    expect(@s.birth_place).to eq("Unknown")
  end

  it 'genre has a name' do
    @g = Genre.all[0]
    expect(@g.name).to eq("Comedy")
  end

  it 'movie has many directors' do
    @d = Director.all[0]
    @m = Movie.all[0]
    @m.directors << @d
    expect(@m.directors).to include(@d)
  end

  it 'through movies director has many actors' do
    @a = Actor.all[0]
    @d = Director.all[0]
    @m = Movie.all[0]
    @m.directors << @d
    @m.actors << @a
    expect(@a.directors.first.actors).to include(@a)
  end

  it 'movie has many screenwriters' do
    @m = Movie.all[0]
    @s = Screenwriter.all[0]
    @m.screenwriters << @s
    expect(@m.screenwriters).to include (@s)
  end

  it 'movie has many genres' do
    @m = Movie.all[0]
    @g = Genre.all[0]
    @m.genres << @g
    expect(@m.genres).to include(@g)
  end

  it 'director has many actors through movies' do
    @m = Movie.all[0]
    @d = Director.all[0]
    @a = Actor.all[0]
    @m.directors << @d
    @m.actors << @a
    expect(@d.actors).to include(@a)
  end

  it 'actor has many genres through movies' do
    @m = Movie.all[0]
    @d = Director.all[0]
    @a = Actor.all[0]
    @g = Genre.all[0]
    @m.directors << @d
    @m.genres << @g
    @m.actors << @a
    expect(@a.genres).to include(@g)
  end

  it 'actor has many directors through movies' do    @m = Movie.all[0]
    @d = Director.all[0]
    @a = Actor.all[0]
    @g = Genre.all[0]
    @m.directors << @d
    @m.actors << @a
    expect(@a.directors).to include(@d)
  end

  it 'director has many genres through movies' do
    @m = Movie.all[0]
    @d = Director.all[0]
    @a = Actor.all[0]
    @g = Genre.all[0]
    @m.directors << @d
    @m.genres << @g
    @m.actors << @a
    expect(@d.genres).to include(@g)
  end

  it 'screenwriter has many genres through movies' do
    @m = Movie.all[0]
    @s = Screenwriter.all[0]
    @g = Genre.all[0]
    @m.screenwriters << @s
    @m.genres << @g
    expect(@s.genres).to include(@g)
  end

  it 'genre has many movies' do
    @m = Movie.all[0]
    @g = Genre.all[0]
    @m.genres << @g
    expect(@g.movies).to include(@m)
  end

  it "user has a name and email" do
    @u = User.all[0]
    expect(@u.name).to eq("admin")
    expect(@u.email).to eq("admin@admin.com")
  end

  it "user has movies" do
    @u = User.all[0]
    @m = Movie.all[0]
    @u.movies << @m
    expect(@u.movies).to include(@m)
  end
end
