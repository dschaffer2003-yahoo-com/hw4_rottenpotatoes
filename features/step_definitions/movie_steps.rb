# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title => movie["title"],
        :release_date => movie["release_date"],
        :director => movie["director"],
        :rating => movie["rating"])
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /the director of "(.*)" should be "(.*)"/ do |e1, e2|
  movie = Movie.where("title = '#{e1}' and director = '#{e2}'")
  assert(movie.size() == 1)
end
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert(page.body.index(e1) < page.body.index(e2))
end
Then /I should see the appropriate movies/ do
  Movie.find_all_by_rating(["PG-13", "R"]).each do |x|
    str = 'I should see "' + x.title + '"'
    step str
  end
  Movie.find_all_by_rating(["G", "PG"]).each do |x|
    str = 'I should not see "' + x.title + '"'
    step str
  end

#  Movie.find_all_by_rating(["PG-13", "R"]).each do |x|
#  assert page.has_content?(x.title)
#  end
end

Then /I should see no movies/ do
  Movie.find_all_by_rating(["G", "PG", "PG-13", "R"]).each do |x|
    str = 'I should not see "' + x.title + '"'
    step str
  end
end

Then /I should see all movies/ do
  Movie.find_all_by_rating(["G", "PG", "PG-13", "R"]).each do |x|
    str = 'I should see "' + x.title + '"'
    step str
  end
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(/, */).each do |rating|
    step "I #{uncheck}check \"ratings_#{rating}\""
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end
