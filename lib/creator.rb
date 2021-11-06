# require './tg_stat'
# require './game'
# require './team'
# commented these out, spec still runs
class Creator
  attr_reader :teams_hash, :seasons_hash, :stats_hash, :games_hash

  def initialize(teams_hash, seasons_hash, stats_hash, games_hash)
    @teams_hash = teams_hash
    @seasons_hash = seasons_hash
    @stats_hash = stats_hash
    @games_hash = games_hash
  end

  def self.create_objects(game_data, team_data, game_team_data)
    stats_hash = self.stat_obj_creator(game_team_data)
    games_hash = self.game_obj_creator(game_data, stats_hash)
    seasons_hash = self.season_obj_creator(games_hash)
    teams_hash = self.team_obj_creator(team_data, games_hash)

    self.new(teams_hash, seasons_hash, stats_hash, games_hash)
  end

  def self.stat_obj_creator(game_team_data)
    stats_hash = {}
    game_team_data.each do |stat|
      stat_name = "#{stat[:game_id] + '_' + stat[:team_id]}"
      stats_hash[stat_name] = TGStat.new(stat)
    end
    stats_hash
  end

  def self.game_obj_creator(game_data, stats_hash)
    games_hash = {}
    game_data.each do |game|
      home_team = "#{game[:game_id] + '_' + game[:home_team_id]}"
      away_team = "#{game[:game_id] + '_' + game[:away_team_id]}"
      games_hash[game[:game_id]] = Game.new(game, stats_hash[home_team], stats_hash[away_team])
    end
    games_hash
  end

  def self.season_obj_creator(games_hash)
    seasons_hash = games_hash.values.group_by do |game|
      game.season
    end
  end

  # def self.postseason_obj_creator
  #   season_type_hash = games_hash.values.group_by do |game|
  #     game.type
  #   end
  # end

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
end
