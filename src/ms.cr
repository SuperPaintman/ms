require "./ms/*"

# Constants
private S = 1000
private M = S * 60
private H = M * 60
private D = H * 24
private Y = D * 365.25

private REGEXP_STR = /^((?:\d+)?\.?\d+)?[\ \t]*(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|years?|yrs?|y)?$/i

private def parse_str(str : String) : Int64
  res = REGEXP_STR.match(str)

  if res.nil?
    raise "Invalid time format"
  end

  begin
    n = res.try(&.[1])
    n = n.to_s.to_f
  rescue err
    n = 1.0
  end
  n = n.as(Float64)

  begin
    type = res.try(&.[2])
    type = type.to_s.downcase
  rescue err
    type = "ms"
  end

  case type
    when "years", "year", "yrs", "yr", "y"
      return (n * Y).round.to_i64
    when "days", "day", "d"
      return (n * D).round.to_i64
    when "hours", "hour", "hrs", "hr", "h"
      return (n * H).round.to_i64
    when "minutes", "minute", "mins", "min", "m"
      return (n * M).round.to_i64
    when "seconds", "second", "secs", "sec", "s"
      return (n * S).round.to_i64
    when "milliseconds", "millisecond", "msecs", "msec", "ms"
      return (n).round.to_i64
    else
      raise "Unknown type: \"#{type}\""
  end
end

private def fmt_short(ms : Int64) : String
  if ms >= Y
    return (ms / Y).round.to_i64.to_s + "y"
  end

  if ms >= D
    return (ms / D).round.to_i64.to_s + "d"
  end

  if ms >= H
    return (ms / H).round.to_i64.to_s + "h"
  end

  if ms >= M
    return (ms / M).round.to_i64.to_s + "m"
  end

  if ms >= S
    return (ms / S).round.to_i64.to_s + "s"
  end

  ms.to_i64.to_s + "ms"
end

module MS
  def self.ms(val : String) : Int64
    parse_str(val)
  end

  def self.ms(val : Int32 | Int64) : String
    fmt_short(val.to_i64)
  end
end
