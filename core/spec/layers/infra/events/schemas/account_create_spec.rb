require 'spec_helper'

RSpec.describe Infra::Events::Models::AccountCreate do
  let(:store) { AvroTurf::SchemaStore.new(path: Core.schemas_path) }

  let(:fields) do
    store.find('account_create').fields.map do |attr|
      {
        type: attr.type.type_sym,
        name: attr.name,
        default: attr.default
      }
    end
  end

  it '#check attrs of schemas' do
    expect(fields).to eq([
      { type: :int, name: 'available_limit', default: :no_default },
      { type: :boolean, name: 'active_card', default: :no_default }
    ])
  end
end
