require_relative('../corrector')

describe Corrector do
  context 'Test corrector' do
    it 'Does the corrector correct string?' do
      expect(Corrector.new.correct_name('AFuhnASADufwYGhgkjhgiIUHUI')).to eq 'Afuhnasaduf'
    end
  end
end
