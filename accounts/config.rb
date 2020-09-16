require 'core'

serializers = Dir["./app/layers/infra/events/serializers/*.rb"]
files = Dir["./app/layers/**/*.rb"]
all_files = (serializers + files).uniq

all_files.each { |file| require file }
