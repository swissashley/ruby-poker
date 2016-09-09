require 'rspec'
require 'card'


describe Card do
  let(:one_card) { Card.new(10, :club) }
  it "has a face value" do
    expect(one_card.face_value).to eq(10)
  end
  it "has a suit" do
    expect(one_card.suit).to eq(:club)
  end
end
