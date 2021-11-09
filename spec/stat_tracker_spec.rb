require_relative '../spec/spec_helper'
require_relative '../lib/tg_stat'
require_relative '../lib/creator'
require_relative '../lib/stat_tracker'
require_relative '../lib/game'
require_relative '../lib/team'

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
  end

  describe 'GameStats module methods' do

    describe 'highest_total_score' do
      it 'finds the game with the highest score' do
        expect(stattracker.highest_total_score).to eq(5)
      end
    end

    describe 'lowest_total_score' do
      it 'finds the game with the lowest score' do
        expect(stattracker.lowest_total_score).to eq(1)
      end
    end

    describe 'percentage_home_wins' do
      it 'finds the percentage of home wins' do
        expect(stattracker.percentage_home_wins).to eq(0.7)
      end
    end

    describe 'percentage_visitor_wins' do
      it 'finds the percentage of visitor wins' do
        expect(stattracker.percentage_visitor_wins).to eq(0.25)
      end
    end

    describe 'percentage ties' do
      it 'finds the percentage of games that tied' do
        expect(stattracker.percentage_ties).to eq(0.05)
      end
    end

    describe 'count_of_games_by_season' do
      it 'counts the number of games by season' do
        expect(stattracker.count_of_games_by_season).to eq({"20122013"=>20})
      end
    end

    describe 'average_goals_per_game' do
      it 'finds the average goals scored per game' do
        expect(stattracker.average_goals_per_game).to eq(3.75)
      end
    end

    describe 'average goals by season' do
      it 'finds the average goals per game by season' do
        expect(stattracker.average_goals_by_season).to eq({"20122013"=>3.75})
      end
    end
  end

  describe 'TeamStats' do
    describe '#team_info' do
      it "returns the info for each team" do
        expected = {
                    "team_id" => "18",
                    "franchise_id" => "34",
                    "team_name" => "Minnesota United FC",
                    "abbreviation" => "MIN",
                    "link" => "/api/v1/teams/18"
                   }

        expect(stattracker.team_info("18")).to eq(expected)
      end
    end

    describe '#best_season' do
      it "returns the best season for the team id given" do
        expect(stattracker.best_season("6")).to eq("20122013")
      end
    end

    describe '#worst_season' do
      it "returns the worst season for the team id given" do
        expect(stattracker.worst_season("3")).to eq("20122013")
      end
    end

    describe '#average_win_percentage' do
      it "returns the average win/loss percentage for the team id given" do
        expect(stattracker.average_win_percentage("6")).to eq(1.0)
      end
    end

    describe '#most_goals_scored' do
      it "returns the most goals scored for the team id given" do
        expect(stattracker.most_goals_scored("6")).to eq(4)
      end
    end

    describe '#fewest_goals_scored' do
      it "returns the least goals scored for the team id given" do
        expect(stattracker.fewest_goals_scored("6")).to eq(1)
      end
    end

    describe '#favorite_opponent' do
      it "returns the team name that has the most losses against the team id given" do
        expect(stattracker.favorite_opponent("6")).to eq("Houston Dynamo")
      end
    end

    describe '#rival' do
      it "returns the team name that has the most wins against the team id given" do
        expect(stattracker.rival("5")).to eq("FC Dallas")
      end
    end
  end

  describe 'SeasonStats module methods' do

    describe "#winningest_coach" do
      it 'returns the name of the Coach with the best win percentage for the season' do
        expect(stattracker.winningest_coach("20122013")).to eq("Claude Julien")
      end
    end

    describe "#worst_coach" do
      it 'returns the name of the Coach with the worst win percentage for the season' do
        expect(stattracker.worst_coach("20122013")).to eq("John Tortorella")
      end
    end

    describe "#most_accurate_team" do
      it 'returns the name of the Team with the best ratio of shots to goals for the season' do
        expect(stattracker.most_accurate_team("20122013")).to eq("New York City FC")
      end
    end

    describe "#least_accurate_team" do
      it 'returns the name of the Team with the worst ratio of shots to goals for the season' do
        expect(stattracker.least_accurate_team("20122013")).to eq("Sporting Kansas City")
      end
    end

    describe "#most_tackles" do
      it 'returns the name of the Team with the most tackles in the season' do
        expect(stattracker.most_tackles("20122013")).to eq("FC Dallas")
      end
    end

    describe "#fewest_tackles" do
      it 'returns the name of the Team with the fewest tackles in the season' do
        expect(stattracker.fewest_tackles("20122013")).to eq("Sporting Kansas City")
      end
    end
  end
  
end
