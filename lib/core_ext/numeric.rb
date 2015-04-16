class Numeric
  def scale(a1, a2, b1, b2)
    ((b2-b1) * (self - a1)) / (a2 - a1) + b1
  end
end
