require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :number}
    it {should validate_presence_of :date}
    it {should validate_presence_of :time}
    it {should validate_presence_of :arrival_city}
    it {should validate_presence_of :departure_city}
  end

  describe 'Relationships' do
    it {should belong_to :airline}
  end
end
