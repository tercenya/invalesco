class TeamController < ApplicationController
  def level_distribution
    @data = Urf::TeamLevelDistribution.all.sort_by(&:id)
    @chart = @data.each_with_object({}) do |e,a|
      a[e.id] = e.count
    end

    # level 300's totally distort the chart
    @chart.delete(300)
  end

  def rank_distribution
    @data = Urf::TeamRankDistribution.all.sort_by(&:id)
    @chart = @data.each_with_object({}) do |e,a|
      a[e.id] = e.total
    end

    @chart2 = @data.each_with_object({}) do |e,a|
      a[e.id] = e.wins / e.total.to_f * 100
    end
  end

  def rank_delta
    @data = Urf::TeamRankSkew.all.sort_by(&:id)
    @chart = @data.each_with_object({}) do |e,a|
      a[e.id] = e.count
    end
  end

  def rank_upsets
    raw_data = Urf::TeamRankSkew.all.sort_by(&:id).reverse

    @data = raw_data.each_with_object({}) do |e,a|
      prev_count = 0
      prev_upsets = 0

      unless a.empty?
        prev_count = a[e.id + 1].count
        prev_upsets =  a[e.id + 1].upsets
      end


      a[e.id.to_i] = OpenStruct.new({
        id: e.id,
        count: prev_count + e.count,
        upsets: prev_upsets + e['upset'].values.reduce(:+)
      })
    end

    @chart = @data.each_with_object({}) do |(k,e),a|
      a[e.id] = e.upsets / e.count.to_f * 100
    end

    @chart2 = raw_data.each_with_object({}) do |e,a|
      a[e.id] = (50 - (e['upset'].values.reduce(:+) / e.count.to_f * 100))
    end

    @chart3 = raw_data.each_with_object({}) do |e,a|
      a[e.id] = (50 - (e['upset'].values.reduce(:+) / e.count.to_f * 100)) * e.count / 50040 * 10
    end
  end
end
