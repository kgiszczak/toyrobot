require 'bundler/setup'

lib = File.expand_path('lib', File.dirname(__FILE__))
$:.unshift(lib) unless $:.include?(lib)

require 'runner'

File.read(File.expand_path('test_data.txt', File.dirname(__FILE__))).each_line do |line|
  puts "Input: #{line}"
  Runner.new(line).run
  puts '------------'
end
