module LeagueStats
  # Returns total number of teams in the data
  def count_of_teams
    creator.teams_hash.count
  end
  
  # Name of the team with the highest average number of goals scored per game across all seasons
  def best_offense
    best_team_id = creator.total_goals_by_team_hash.max_by do |_,goals|
      goals.flatten.sum.to_f / goals.flatten.length
    end
    creator.teams_hash[best_team_id.first.to_s].team_name
  end
  
  # Name of the team with the lowest average number of goals scored per game across all seasons
  def worst_offense
    worst_team_id = creator.total_goals_by_team_hash.min_by do |_,goals|
      goals.flatten.sum.to_f / goals.flatten.length
    end
    creator.teams_hash[worst_team_id.first.to_s].team_name
  end

  # Name of the team with the highest average score per game across all seasons when they are away
  def highest_scoring_visitor
    best_team_id = creator.total_goals_by_team_hash.max_by do |_,goals|
      goals[0].sum.to_f / goals[0].length
    end
    creator.teams_hash[best_team_id.first.to_s].team_name
  end

  # Name of the team with the highest average score per game across all seasons when they are home
  def highest_scoring_home_team
    best_team_id = creator.total_goals_by_team_hash.max_by do |_,goals|
      goals[1].sum.to_f / goals[1].length
    end
    creator.teams_hash[best_team_id.first.to_s].team_name
  end

  # Name of the team with the lowest average score per game across all seasons when they are a visitor
  def lowest_scoring_visitor
    worst_team_id = creator.total_goals_by_team_hash.min_by do |_,goals|
      goals[0].sum.to_f / goals[0].length
    end
    creator.teams_hash[worst_team_id.first.to_s].team_name
  end

  # Name of the team with the lowest average score per game across all seasons when they are at home
  def lowest_scoring_home_team
    worst_team_id = creator.total_goals_by_team_hash.min_by do |_,goals|
      goals[1].sum.to_f / goals[1].length
    end
    creator.teams_hash[worst_team_id.first.to_s].team_name
  end
end