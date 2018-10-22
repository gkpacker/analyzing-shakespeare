require_relative '../lib/speech'
require 'rexml/document'

describe Speech do
  let!(:speech) { described_class.new(speech_element) }

  describe '#speaker' do
    it 'returns the speech speaker' do
      expect(speech.speaker).to eq "First Witch"
    end
  end

  describe '#lines' do
    it 'returns speech lines' do
      expect(speech.lines.count).to eq 2
    end
  end

  def speech_element
    doc = REXML::Document.new <<SPEECH
      <SPEECH>
        <SPEAKER>First Witch</SPEAKER>
        <LINE>When shall we three meet again</LINE>
        <LINE>In thunder, lightning, or in rain?</LINE>
      </SPEECH>
SPEECH

    doc.elements.first
  end
end


