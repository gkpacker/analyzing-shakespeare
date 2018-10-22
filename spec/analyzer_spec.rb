require_relative '../lib/analyzer'
require 'byebug'

describe Analyzer do
  describe '#analyze' do
    it "ignores 'ALL' and macbeth's speeches" do
      analyzer = Analyzer.new(ignored: ['ALL', 'MACBETH'])
      results = analyzer.analyze

      expect(results['MACBETH']).to be_zero
      expect(results['ALL']).to be_zero
    end

    context 'when lear' do
      before do
        fixture_file = File.expand_path("../../spec/fixtures/lear.xml", __FILE__)
        allow(URI).to receive_message_chain(:parse, :read).and_return(File.new(fixture_file))
      end

      it 'returns lines spoken per speaker' do
        analyzer = Analyzer.new(text: 'lean')
        results = analyzer.analyze

        expect(results["KENT"]).to eq(369)
        expect(results["GLOUCESTER"]).to eq(342)
        expect(results["EDMUND"]).to eq(315)
        expect(results["KING LEAR"]).to eq(752)
        expect(results["LEAR"]).to eq(6)
        expect(results["ALL"]).to be_zero
      end
    end

    context 'when macbeth' do
      before do
        fixture_file = File.expand_path("../../spec/fixtures/macbeth.xml", __FILE__)
        allow(URI).to receive_message_chain(:parse, :read).and_return(File.new(fixture_file))
      end

      it 'returns lines spoken per speaker' do
        analyzer = Analyzer.new
        results = analyzer.analyze

        expect(results["MACBETH"]).to eq(719)
        expect(results["BANQUO"]).to eq(113)
        expect(results["DUNCAN"]).to eq(70)
        expect(results["ALL"]).to be_zero
      end
    end
  end
end
