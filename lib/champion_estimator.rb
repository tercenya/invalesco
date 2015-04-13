require 'simple_linear_regression'

class ChampionEstimator
  Result = Struct.new(:blue, :red, :winner, :correct)

  def champions
    @champions ||= Urf::ChampionWinLoss.all
  end

  def matches
    @matches ||= Match.all
  end

  def ratios
    @ratios ||= all.map(&:ratios)
  end

  def simple_run(reducer, &block)
    points = all.each_with_object({}, block)

    @accuracy = 0
    @results = []

    matches.each_with_index do |m,i|
      blue_points = m.blue_characters.map { |c| points[c.id] }.reduce(reducer)
      red_points = m.red_characters.map { |c| points[c.id] }.reduce(reducer)

      predict = blue_points > red_points ? :blue : :red
      correct = predict == m.winner

      @results << Result.new(blue_points, red_points, m.winner, correct)

      @accuracy += 1 if correct
      puts i if i % 1000 == 0
    end
  end

  def accuracy
    @accuracy / @results.size.to_f
  end

  def linear_regression
    xs = @results.each_with_object([]) do |e,a|
      a << (e.winner == :blue ? 1 : 0)
    end

    ys = @results.each_with_object([]) do |e,a|
      a << (e.blue.to_f / (e.red + e.blue))
    end

    lr = SimpleLinearRegression.new(xs, ys)
    return lr.slope
  end

  def bates
    # TODO: bates analysis
  end
end
