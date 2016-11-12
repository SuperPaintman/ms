require "./spec_helper"

describe MS do
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
