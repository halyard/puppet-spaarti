require 'spec_helper'

describe 'spaarti' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "spaarti class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('spaarti::params') }
          it { is_expected.to contain_class('spaarti::install').that_comes_before('spaarti::config') }
          it { is_expected.to contain_class('spaarti::config') }
          it { is_expected.to contain_class('spaarti::service').that_subscribes_to('spaarti::config') }

          it { is_expected.to contain_service('spaarti') }
          it { is_expected.to contain_package('spaarti').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'spaarti class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('spaarti') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
