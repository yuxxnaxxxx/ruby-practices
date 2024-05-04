#!/usr/bin/env ruby
require 'optparse'
require 'date'

class Calendar
  def initialize(year, month, current_day)
    @year = year
    @month = month
    @current_day = current_day
  end

  def show
    return puts "cal: year '#{@year}' not in range 1..9999" if valid_year?
    return puts "cal: #{@month} is neither a month number (1..12) nor a name" if valid_month?

    first_date = Date.new(@year, @month, 1)
    last_date = Date.new(@year, @month, -1)

    time = Time.new(@year, @month)
    month_name = time.strftime("%B")
    
    first_day_weekday = first_date.wday
    blank =  "   " * first_day_weekday

    puts "#{month_name} #{@year}".center(20)
    puts "Su Mo Tu We Th Fr Sa"
    print blank
    (first_date..last_date).each do |date|
      if date == @current_day
        printf("\e[7m%2s\e[0m", date.day)
        print " "
      else
        printf("%2s", date.day)
        print " "
      end
      print "\n" if date.saturday?
    end
    print "\n"
  end

  private

  def valid_month?
    @month.nil? || @month < 1 || @month > 12
  end

  def valid_year?
    @year.nil? || @year <= 0 || @year > 9999
  end
end

params = {}
opt = OptionParser.new
opt.on('-y year', Integer) {|year| params[:year] = year }
opt.on('-m month', Integer) {|month| params[:month] = month }
opt.parse!(ARGV)

current_day = Date.today
year = params[:year] || current_day.year
month = params[:month] || current_day.month

calendar = Calendar.new(year, month, current_day)
calendar.show
