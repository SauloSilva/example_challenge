module Infra
  module Events
    module Responders
      class AccountCreatorResponder < Karafka::BaseResponder
        topic :account_create, serializer: Infra::Events::Serializers::AccountCreateSerializer.new

        def respond(params)
          respond_to :account_create, params, partition_key: rand(1..999999).to_s
        end
      end
    end
  end
end
