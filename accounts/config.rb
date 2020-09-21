require 'core'

serializers = Dir["./app/layers/infra/events/serializers/*.rb"]
files = Dir["./app/layers/**/*.rb"]
libs = Dir["./lib/**/*.rb"]
all_files = (serializers + files + libs).uniq

all_files.each { |file| require file }
