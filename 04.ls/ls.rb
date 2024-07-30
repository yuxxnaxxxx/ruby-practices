#!/usr/bin/env ruby

# frozen_string_literal: true

COLUMN_WIDTH = 8
DEFAULT_COLUMN = 3

def get_filenames(include_hidden: false)
  all_files = Dir.entries('.')
  files = if include_hidden
            all_files
          else
            all_files.reject { |file| file.start_with?('.') }
          end
  files.sort
end

def get_max_filename_length(filenames)
  return 0 if filenames.empty?

  filenames.map(&:size).max
end

def convert_file_order(files, columns = DEFAULT_COLUMN)
  file_count = files.count.to_f
  rows = (file_count / columns).ceil

  ordered_files = []
  rows.times { ordered_files << [] }

  files.each_with_index do |file, i|
    ordered_files[i % rows] << file
  end

  ordered_files
end

def get_column_width(max_filename_length)
  if (max_filename_length % COLUMN_WIDTH).zero?
    max_filename_length + COLUMN_WIDTH
  elsif max_filename_length > COLUMN_WIDTH
    (max_filename_length.to_f / COLUMN_WIDTH).ceil * COLUMN_WIDTH
  else
    COLUMN_WIDTH
  end
end

def output_file_name(files, columns = DEFAULT_COLUMN)
  max_filename_length = get_max_filename_length(files)
  width = get_column_width(max_filename_length)
  ordered_files_result = convert_file_order(files, columns)

  ordered_files_result.each do |file|
    file.each do |name|
      print name.ljust(width, ' ')
    end
    puts
  end
end

files = get_filenames
output_file_name(files, DEFAULT_COLUMN)
