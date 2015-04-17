require 'simple_linear_regression'
require 'brier'

class ChampionEstimator
  Result = Struct.new(:blue, :red, :winner, :correct)

  def champions
    @champions ||= Urf::ChampionWinLossUnique.all
  end

  def matches
    @matches ||= Match.all
  end

  def ratios
    @ratios ||= all.map(&:ratios)
  end

  def simple_run(reducer, options = {}, &block)
    points = champions.each_with_object({}, &block)

    @accuracy = 0
    @results = []

    puts "starting"
    matches.each_with_index do |m,i|
      blue_points = m.blue_characters.map { |c| points[c.id] }.reduce(reducer)
      red_points = m.red_characters.map { |c| points[c.id] }.reduce(reducer)
      # puts "#{blue_points} vs #{red_points}"
      predict = blue_points > red_points ? :blue : :red
      correct = predict == m.winner

      @results << Result.new(blue_points, red_points, m.winner, correct)

      @accuracy += 1 if correct
      puts "#{i}..." if i % 1000 == 0
    end

    puts "done"
  end

  def accuracy
    @accuracy / @results.size.to_f
  end

  def linear_regression
    xs = @results.each_with_object([]) do |e,a|
      a << outcome(e)
    end

    ys = @results.each_with_object([]) do |e,a|
      a << odds(e)
    end

    lr = SimpleLinearRegression.new(xs, ys)
    return lr.slope
  end

  def brier
    b = Brier.new
    @results.each do |e|
      b.observe(odds(e), outcome(e))
    end

    return b.score
  end

  private
  def odds(e)
    e.blue.to_f / (e.red + e.blue)
  end

  def outcome(e)
    e.winner == :blue ? 1 : 0
  end
end
