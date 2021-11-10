require_relative './lib/creator'
require_relative './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)


futbol = File.new("site/index.html", "w")


html = "
    <!DOCTYPE html>
    <html>
      <head>
      <title> Futbol - 2110BE </title>
      <style>
      body {
        background-image: url(https://upload.wikimedia.org/wikipedia/commons/1/1d/Football_Pallo_valmiina-cropped.jpg);
        color: white;
        font-size: 50px;
      }
      h1 {
        text-align: center;
      }
      .transparent-bg {
        background-color: blue;
        background-image: linear-gradient(to right, #1c87c9, #8ebf42);
        opacity: 0.75;
      }
      p {text-align: center;}
      table {
        border: 4px solid black;
        background-color: black;
        opacity: .75;
      }
      th { 
        font-size: 30px;
        text-align: center;
        margin-left: auto;
        margin-right: auto;
      }
      td {
        font-size: 12px;
        text-align: center;
        margin-left: auto;
        margin-right: auto;
      }
      </style>
      </head>
        <body>
          <h1 class=\"transparent-bg\">Futbol Stat Tracker</h1>
          <p>-----------------------------------
          <table class=\"transparent-bg\">
            <tr>
              <th>Team Name</th>
              <th>Team ID Number</th>
              <th>Franchise ID Number</th>
              <th>Abbreviation</th>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("1")["team_name"]}</td>
              <td>#{stat_tracker.team_info("1")["team_id"]}</td>
              <td>#{stat_tracker.team_info("1")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("1")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("4")["team_name"]}</td>
              <td>#{stat_tracker.team_info("4")["team_id"]}</td>
              <td>#{stat_tracker.team_info("4")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("4")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("26")["team_name"]}</td>
              <td>#{stat_tracker.team_info("26")["team_id"]}</td>
              <td>#{stat_tracker.team_info("26")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("26")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("14")["team_name"]}</td>
              <td>#{stat_tracker.team_info("14")["team_id"]}</td>
              <td>#{stat_tracker.team_info("14")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("14")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("6")["team_name"]}</td>
              <td>#{stat_tracker.team_info("6")["team_id"]}</td>
              <td>#{stat_tracker.team_info("6")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("6")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("3")["team_name"]}</td>
              <td>#{stat_tracker.team_info("3")["team_id"]}</td>
              <td>#{stat_tracker.team_info("3")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("3")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("5")["team_name"]}</td>
              <td>#{stat_tracker.team_info("5")["team_id"]}</td>
              <td>#{stat_tracker.team_info("5")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("5")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("17")["team_name"]}</td>
              <td>#{stat_tracker.team_info("17")["team_id"]}</td>
              <td>#{stat_tracker.team_info("17")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("17")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("28")["team_name"]}</td>
              <td>#{stat_tracker.team_info("28")["team_id"]}</td>
              <td>#{stat_tracker.team_info("28")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("28")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("18")["team_name"]}</td>
              <td>#{stat_tracker.team_info("18")["team_id"]}</td>
              <td>#{stat_tracker.team_info("18")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("18")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("23")["team_name"]}</td>
              <td>#{stat_tracker.team_info("23")["team_id"]}</td>
              <td>#{stat_tracker.team_info("23")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("23")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("16")["team_name"]}</td>
              <td>#{stat_tracker.team_info("16")["team_id"]}</td>
              <td>#{stat_tracker.team_info("16")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("16")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("9")["team_name"]}</td>
              <td>#{stat_tracker.team_info("9")["team_id"]}</td>
              <td>#{stat_tracker.team_info("9")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("9")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("8")["team_name"]}</td>
              <td>#{stat_tracker.team_info("8")["team_id"]}</td>
              <td>#{stat_tracker.team_info("8")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("8")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("30")["team_name"]}</td>
              <td>#{stat_tracker.team_info("30")["team_id"]}</td>
              <td>#{stat_tracker.team_info("30")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("30")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("15")["team_name"]}</td>
              <td>#{stat_tracker.team_info("15")["team_id"]}</td>
              <td>#{stat_tracker.team_info("15")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("15")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("19")["team_name"]}</td>
              <td>#{stat_tracker.team_info("19")["team_id"]}</td>
              <td>#{stat_tracker.team_info("19")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("19")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("24")["team_name"]}</td>
              <td>#{stat_tracker.team_info("24")["team_id"]}</td>
              <td>#{stat_tracker.team_info("24")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("24")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("27")["team_name"]}</td>
              <td>#{stat_tracker.team_info("27")["team_id"]}</td>
              <td>#{stat_tracker.team_info("27")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("27")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("2")["team_name"]}</td>
              <td>#{stat_tracker.team_info("2")["team_id"]}</td>
              <td>#{stat_tracker.team_info("2")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("2")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("20")["team_name"]}</td>
              <td>#{stat_tracker.team_info("20")["team_id"]}</td>
              <td>#{stat_tracker.team_info("20")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("20")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("21")["team_name"]}</td>
              <td>#{stat_tracker.team_info("21")["team_id"]}</td>
              <td>#{stat_tracker.team_info("21")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("21")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("25")["team_name"]}</td>
              <td>#{stat_tracker.team_info("25")["team_id"]}</td>
              <td>#{stat_tracker.team_info("25")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("25")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("13")["team_name"]}</td>
              <td>#{stat_tracker.team_info("13")["team_id"]}</td>
              <td>#{stat_tracker.team_info("13")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("13")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("10")["team_name"]}</td>
              <td>#{stat_tracker.team_info("10")["team_id"]}</td>
              <td>#{stat_tracker.team_info("10")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("10")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("29")["team_name"]}</td>
              <td>#{stat_tracker.team_info("29")["team_id"]}</td>
              <td>#{stat_tracker.team_info("29")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("29")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("52")["team_name"]}</td>
              <td>#{stat_tracker.team_info("52")["team_id"]}</td>
              <td>#{stat_tracker.team_info("52")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("52")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("54")["team_name"]}</td>
              <td>#{stat_tracker.team_info("54")["team_id"]}</td>
              <td>#{stat_tracker.team_info("54")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("54")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("12")["team_name"]}</td>
              <td>#{stat_tracker.team_info("12")["team_id"]}</td>
              <td>#{stat_tracker.team_info("12")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("12")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("7")["team_name"]}</td>
              <td>#{stat_tracker.team_info("7")["team_id"]}</td>
              <td>#{stat_tracker.team_info("7")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("7")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("22")["team_name"]}</td>
              <td>#{stat_tracker.team_info("22")["team_id"]}</td>
              <td>#{stat_tracker.team_info("22")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("22")["abbreviation"]}</td>
            </tr>
            <tr>
              <td>#{stat_tracker.team_info("53")["team_name"]}</td>
              <td>#{stat_tracker.team_info("53")["team_id"]}</td>
              <td>#{stat_tracker.team_info("53")["franchise_id"]}</td>
              <td>#{stat_tracker.team_info("53")["abbreviation"]}</td>
            </tr>
          </table>
          </p>
        </body>
    </html>"
futbol.write(html)
