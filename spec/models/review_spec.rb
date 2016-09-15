require 'rails_helper'

RSpec.describe Review, type: :model do

  it { should have_valid(:name).when "Red Robin", "Chipotle", "Chick-Fil-A"}
  it { should_not have_valid(:name).when(nil, "") }
end
