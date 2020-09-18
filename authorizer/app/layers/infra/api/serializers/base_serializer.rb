module Infra
  module Api
    module Serializers
      class BaseSerializer
        def violations
          map_violations
        end

        private

        def map_violations
          repository.errors.messages.map do |key, values|
            join_key_with_values_error(key, values)
          end.flatten
        end

        def join_key_with_values_error(key, values)
          values.map do |value|
            "#{key}-#{value.gsub(' ', '-')}"
          end
        end
      end
    end
  end
end
