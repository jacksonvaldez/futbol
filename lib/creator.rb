require_relative './tg_stat'
require_relative './game'
require_relative './team'

class Creator
  attr_reader :teams_hash, :seasons_hash, :stats_hash, :games_hash, :total_goals_by_team_hash

  # Saves the attributes created by Creator#create_object
  def initialize(teams_hash, seasons_hash, stats_hash, games_hash, total_goals_by_team_hash)
    @teams_hash = teams_hash
    @seasons_hash = seasons_hash
    @stats_hash = stats_hash
    @games_hash = games_hash
    @total_goals_by_team_hash = total_goals_by_team_hash
  end

  # Creates all objects and hashes utilized by the StatTracker methods
  def self.create_objects(game_data, team_data, game_team_data)
    stats_hash = self.stat_obj_creator(game_team_data)
    games_hash = self.game_obj_creator(game_data, stats_hash)
    seasons_hash = self.season_obj_creator(games_hash)
    teams_hash = self.team_obj_creator(team_data, games_hash)
    total_goals_by_team_hash = self.total_goals_by_team(games_hash)

    self.new(teams_hash, seasons_hash, stats_hash, games_hash, total_goals_by_team_hash)
  end

  # Creates the team game (tg) stat objects from the game_team CSV. Saves all objects to a hash
  def self.stat_obj_creator(game_team_data)
    stats_hash = {}
    game_team_data.each do |stat|
      stat_name = "#{stat[:game_id] + '_' + stat[:team_id]}"
      stats_hash[stat_name] = TGStat.new(stat)
    end
    stats_hash
  end
  
  # Creates the game objects from the game CSV and includes both stat objects for the specific game. Saves all objects to a hash
  def self.game_obj_creator(game_data, stats_hash)
    games_hash = {}
    game_data.each do |game|
      home_team = "#{game[:game_id] + '_' + game[:home_team_id]}"
      away_team = "#{game[:game_id] + '_' + game[:away_team_id]}"
      games_hash[game[:game_id]] = Game.new(game, stats_hash[home_team], stats_hash[away_team])
    end
    games_hash
  end
  
  # Saves all game objects sorted by season as a hash
  def self.season_obj_creator(games_hash)
    seasons_hash = games_hash.values.group_by do |game|
      game.season
    end
  end
  
  # Creates the team objects from the team CSV and includes both game, and stat objects for the specific team. Saves all objects to a hash
  def self.team_obj_creator(team_data, games_hash)
    teams_hash = {}
    team_data.each do |team|
      team_games = games_hash.values.find_all do |game|
        (game.home_team_id == team[:team_id]) || (game.away_team_id == team[:team_id])
      end
      teams_hash[team[:team_id]] = Team.new(team, team_games)
    end
    teams_hash
  end

  # Saves all teams as keys, and their goals away and home as values in a hash.
  def self.total_goals_by_team(games_hash)
    hash = {}
    games_hash.each_value do |game|
      hash[game.away_team_id.to_sym] ||= [[],[]]
      hash[game.home_team_id.to_sym] ||= [[],[]]
      hash[game.away_team_id.to_sym][0] << game.away_goals
      hash[game.home_team_id.to_sym][1] << game.home_goals
    end
    hash
  end
end
