#!/usr/bin/env ruby

# frozen_string_literal: true

COLUMN_WIDTH = 8
DEFAULT_COLUMN = 3

def get_filenames(include_hidden: false)
  all_filenames = Dir.entries('.')
  filenames = if include_hidden
                all_filenames
              else
                all_filenames.reject { |filename| filename.start_with?('.') }
              end
  filenames.sort
end

def get_max_filename_length(filenames)
  return 0 if filenames.empty?

  filenames.map(&:size).max
end

def reorder_filenames(filenames, columns = DEFAULT_COLUMN)
  file_count = filenames.count.to_f
  rows = (file_count / columns).ceil

  ordered_filenames = []
  rows.times { ordered_filenames << [] }

  filenames.each_with_index do |filename, i|
    ordered_filenames[i % rows] << filename
  end

  ordered_filenames
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

def output_filenames(filenames, columns = DEFAULT_COLUMN)
  max_filename_length = get_max_filename_length(filenames)
  width = get_column_width(max_filename_length)
  grouped_filenames = reorder_filenames(filenames, columns)

  grouped_filenames.each do |file_group|
    file_group.each do |filename|
      print filename.ljust(width, ' ')
    end
    puts
  end
end

filenames = get_filenames
output_filenames(filenames, DEFAULT_COLUMN)
