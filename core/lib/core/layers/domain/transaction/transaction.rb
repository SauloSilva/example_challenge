require File.join(File.expand_path('../..', __FILE__), 'concern', 'idable')

module Domain
  module Transaction
    class Transaction < ActiveRecord::Base
      include Idable

      mattr_accessor :records

      validates :merchant, :amount, :time, presence: true
      validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
      validate :reached_credit_limit, :card_not_active, :high_frequency, :double_transaction

      scope :same_account, ->(ac_id) do
        Domain::Transaction::Transaction.records.select { |record| record.account_id == ac_id }
      end

      belongs_to :account, class_name: 'Domain::Account::Account', required: true

      def save
        return unless valid?

        self.records << self
        account.update_limit amount

        self.records.last
      end

      private

      def reached_credit_limit
        errors.add(:transaction, 'insufficient limit') if insufficient_limit?
      end

      def card_not_active
        errors.add(:transaction, 'card not active') unless account&.active_card?
      end

      def high_frequency
        errors.add(:transaction, 'high frequency small interval') if two_minutes_cover.count == 3
      end

      def double_transaction
        errors.add(:transaction, 'double transaction') if same_merchant_and_amount.count == 1
      end

      def insufficient_limit?
        (account&.available_limit.to_i - amount.to_i).negative?
      end

      def same_merchant_and_amount
        two_minutes_cover.select do |s|
          s.merchant == merchant && s.amount == amount
        end
      end

      def timeframe
        2.minutes
      end

      def time_range
        two_minutes_ago = time - timeframe
        two_minutes_from_now = time + timeframe

        (two_minutes_ago..two_minutes_from_now)
      end

      def two_minutes_cover
        self.class.same_account(account_id).select do |record|
          time_range.cover?(record.time)
        end
      end
    end
  end
end
