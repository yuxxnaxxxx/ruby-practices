# !/usr/bin/env ruby

# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []

# スコアを数値に変換する
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |shot|
  frames << shot
end

point = 0
frames.each_with_index do |frame, index|
  point += if frame[0] == 10
             if index >= 9
               10
             elsif frames[index + 1][0] == 10
               0 + frames[index + 1][0] + frames[index + 2][0]
             else
               10 + (frames[index + 1]).sum
             end
           elsif index < 9 && frames[index].sum == 10
             frames[index].sum + frames[index + 1][0]
           else
             frames[index].sum
           end
end

puts point
