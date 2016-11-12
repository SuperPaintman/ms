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
  {% for time_unit, ms_constant in { y: "Y", d: "D", h: "H", m: "M", s: "S"} %}
    if ms >= {{ms_constant.id}}
      return (ms / {{ms_constant.id}}).round.to_i64.to_s + "{{time_unit}}"
    end
  {% end %}

  ms.to_i64.to_s + "ms"
end

private def fmt_long(ms : Int64) : String
  {% for time_unit, ms_constant in { year: "Y", day: "D", hour: "H", minute: "M", second: "S"} %}
    if ms >= {{ms_constant.id}}
      if ms < {{ms_constant.id}} * 1.5
        return (ms / {{ms_constant.id}}).floor.to_i64.to_s + " {{time_unit}}"
      else
        return (ms / {{ms_constant.id}}).ceil.to_i64.to_s + " {{time_unit}}s"
      end
    end
  {% end %}

  ms.to_i64.to_s + " ms"
end

module MS
  def self.ms(val : String) : Int64
    parse_str(val)
  end

  def self.ms(val : Int32 | Int64, long = false) : String
    if long
      fmt_long(val.to_i64)
    else
      fmt_short(val.to_i64)
    end
  end
end
