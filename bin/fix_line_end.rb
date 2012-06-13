#!/usr/bin/ruby
FILE_TYPES = ["rb", "feature", "yml", "erb", "haml"]

def fix_line_end!(file)
  trimmed = []
  changed = false
  trimmed = File.readlines(file).map do |line|
    line.gsub!(/\r\n/, "\n") ? (changed = true) : nil
    line
  end
  open(file, "w") { |f| f.write(trimmed) } if changed
end

root = ARGV.first
files = File.directory?(root) ? Dir.glob("#{root}/**/*.{#{FILE_TYPES.join(',')}}") : [root]
files.each { |file| fix_line_end!(file) }

