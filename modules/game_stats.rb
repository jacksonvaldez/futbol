module GameStats

  def highest_total_score
    scores = creator.games_hash.values.map do |game|
      game.home_goals + game.away_goals
    end
    scores.max
  end

  def lowest_total_score
    scores = creator.games_hash.values.map do |game|
      game.home_goals + game.away_goals
    end
    scores.min
  end

  def percentage_home_wins
   home_winners = creator.games_hash.values.find_all do |games|
        games.home_team_stat.result == "WIN"
    end
    (home_winners.count.to_f / creator.games_hash.count).round(2)
  end

  def percentage_visitor_wins
    visitor_winners = creator.games_hash.values.find_all do |games|
         games.away_team_stat.result == "WIN"
    end
    (visitor_winners.count.to_f / creator.games_hash.count).round(2)
  end

  def percentage_ties
    ties = creator.stats_hash.values.find_all do |games|
      games.result == "TIE"
    end
    ((ties.count.to_f / creator.games_hash.count) / 2).round(2)
  end

  def count_of_games_by_season #this one
    games_by_season = {}
    creator.seasons_hash.each do |season, games|
      games_by_season[season] = games.count.to_f.round(2)
    end
    games_by_season
  end

  def average_goals_per_game
    scores = creator.games_hash.values.map do |game|
      game.home_goals + game.away_goals
    end
    (scores.sum.to_f / creator.games_hash.count).round(2)
  end

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

