module Domain
  module Account
    class Account < ActiveRecord::Base
      include Idable

      mattr_accessor :records

      validates :available_limit, presence: true
      validates :available_limit, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
      validates :active_card, inclusion: { in: [true, false] }
      validate :already_exists

      has_many :transactions, class_name: 'Domain::Transaction::Transaction'

      def save
        if valid?
          self.records << self
          self.records.last
        end
      end

      def update_limit(amount)
        self.available_limit -= amount.to_i.abs
      end

      private

      def already_exists
        errors.add(:account, 'already initialized') if self.records.present?
      end
    end
  end
end
