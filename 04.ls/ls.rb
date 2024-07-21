#!/usr/bin/env ruby

# frozen_string_literal: true

COLUMN_WIDTH = 8
DEFAULT_COLUMN = 3

def get_files(include_hidden: false)
  all_files = Dir.entries('.')
  files = if include_hidden
            all_files
          else
            all_files.reject { |file| file.start_with?('.') }
          end
  files.sort
end

def get_max_file_name_length(files)
  return 0 if files.empty?

  files.map(&:size).max
end

def ordered_files(files, columns = DEFAULT_COLUMN)
  file_count = files.count.to_f
  rows = (file_count / columns).ceil

  order_files = []
  rows.times { order_files << [] }

  files.each_with_index do |file, i|
    order_files[i % rows] << file
  end

  order_files
end

def get_column_width(max_file_name_length)
  if (max_file_name_length % COLUMN_WIDTH).zero?
    COLUMN_WIDTH * 2
  elsif max_file_name_length > COLUMN_WIDTH
    (max_file_name_length.to_f / COLUMN_WIDTH).ceil * COLUMN_WIDTH
  else
    COLUMN_WIDTH
  end
end

def output_file_name(files, columns = DEFAULT_COLUMN)
  max_file_name_length = get_max_file_name_length(files)
  width = get_column_width(max_file_name_length)
  ordered_files_result = ordered_files(files, columns)

  ordered_files_result.each do |file|
    file.each do |name|
      print name.ljust(width, ' ')
    end
    print "\n"
  end
end

files = get_files
output_file_name(files, DEFAULT_COLUMN)
