require_relative '../lib/analyzer_view'

describe AnalyzerView do
  describe '#display_counter' do
    it 'output counter to stdout' do
      expect{ subject.display_counter(3, 'such speaker') }.to output("3 - such speaker\n").to_stdout
    end
  end
end
