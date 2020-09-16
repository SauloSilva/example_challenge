module Idable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_id
    before_validation :records_initialization
  end

  def records_initialization
    self.records = [] if self.records.blank?
  end

  def generate_id
    self.id = self.records&.last&.id.to_i + 1
  end
end
