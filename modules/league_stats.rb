module LeagueStats

  def count_of_teams
    creator.teams_hash.count
  end

  def best_offense
    best_team_id = creator.total_goals_by_team_hash.max_by do |_,goals|
      goals.flatten.sum.to_f / goals.flatten.length
    end
    creator.teams_hash[best_team_id.first.to_s].team_name
  end

  def worst_offense
    worst_team_id = creator.total_goals_by_team_hash.min_by do |_,goals|
      goals.flatten.sum.to_f / goals.flatten.length
    end
    creator.teams_hash[worst_team_id.first.to_s].team_name
  end

  def highest_scoring_visitor
    best_team_id = creator.total_goals_by_team_hash.max_by do |_,goals|
      goals[0].sum.to_f / goals[0].length
    end
    creator.teams_hash[best_team_id.first.to_s].team_name
  end

  def highest_scoring_home_team
    best_team_id = creator.total_goals_by_team_hash.max_by do |_,goals|
      goals[1].sum.to_f / goals[1].length
    end
    creator.teams_hash[best_team_id.first.to_s].team_name
  end

  def lowest_scoring_visitor
    worst_team_id = creator.total_goals_by_team_hash.min_by do |_,goals|
      goals[0].sum.to_f / goals[0].length
    end
    creator.teams_hash[worst_team_id.first.to_s].team_name
  end

  def lowest_scoring_home_team
    worst_team_id = creator.total_goals_by_team_hash.min_by do |_,goals|
      goals[1].sum.to_f / goals[1].length
    end
    creator.teams_hash[worst_team_id.first.to_s].team_name
  end
end