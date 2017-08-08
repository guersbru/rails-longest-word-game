require 'open-uri'
require 'json'

def generate_grid(grid_size)
  # TODO: generate random grid of letters
  grid = []
  grid_size.times { grid << rand(65..(65+25)).chr }
  grid
end

def run_game(attempt, grid, start_time, end_time)
  # TODO: runs the game and return detailed hash of result
  attempt = attempt.upcase
  url = "https://wagon-dictionary.herokuapp.com/#{attempt.downcase}"
  check_word = open(url).read
  parse_word = JSON.parse(check_word)
  if test_grid(attempt, grid)
    if parse_word["found"]
      {
        time: end_time - start_time,
        score: attempt.length * 10 - (end_time - start_time),
        translate: "chariot",
        message: "well done"
      }
    else
      {
        score: 0,
        time: end_time - start_time,
        message: "not an english word",
        translate: "chariot"
        }
    end
  else parse_word
    {
      score: 0,
      time: end_time - start_time,
      message: "not in the grid",
      translate: "chariot"
    }

  end
end

def test_grid(attempt, grid)
  validation = true
  attempt.upcase.split(//).each do |x|
    if grid.include?(x)
      grid.delete(x)
      validation = true
    else
      validation = false
    end
  end
  validation
end

# p test_grid("wagon", %w(W G G Z O N A L))
# p test_grid("wagon", %w(W A))
# p run_game("train", %w(W G G Z O N A L))
# p test_grid("train", %w(W G G Z O N A L))
# p run_game("wagon", %w(W G G Z O N A L), Time.now, Time.now + 1.0)
# p run_game("law", %w(W G G Z O N A L), Time.now, Time.now + 1.0)
# p run_game("law", %w(W G G Z O N A L), Time.now, Time.now + 10.0)
# p run_game("zon", %w(W G G Z O N A L), Time.now, Time.now + 1.0)

# test_grid(["b", "o", "y"], "boy")

# result = run_game("wagon", ["w", "a", "g", "o", "n"], 30, 22)
# p result
