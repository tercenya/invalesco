#@see http://en.wikipedia.org/wiki/Brier_score
class Brier
  def initialize
    reset
  end

  def reset
    @set = []
  end

  def observe(prediction, outcome)
    @set << [prediction, outcome]
  end

  def score
    @set.map do |prediction, outcome|
      (prediction - outcome) ** 2
    end.reduce(:+) / @set.length
  end
end
