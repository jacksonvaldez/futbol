require 'simplecov'

SimpleCov.start
SimpleCov.command_name 'Unit Tests'
require './lib/tg_stat'
require './lib/creator'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'

RSpec.describe StatTracker do
  let!(:game_path)       {'./spec/fixtures/spec_games.csv'}
  let!(:team_path)       {'./spec/fixtures/spec_teams.csv'}
  let!(:game_teams_path) {'./spec/fixtures/spec_game_teams.csv'}
  let!(:locations)       { {
                            games: game_path,
                            teams: team_path,
                            game_teams: game_teams_path
                            } }
  let!(:stattracker)     { StatTracker.from_csv(locations) }

  it "attributes" do
    expect(stattracker.game_data).to eq(CSV.read(locations[:games], headers: true, header_converters: :symbol))
    expect(stattracker.team_data).to eq(CSV.read(locations[:teams], headers: true, header_converters: :symbol))
    expect(stattracker.game_team_data).to eq(CSV.read(locations[:game_teams], headers: true, header_converters: :symbol))
  end

  it "self from csv and initialize" do
    expect(stattracker).to be_a(StatTracker)
  end

  # Tests from the included LeagueStats module
  describe 'LeagueStats module methods' do
    describe '#count_of_teams' do
      it 'can find the number of teams in the league' do
        expect(stattracker.count_of_teams).to eq(32)
      end
    end

    describe '#best_offense' do
      it 'can find the team with the best offense and return string name' do
        expect(stattracker.best_offense).to eq('FC Dallas')
      end
    end

    describe '#worst_offense' do
      it 'can find the team with the worst offense and return string name' do
        expect(stattracker.worst_offense).to eq('Sporting Kansas City')
      end
    end

    describe '#highest_scoring_visitor' do
      it 'can find the team with the best offense avg while visitor and return string name' do
        expect(stattracker.highest_scoring_visitor).to eq('FC Dallas')
      end
    end

    describe '#highest_scoring_home_team' do
      it 'can find the team with the best offense avg while home and return string name' do
        expect(stattracker.highest_scoring_home_team).to eq('New York City FC')
      end
    end

    describe '#lowest_scoring_visitor' do
      it 'can find the team with the worst offense avg while visitor and return string name' do
        expect(stattracker.lowest_scoring_visitor).to eq('Sporting Kansas City')
      end
    end

    describe '#lowest_scoring_home_team' do
      it 'can find the team with the worst offense avg while home and return string name' do
        expect(stattracker.lowest_scoring_home_team).to eq('Sporting Kansas City')
      end
    end

    describe 'GameStats module methods' do

      it "highest_total_score" do
        expect(stattracker.highest_total_score).to eq(5)
      end

      it "lowest_total_score" do
        expect(stattracker.lowest_total_score).to eq(1)
      end


      it "percentage_home_wins" do
        expect(stattracker.percentage_home_wins).to eq(0.7)
      end

      it "percentage percentage_visitor_wins" do
        expect(stattracker.percentage_visitor_wins).to eq(0.25)
      end

      it "percentage_ties" do
        expect(stattracker.percentage_ties).to eq(0.1)
      end

      it "count_of_games_by_season" do
        expect(stattracker.count_of_games_by_season).to eq({"20122013"=>20})
      end

      it "average_goals_per_game" do
        expect(stattracker.average_goals_per_game).to eq(3.75)
      end

      it "average goals by season" do
        expect(stattracker.average_goals_by_season).to eq({"20122013"=>3.75})
      end


    end

  end
end
