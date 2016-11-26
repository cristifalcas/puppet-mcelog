require 'spec_helper'

describe 'mcelog' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({:is_virtual => false})
        end

        context "mcelog class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('mcelog::params') }
          it { is_expected.to contain_class('mcelog::install').that_comes_before('Class[mcelog::config]') }
          it { is_expected.to contain_class('mcelog::config') }
          it { is_expected.to contain_class('mcelog::service').that_subscribes_to('Class[mcelog::config]') }
          it { is_expected.to contain_package('mcelog').with_ensure('latest') }
        end
      end
    end
  end
end
