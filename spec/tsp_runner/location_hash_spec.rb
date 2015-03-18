module TspRunner
  describe LocationHash do
    describe '.from_file' do
      subject { LocationHash.from_file(filename) }

      let(:filename) do
        File.join(File.dirname(__FILE__), '..', 'fixtures', 'files',
                  'sample_input.csv')
      end

      it 'adds an entry for each line' do
        expect(subject.location_names.length).to eq(10)
        expect(subject.location_names).to match_array(%w[
          Philadelphia
          San\ Antonio
          San\ Diego
          Dallas
          San\ Francisco
          Milwaukee
          Tampa
          Kansas\ City
          Cleveland
          New\ Orleans
        ])
      end

      it 'adds the location for a specific city' do
        location = subject['Tampa']
        expect(location.name).to eq('Tampa')
        expect(location.lat).to eq(27.99679690746927)
        expect(location.lon).to eq(-82.44546311098391)
      end
    end
  end
end