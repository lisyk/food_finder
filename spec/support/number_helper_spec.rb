require 'support/number_helper'

describe 'NumberHelper' do
  include NumberHelper

  describe '#number_to_currency' do
      context 'using default values' do

          it 'correctly formats an integer' do
            expect(number_to_currency(2000)).to eq('$2,000.00')
          end

          it 'correctly formats a float' do
            expect(number_to_currency(22.5)).to eq('$22.50')
          end

          it 'correctly formats a string' do
            expect(number_to_currency('333')).to eq('$333.00')
          end

          it 'uses delimiters for very large numbers' do
            expect(number_to_currency(2000000)).to eq('$2,000,000.00')
          end

          it 'does not have delimiters for small numbers' do
            expect(number_to_currency(20)).to eq('$20.00')
          end
      end

      context 'using custom options' do

          it 'allows changing the :unit' do
            expect(number_to_currency(20, unit: '@')).to eq('@20.00')
          end

          it 'allows changing the :precision' do
            expect(number_to_currency(100, precision: 4)).to eq('$100.0000')
          end

          it 'omits the separator if :precision is 0' do
            expect(number_to_currency(30, precision: 0)).to eq('$30')
          end

          it 'allows changing the :delimiter' do
            expect(number_to_currency(1000000, delimiter: "_")).to eq('$1_000_000.00')

          end

          it 'allows changing the :separator' do
            expect(number_to_currency(10.50, separator: "%")).to eq('$10%50')

          end

          it 'correctly formats using multiple options' do
            expect(number_to_currency(1000000.50, unit: "#", precision: 4, delimiter: "_", separator: ",")).to eq('#1_000_000,5000')

          end

      end

  end

end
