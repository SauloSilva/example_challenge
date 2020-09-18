module Infra
  module Events
    module Responders
      class TransactionCreatorResponder < Karafka::BaseResponder
        topic :transaction_create, serializer: Infra::Events::Serializers::TransactionCreateSerializer.new

        def respond(params)
          respond_to :transaction_create, params, partition_key: rand(1..999999).to_s
        end
      end
    end
  end
end
