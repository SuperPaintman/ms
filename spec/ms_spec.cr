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

    it "should convert from \"m\" to ms" do
      MS.ms("1m").should eq 60000
    end

    it "should convert from \"h\" to ms" do
      MS.ms("1h").should eq 3600000
    end

    it "should convert \"d\" to ms" do
      MS.ms("2d").should eq 172800000
    end

    it "should convert \"s\" to ms" do
      MS.ms("1s").should eq 1000
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

  # Int32
  describe ".ms(Int32)" do
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

    it "should round" do
      MS.ms(575675089).should eq "6d"
    end
  end
end
