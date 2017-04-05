require './lib/account.rb'

describe Account do

  let(:person) {instance_double('Person', name: 'Ben')}
  subject { described_class.new({owner: person}) }

  it 'account should have a 4 digit pin code' do
    pin_length = Math.log10(subject.pin_code).to_i + 1
    expect(pin_length).to eq 4
  end

  it 'account should have a balance on 100 on initalize' do
    expect(subject.balance).to eq 0
  end

  it 'account should have a status of active' do
    expect(subject.account_status).to eq :active
  end

  xit 'account should have a status of deactivated' do
    expect(subject.account_status).to eq :deactivated
  end

  it 'is expected to have an expiry date on initialize' do
    expected_date = Date.today.next_year(5).strftime("%m/%y")
    expect(subject.exp_date).to eq expected_date
  end

  it 'is expected to have an owner' do
    expect(subject.owner).to eq person
  end

  it 'is expected to raise error if no owner is set' do
    expect { described_class.new }.to raise_error 'An account owner is required'
  end

end
