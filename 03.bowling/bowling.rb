# frozen_string_literal: true

# !/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')
shots = []
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
for i in 0..8 # 10フレーム目のみ処理が異なるため、9フレーム目までくり返す
  if frames[i][0] == 10 # ストライク
    point += 10
    if frames[i + 1][0] == 10
      point += frames[i + 1][0]
      point += frames[i + 2][0]
    else
      point += (frames[i + 1]).sum # 次のフレームの合計スコア
    end
  elsif frames[i][0] < 10 && frames[i].sum == 10 # スペア
    point += frames[i].sum
    point += frames[i + 1][0]
  else
    point += frames[i].sum
  end
end

last_frame = []
i = 9 # 10フレーム目の処理を対応するため、index を9で指定する
while i < frames.count
  last_frame << frames[i][0]
  last_frame << frames[i][1]
  i += 1
end

last_frame_score = last_frame.compact.sum
point += last_frame_score

puts point
