module Infra
  module Events
    module Serializers
      class AccountCreateSerializer < Infra::Events::Serializer
        def schema_name
          'account_create'
        end

        def attributes(params)
          Infra::Events::Models::AccountCreate.new(params.deep_symbolize_keys).to_h
        end
      end
    end
  end
end
