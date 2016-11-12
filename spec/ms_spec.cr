require "./spec_helper"

describe MS do
  # String
  describe ".ms(String)" do
    it "should not raise an error" do
      begin
        MS.ms("1m")
      rescue err
        err.should be_nil
      end
    end

    it "should preserve \"ms\"" do
      MS.ms("100").should eq 100
    end

    it "should prepend time if it not exist" do
      MS.ms("day").should eq 86400000
    end

    it "should convert \"s\" to ms" do
      MS.ms("1s").should eq 1000
    end

    it "should convert from \"m\" to ms" do
      MS.ms("1m").should eq 60000
    end

    it "should convert from \"h\" to ms" do
      MS.ms("1h").should eq 3600000
    end

    it "should convert \"d\" to ms" do
      MS.ms("2d").should eq 172800000
    end

    it "should convert \"y\" to ms" do
      MS.ms("1y").should eq 31557600000
    end

    it "should convert \"ms\" to ms" do
      MS.ms("100ms").should eq 100
    end

    it "should work with decimals" do
      MS.ms("1.5h").should eq 5400000
    end

    it "should work with multiple spaces" do
      MS.ms("1   s").should eq 1000
    end

    it "should work with tabs" do
      MS.ms("1\ts").should eq 1000
      MS.ms("1\t\t\t\t\ts").should eq 1000
    end

    it "should work with mixed tabs and spaces" do
      MS.ms("1  \ts").should eq 1000
      MS.ms("1\t\t  \t\ts").should eq 1000
    end

    it "should be case-insensitive" do
      MS.ms("1.5H").should eq 5400000
    end

    it "should work with numbers starting with \".\"" do
      MS.ms(".5s").should eq 500
    end

    it "should round" do
      MS.ms("0.2ms").should eq 0
      MS.ms("0.5ms").should eq 1
      MS.ms("0.9ms").should eq 1
    end
  end

  # Long Strings
  describe ".ms(String) # long" do
    it "should not raise an error" do
      begin
        MS.ms("53 milliseconds")
      rescue err
        err.should be_nil
      end
    end

    it "should convert \"milliseconds\", \"millisecond\", \"msecs\", \"msec\", \"ms\" to ms" do
      ["milliseconds", "millisecond", "msecs", "msec", "ms"].each do |type|
        MS.ms("53 #{type}").should eq 53
      end
    end

    it "should convert \"seconds\", \"second\", \"secs\", \"sec\", \"s\" to ms" do
      ["seconds", "second", "secs", "sec", "s"].each do |type|
        MS.ms("1 #{type}").should eq 1000
      end
    end

    it "should convert from \"minutes\", \"minute\", \"mins\", \"min\", \"m\" to ms" do
      ["minutes", "minute", "mins", "min", "m"].each do |type|
        MS.ms("1 #{type}").should eq 60000
      end
    end

    it "should convert from \"hours\", \"hour\", \"hrs\", \"hr\", \"h\" to ms" do
      ["hours", "hour", "hrs", "hr", "h"].each do |type|
        MS.ms("1 #{type}").should eq 3600000
      end
    end

    it "should convert \"days\", \"day\", \"d\" to ms" do
      ["days", "day", "d"].each do |type|
        MS.ms("2 #{type}").should eq 172800000
      end
    end


    it "should convert \"years\", \"year\", \"yrs\", \"yr\", \"y\" to ms" do
      ["years", "year", "yrs", "yr", "y"].each do |type|
        MS.ms("2 #{type}").should eq 63115200000
      end
    end

    it "should work with decimals" do
      MS.ms("1.5 hours").should eq 5400000
    end
  end

  # Int32 | Int64
  describe ".ms(Int32 | Int64)" do
    it "should not raise an error" do
      begin
        MS.ms(100)
      rescue err
        err.should be_nil
      end
    end

    it "should support milliseconds" do
      MS.ms(100).should eq "100ms"
      MS.ms(500).should eq "500ms"
      MS.ms(900).should eq "900ms"
    end

    it "should support seconds" do
      MS.ms(1000 * 1).should eq "1s"
      MS.ms(1000 * 5).should eq "5s"
      MS.ms(1000 * 10).should eq "10s"
      MS.ms(1000 * 29).should eq "29s"
    end

    it "should support minutes" do
      MS.ms(60 * 1000 * 1).should eq "1m"
      MS.ms(60 * 1000 * 5).should eq "5m"
      MS.ms(60 * 1000 * 10).should eq "10m"
      MS.ms(60 * 1000 * 29).should eq "29m"
    end

    it "should support hours" do
      MS.ms(60 * 60 * 1000 * 1).should eq "1h"
      MS.ms(60 * 60 * 1000 * 5).should eq "5h"
      MS.ms(60 * 60 * 1000 * 10).should eq "10h"
      MS.ms(60 * 60 * 1000 * 23).should eq "23h"
    end

    it "should support days" do
      MS.ms(24 * 60 * 60 * 1000 * 1).should eq "1d"
      MS.ms(24 * 60 * 60 * 1000 * 5).should eq "5d"
      MS.ms(24 * 60 * 60 * 1000 * 10).should eq "10d"
      MS.ms(24 * 60 * 60 * 1000 * 23).should eq "23d"
    end

    it "should support years" do
      MS.ms((365.25 * 24 * 60 * 60 * 1000 * 1).round.to_i64).should eq "1y"
      MS.ms((365.25 * 24 * 60 * 60 * 1000 * 5).round.to_i64).should eq "5y"
      MS.ms((365.25 * 24 * 60 * 60 * 1000 * 10).round.to_i64).should eq "10y"
      MS.ms((365.25 * 24 * 60 * 60 * 1000 * 23).round.to_i64).should eq "23y"
    end

    it "should round" do
      MS.ms(575675089).should eq "6d"
    end
  end

  # Int32 | Int64, long: true
  describe ".ms(Int32 | Int64, long: true)" do
    it "should not raise an error" do
      begin
        MS.ms(500, long: true)
      rescue err
        err.should be_nil
      end
    end

    it "should support milliseconds" do
      MS.ms(100, long: true).should eq "100 ms"
      MS.ms(500, long: true).should eq "500 ms"
      MS.ms(900, long: true).should eq "900 ms"
    end

    it "should support seconds" do
      MS.ms(1000 * 1, long: true).should eq "1 second"
      MS.ms((1000 * 1.2).round.to_i64, long: true).should eq "1 second"
      MS.ms(1000 * 10, long: true).should eq "10 seconds"
    end

    it "should support minutes" do
      MS.ms(60 * 1000 * 1, long: true).should eq "1 minute"
      MS.ms((60 * 1000 * 1.2).round.to_i64, long: true).should eq "1 minute"
      MS.ms(60 * 1000 * 10, long: true).should eq "10 minutes"
    end

    it "should support hours" do
      MS.ms(60 * 60 * 1000 * 1, long: true).should eq "1 hour"
      MS.ms((60 * 60 * 1000 * 1.2).round.to_i64, long: true).should eq "1 hour"
      MS.ms(60 * 60 * 1000 * 10, long: true).should eq "10 hours"
    end

    it "should support days" do
      MS.ms(24 * 60 * 60 * 1000 * 1, long: true).should eq "1 day"
      MS.ms((24 * 60 * 60 * 1000 * 1.2).round.to_i64, long: true).should eq "1 day"
      MS.ms(24 * 60 * 60 * 1000 * 10, long: true).should eq "10 days"
    end

    it "should support years" do
      MS.ms((365.25 * 24 * 60 * 60 * 1000 * 1).round.to_i64, long: true).should eq "1 year"
      MS.ms((365.25 * 24 * 60 * 60 * 1000 * 1.2).round.to_i64, long: true).should eq "1 year"
      MS.ms((365.25 * 24 * 60 * 60 * 1000 * 10).round.to_i64, long: true).should eq "10 years"
    end

    it "should round" do
      MS.ms(575675089, long: true).should eq "6 days"
    end
  end

  # Invalid vals
  describe ".ms(Invalid vals)" do
    it "should raise an error, when MS.ms(\"\")" do
      begin
        MS.ms("")
      rescue err
        err.message.should eq "Invalid time format"
      else
        raise "should raise an error"
      end
    end

    it "should raise an error, when MS.ms(\"  \")" do
      begin
        MS.ms("  ")
      rescue err
        err.message.should eq "Invalid time format"
      else
        raise "should raise an error"
      end
    end

    it "should raise an error, when MS.ms(\"\\t\")" do
      begin
        MS.ms("\t")
      rescue err
        err.message.should eq "Invalid time format"
      else
        raise "should raise an error"
      end
    end

    it "should raise an error, when MS.ms(\"\\t \")" do
      begin
        MS.ms("\t  ")
        MS.ms("  \t  ")
        MS.ms("\t    \t ")
        MS.ms("\t    \t")
      rescue err
        err.message.should eq "Invalid time format"
      else
        raise "should raise an error"
      end
    end

    it "should raise an error, when MS.ms(\"10 waffles\")" do
      begin
        MS.ms("10 waffles")
      rescue err
        err.message.should eq "Invalid time format"
      else
        raise "should raise an error"
      end
    end

    it "should raise an error, when MS.ms(\"waffles\")" do
      begin
        MS.ms("10 waffles")
      rescue err
        err.message.should eq "Invalid time format"
      else
        raise "should raise an error"
      end
    end
  end
end
