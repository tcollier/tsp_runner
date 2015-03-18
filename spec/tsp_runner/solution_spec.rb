module TspRunner
  class Solution
    describe '.from_file' do
      subject { Solution.from_file(filename, location_hash) }

      let(:location_hash) { LocationHash.new }
      let(:filename) do
        File.join(File.dirname(__FILE__), '..', 'fixtures', 'files',
                  'sample_solution.txt')
      end

      it 'adds an entry for each line' do
        expect(subject.location_names.length).to eq(10)
        expect(subject.location_names).to eq(%w[
          San\ Francisco
          Philadelphia
          San\ Antonio
          San\ Diego
          Dallas
          Milwaukee
          Tampa
          Kansas\ City
          Cleveland
          New\ Orleans
        ])
      end
    end

    describe '#valid?' do
      subject do
        Solution.new(location_hash).tap do |solution|
          location_names.each { |location_name| solution << location_name }
        end
      end

      let(:location_hash)  { LocationHash.new }
      let(:location_names) { Array.new(rand(2..10)) { Faker::Address.city } }

      before do
        location_hash.stubs(:location_names).returns(location_names.shuffle)
      end

      context 'when each location name is present once' do
        it 'returns true' do
          expect(subject).to be_valid
        end

        context 'and the first location is the initial_location_name' do
          it 'returns true' do
            expect(subject).to be_valid(location_names.first)
          end
        end

        context 'and the first location is not the initial_location_name' do
          it 'returns false' do
            expect(subject).to_not be_valid(location_names[1..-1].sample)
          end
        end
      end

      context 'when a location name is present twice' do
        before { subject << location_names.sample }

        it 'returns false' do
          expect(subject).to_not be_valid
        end
      end

      context 'when a location name not found in the input is present' do
        before { subject << Faker::Lorem.words.first }

        it 'returns false' do
          expect(subject).to_not be_valid
        end
      end

      context 'when a location name is missing' do
        before do
          location_hash.stubs(:location_names)
            .returns((location_names + [Faker::Lorem.words.first]).shuffle)
        end

        it 'returns false' do
          expect(subject).to_not be_valid
        end
      end
    end

    describe '#total_distance' do
      subject { Solution.new(location_hash) }

      let(:locations) { Array.new(rand(4..20)) { build(:location) } }
      let(:location_hash) do
        LocationHash.new.tap do |hash|
          locations.each { |location| hash << location }
        end
      end

      before { locations.each { |location| subject << location.name } }

      it 'sums the distance of each edge' do
        expected_distance = 0
        locations[0..-2].each.with_index do |location, index|
          expected_distance += location.distance_from(locations[index + 1])
        end
        expected_distance += locations.last.distance_from(locations.first)
        expect(subject.total_distance)
          .to be_within(0.000001).of(expected_distance)
      end
    end
  end
end