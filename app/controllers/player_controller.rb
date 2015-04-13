class PlayerController < ApplicationController
  def index
    @data = Champion.all
    render json: @data.to_json
  end

  def level_distribution
    data = Urf::PlayerLevelDistribution.all.sort_by(&:id)
    range = Range.new(data.first.key, data.last.key).each
    @data = range.each_with_object({}) do |e,a|
      a[e] = data[e] || []
    end
  end
end
