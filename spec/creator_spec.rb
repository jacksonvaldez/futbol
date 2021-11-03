require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Unit Tests'
require './lib/tg_stat'
require './lib/creator'
require './lib/stat_tracker'
require './lib/game'

RSpec.describe Creator do
  # let(:league){double("league")}
  let!(:stat_tracker) do
    game_path = './spec/fixtures/spec_games.csv'
    team_path = './spec/fixtures/spec_teams.csv'
    game_teams_path = './spec/fixtures/spec_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    StatTracker.from_csv(locations)
  end
  let!(:game_data){stat_tracker.game_data}
  let!(:team_data){stat_tracker.team_data}
  let!(:game_team_data){stat_tracker.game_team_data}
  let!(:creator) { Creator.create_objects(game_data, team_data, game_team_data) }
  let(:league) {creator.league}

  describe '#initialize' do
    it "exists" do
      expect(creator).to be_a(Creator)
    end

    it "is an attribute" do
      expect(creator.league).to eq(league)
    end

  end

  describe  '#stat_obj_creator' do
    it "creates a hash objects" do
      expect(Creator.stat_obj_creator(game_team_data)).to be_a(Hash)
    end

    it 'creates TGStat objects' do
      stats_hash = Creator.stat_obj_creator(game_team_data)

      expect(stats_hash['2012030221_3']).to be_a(TGStat)
    end
  end

  describe '#game_obj_creator' do
    it 'creates a hash' do
      expect(Creator.stat_obj_creator(game_team_data)).to be_a(Hash)
    end
    it 'creates game objects' do
      stats_hash = Creator.stat_obj_creator(game_team_data)
      games_hash = Creator.game_obj_creator(game_data, stats_hash)

      expect(games_hash['2012030236']).to be_a(Game)
    end
  end

  # describe "#league" do
  #   it "creates league object" do
  #   expect(creator.league).to be_a(League)
  #   end
  # end

end
