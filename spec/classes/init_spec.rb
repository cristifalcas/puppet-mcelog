require 'spec_helper'
describe 'mcelog' do

  context 'with defaults for all parameters' do
    it { should contain_class('mcelog') }
  end
end
