module GameStats

  #Highest sum of the winning and losing teams’ scores
  def highest_total_score
    scores = creator.games_hash.values.map do |game|
      game.home_goals + game.away_goals
    end
    scores.max
  end

  #Lowest sum of the winning and losing teams’ scores
  def lowest_total_score
    scores = creator.games_hash.values.map do |game|
      game.home_goals + game.away_goals
    end
    scores.min
  end

  #Percentage of games that a home team has won (rounded to the nearest 100th)
  def percentage_home_wins
   home_winners = creator.games_hash.values.find_all do |games|
        games.home_team_stat.result == "WIN"
    end
    (home_winners.count.to_f / creator.games_hash.count).round(2)
  end

  #Percentage of games that a visitor has won (rounded to the nearest 100th)
  def percentage_visitor_wins
    visitor_winners = creator.games_hash.values.find_all do |games|
         games.away_team_stat.result == "WIN"
    end
    (visitor_winners.count.to_f / creator.games_hash.count).round(2)
  end

  #	Percentage of games that has resulted in a tie (rounded to the nearest 100th)
  def percentage_ties
    ties = creator.stats_hash.values.find_all do |games|
      games.result == "TIE"
    end
    ((ties.count.to_f / creator.games_hash.count) / 2).round(2)
  end

  #A hash with season names (e.g. 20122013) as keys and counts of games as values
  def count_of_games_by_season #this one
    games_by_season = {}
    creator.seasons_hash.each do |season, games|
      games_by_season[season] = games.count.to_f.round(2)
    end
    games_by_season
  end

  #Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)
  def average_goals_per_game
    scores = creator.games_hash.values.map do |game|
      game.home_goals + game.away_goals
    end
    (scores.sum.to_f / creator.games_hash.count).round(2)
  end

  #Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys
  #and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)
  def average_goals_by_season
    seasons_goals = {}
    creator.seasons_hash.each do |season, games|
      games.each do |game|
        seasons_goals[season] ||= []
        seasons_goals[season] << game.home_goals + game.away_goals
      end
    end
    seasons_goals.transform_values! {|v| (v.sum / v.count.to_f).round(2)}
  end
end

