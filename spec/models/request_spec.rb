require 'rails_helper'

RSpec.describe Request, type: :model do

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:subject) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:customer) }
  end

  describe 'Associations' do
     it { is_expected.to belong_to(:customer) }
     it { is_expected.to belong_to(:support_agent) }
  end

end
