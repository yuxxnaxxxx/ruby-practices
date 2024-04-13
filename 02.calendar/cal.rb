#!/usr/bin/env ruby
require 'optparse'
require 'date'

class Calendar
  def initialize(year, month, current_day)
    @year = year
    @month = month
    @day = current_day
  end

  def include_today?
    return true if @year === @day.year && @month === @day.month
  end

  def valid_month
    if @month.nil? || @month < 1 || @month > 12
      puts "cal: #{@month} is neither a month number (1..12) nor a name"
      exit()
    end
  end
  
  def valid_year
    if @year.nil? || @year <= 0
      puts "cal: year '#{@year}' not in range 1..9999"
      exit()
    end
  end

  def print_calendar
    # 渡された年月が正しいかチェックする
    valid_year
    valid_month

    # 対象月の初日、最終日を取得する
    first_day = Date.new(@year, @month, 1)
    last_day = Date.new(@year, @month, -1)

    # 月の名前を取得する
    time = Time.new(@year, @month)
    month_name = time.strftime("%B")
    
    # 初週の表示位置を調整する
    first_day_weekday = first_day.wday
    blank =  "   " * first_day_weekday

    # カレンダーを出力する
    puts "#{month_name} #{@year}".center(20)
    puts "Su Mo Tu We Th Fr Sa"
    print blank if first_day_weekday != 0
    (first_day..last_day).each do |date|
      if include_today? === true && date.day == @day.day
        printf("\e[7m%2s\e[0m", date.day)
        print " "
      else
        printf("%2s", date.day)
        print " "
      end
      print "\n" if date.wday == 6
    end
    puts ""
  end
end

# optparseで引数を受け取れるようにする
params = {}
opt = OptionParser.new
opt.on('-y year', Integer) {|year| params[:year] = year }
opt.on('-m month', Integer) {|month| params[:month] = month }
opt.parse!(ARGV)

# 現在の日付を取得
current_day = Date.today
# 引数が指定されていない場合は、現在の月, 年を取得
year = params[:year] || current_day.year
month = params[:month] || current_day.month

calendar = Calendar.new(year, month, current_day)
calendar.print_calendar
