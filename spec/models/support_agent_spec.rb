require 'rails_helper'

RSpec.describe SupportAgent, type: :model do

  describe 'Associations' do
     it { is_expected.to have_many(:requests) }
  end

end
