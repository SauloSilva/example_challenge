require 'spec_helper'

RSpec.describe Infra::Events::Models::TransactionCreate do
  let(:store) { AvroTurf::SchemaStore.new(path: Core.schemas_path) }

  let(:fields) do
    store.find('transaction_create').fields.map do |attr|
      {
        type: attr.type.type_sym,
        name: attr.name,
        default: attr.default
      }
    end
  end

  it '#check attrs of schemas' do
    expect(fields).to eq([
      { type: :record, name: "account", default: :no_default },
      { type: :int, name: "account_id", default: :no_default },
      { type: :string, name: "merchant", default: :no_default },
      { type: :int, name: "amount", default: :no_default },
      { type: :union, name: "time", default: :no_default }
    ])
  end
end
