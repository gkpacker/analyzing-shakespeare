class Speech
  def initialize(speech)
    @speech = speech
  end

  def speaker
    grouped_elements['SPEAKER'].first.text
  end

  def lines
    grouped_elements['LINE'].map(&:text)
  end

  private

  attr_reader :speech

  def grouped_elements
    speech.elements.group_by(&:name)
  end
end

