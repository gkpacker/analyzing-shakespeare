require 'open-uri'
require 'rexml/document'
require_relative 'analyzer_view'
require_relative 'speech'

class Analyzer
  attr_reader :url, :speech_path, :ignored

  def initialize(args = {})
    params = {
      text: 'macbeth',
      view: AnalyzerView.new,
      ignored: ['ALL'],
      speech_path: "PLAY/ACT/SCENE/SPEECH"
    }.merge(args)

    @view = params[:view]
    @url = "http://www.ibiblio.org/xml/examples/shakespeare/#{params[:text]}.xml"
    @ignored = params[:ignored]
    @speech_path = params[:speech_path]
  end

  def analyze
    result = Hash.new(0)
    each_element do |element|
      speech = Speech.new(element)
      next if @ignored.include?(speech.speaker)

      result[speech.speaker] += speech.lines.count
    end
    sorted_results = result.sort_by { |_speaker, count| count }.reverse
    sorted_results.each { |speaker, count| @view.display_counter(count, speaker) }

    result
  end

  private

  def each_element(&block)
    xml_doc.elements.each(speech_path, &block)
  end

  def xml_doc
    REXML::Document.new(text_xml)
  end

  def text_xml
    URI.parse(url).read
  end
end

