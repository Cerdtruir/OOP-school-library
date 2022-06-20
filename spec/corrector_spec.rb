require_relative('../corrector')

describe Corrector do
  context 'When using the corrector' do
    it 'corrects the string?' do
      expect(Corrector.new.correct_name('AFuhnASADufwYGhgkjhgiIUHUI')).to eq 'Afuhnasaduf'
    end
  end
end
