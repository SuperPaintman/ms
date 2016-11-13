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

  if res.nil? || (res[1]?.nil? && res[2]?.nil?)
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
    time_unit = res.try(&.[2])
    time_unit = time_unit.to_s.downcase
  rescue err
    time_unit = "ms"
  end

  case time_unit
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
    raise "Unknown time unit: \"#{time_unit}\""
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

private def fmt_long(ms : Int64) : String
  if ms >= Y
    if ms < Y * 1.5
      return (ms / Y).floor.to_i64.to_s + " year"
    else
      return (ms / Y).ceil.to_i64.to_s + " years"
    end
  end

  if ms >= D
    if ms < D * 1.5
      return (ms / D).floor.to_i64.to_s + " day"
    else
      return (ms / D).ceil.to_i64.to_s + " days"
    end
  end

  if ms >= H
    if ms < H * 1.5
      return (ms / H).floor.to_i64.to_s + " hour"
    else
      return (ms / H).ceil.to_i64.to_s + " hours"
    end
  end

  if ms >= M
    if ms < M * 1.5
      return (ms / M).floor.to_i64.to_s + " minute"
    else
      return (ms / M).ceil.to_i64.to_s + " minutes"
    end
  end

  if ms >= S
    if ms < S * 1.5
      return (ms / S).floor.to_i64.to_s + " second"
    else
      return (ms / S).ceil.to_i64.to_s + " seconds"
    end
  end

  ms.to_i64.to_s + " ms"
end

module MS
  extend self

  def ms(val : String) : Int64
    parse_str(val)
  end

  def ms(val : Int32 | Int64, long = false) : String
    if long
      fmt_long(val.to_i64)
    else
      fmt_short(val.to_i64)
    end
  end
end
