require 'restaurant'

describe Restaurant do

  describe 'attributes' do

    it 'allow reading and writing for :name' do
      subject.name = 'Tamale'
      expect(subject.name).to eq('Tamale')

    end

    it 'allow reading and writing from :cuisine' do
      subject.cuisine = 'Mexa'
      expect(subject.cuisine).to eq('Mexa')

    end

    it 'allow reading and writing from :price' do
      subject.price = 100
      expect(subject.price).to eq(100)

    end

  end

  describe '#initialize' do
    context 'with no options' do
      # subject would return the same thing
      let(:no_options) { Restaurant.new }

      it 'sets a default of "" for :name' do
        expect(subject.name).to eq("")

      end

      it 'sets a default of "unknown" for :cuisine' do
        expect(subject.cuisine).to eq("")

      end

      it 'set a default for :price' do
        expect(no_options.price).to eq("")

      end
    end

    context 'with custom options' do
      let(:with_options) {Restaurant.new(name: "Liska", cuisine: 'Ukrainian', price: "100")}

      it 'allows setting the :name' do
        expect(with_options.name).to eq("Liska")

      end

      it 'allows setting the :cuisine' do
        expect(with_options.cuisine).to eq("Ukrainian")

      end

      it 'allows setting the :price' do
        expect(with_options.price).to eq("100")

      end

    end

  end

end
