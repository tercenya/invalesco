class ChampionController < ApplicationController
  def index
    @data = Champion.all
    render json: @data.to_json
  end

  def urf_win_loss
    @data = Urf::ChampionWinLossUnique.all.sort_by(&:ratio)
  end

  def urf_win_loss_distribution
    all = Urf::ChampionWinLossUnique.all
    @count = all.size

    data = all.group_by do |e|
      # (e.ratio * 200).floor.to_f / 2
      (e.ratio * 100).floor.to_i
    end.sort.to_h

    ratios = all.map(&:ratio)
    @average = ratios.reduce(:+) / ratios.size.to_f

    weighted_ratios = all.each_with_object([]) do |e,a|
      a.concat [e.ratio] * e.total
    end

    @weighted_average = weighted_ratios.reduce(:+) / weighted_ratios.size.to_f
    @winnable = all.group_by { |e| e.ratio * 100 > 50 }
    @winnable_ratio = @winnable.transform_values do |k|
      k.size / @count.to_f
    end

    range = Range.new(data.keys.first, data.keys.last)
    @data = range.each_with_object({}) do |e,a|
      a[e] = data[e] || []
    end
  end
end
