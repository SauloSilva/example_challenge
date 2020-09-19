require File.join(Core.root, 'lib', 'core', 'layers', 'infra', 'events', 'models', 'base')

module Infra
  module Events
    module Models
      class AccountCreate < Base
        attribute :available_limit, Types::Integer
        attribute :active_card, Types::Bool
      end
    end
  end
end
