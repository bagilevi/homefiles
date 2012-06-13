#!/usr/bin/env ruby

arg = ARGV[0]
dirs = `find ~/code -maxdepth 2 -type d`.split("\n").map(&:strip)

shortlisted_dirs = dirs.map do |dir|
  basename = File.basename(dir)
  priority =\
    if basename == dir
      0
    elsif basename.include?(arg)
      1
    else
      nil
    end
  [dir, priority] if priority
end.compact.sort_by{|dir, priority| priority}.map{|dir, priority| dir}


if shortlisted_dirs.size == 0
  $stderr.puts "Couldn't find directory."
  puts "."
  exit 1
else
  puts shortlisted_dirs.first
end
