module Invalesco
  class Aggregates
    class << self
      def popularity
        map = %Q{
          function() {
            this.participants.forEach( function(participant) {
              win = participant.stats.winner ? 1 : 0
              loss = participant.stats.winner ? 0 : 1

              emit(NumberInt(participant.championId), { wins: win, losses: loss } )
            })
          }
        }

        reduce = %Q{
         function(key, values) {
            var result = { wins: 0, losses: 0 };
            values.forEach(function (value) {
              result.wins += value.wins;
              result.losses += value.losses;
            })
            return result;
          }
        }

        finalize = %Q{
          function(key, value) {
            // value.champion_id = NumberInt(key);
            value.wins = NumberInt(value.wins);
            value.losses = NumberInt(value.losses);
            return value;
          }
        }

        Match.map_reduce(map, reduce).finalize(finalize).out(inline: true)
      end
    end
  end
end
