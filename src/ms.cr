require "./ms/*"

# Constants
private S = 1000
private M = S * 60
private H = M * 60
private D = H * 24
private Y = D * 365.25

private def fmt_short(ms : Int32) : String
  if ms >= D
    return (ms / D).round.to_s + "d"
  end

  if ms >= H
    return (ms / H).round.to_s + "h"
  end

  if ms >= M
    return (ms / M).round.to_s + "m"
  end

  if ms >= S
    return (ms / S).round.to_s + "s"
  end

  ms.to_s + "ms"
end

module MS
  def self.ms(val : Int32) : String
    fmt_short(val)
  end
end
