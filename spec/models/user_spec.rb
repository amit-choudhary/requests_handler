require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_inclusion_of(:type).in_array(%w(Customer Admin SupportAgent)) }
  end

end
