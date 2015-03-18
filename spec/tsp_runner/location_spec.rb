module TspRunner
  describe Location do
    describe '#distance_from' do
      subject { Location.new('Subject', 46.3625, 15.114444) }

      let(:same_lat) { Location.new('Same Lat', 46.3625, 17.23487) }
      let(:same_lon) { Location.new('Same Lon', 21.39499, 15.114444) }
      let(:nearby)   { Location.new('Nearby', 46.36253, 15.1144438) }
      let(:middle)   { Location.new('Middle', 46.055556, 14.508333) }
      let(:faraway)  { Location.new('Farwawy', -37.7833083, -122.416749) }

      it 'calculates the distance from itself to be 0' do
        expect(subject.distance_from(subject)).to eq(0)
      end

      it 'calculates locations with the same latitude' do
        expected_distance = 162705.77332198387
        expect(subject.distance_from(same_lat))
          .to be_within(0.000001).of(expected_distance)
      end

      it 'calculates locations with the same longitude' do
        expected_distance = 2776260.442947286
        expect(subject.distance_from(same_lon))
          .to be_within(0.000001).of(expected_distance)
      end

      it 'calculates nearby locations' do
        expected_distance = 3.3358831024098943
        expect(subject.distance_from(nearby))
          .to be_within(0.000001).of(expected_distance)
      end

      it 'calculates not too close, but not too far distances' do
        expected_distance = 57794.35510874037
        expect(subject.distance_from(middle))
          .to be_within(0.000001).of(expected_distance)
      end

      it 'calculates faraway locations' do
        expected_distance = 16428971.274199924
        expect(subject.distance_from(faraway))
          .to be_within(0.000001).of(expected_distance)
      end

      it 'obeys the symmetric property' do
        expect(subject.distance_from(middle))
          .to be_within(0.000001).of(middle.distance_from(subject))
      end
    end
  end
end
