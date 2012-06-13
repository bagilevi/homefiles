#!/usr/bin/ruby
FILE_TYPES = ["rb", "feature", "yml", "erb", "haml"]

def rm_trailing_whitespace!(file)
  trimmed = []
  changed = false
  trimmed = File.readlines(file).map do |line|
    line.gsub!(/[\t ]+$/, "") ? (changed = true) : nil
    line
  end
  open(file, "w") { |f| f.write(trimmed) } if changed
end

root = ARGV.first
files = File.directory?(root) ? Dir.glob("#{root}/**/*.{#{FILE_TYPES.join(',')}}") : [root]
files.each { |file| rm_trailing_whitespace!(file) }
