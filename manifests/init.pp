# == Class: spaarti
#
# Full description of class spaarti here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class spaarti (
  $codedir = "/Users/${::user}/src"
) {
  ruby_gem { 'spaarti':
    gem          => 'spaarti',
    ruby_version => '*'
  }
  -> file { "/Users/${::user}/.octoauth.d/spaarti.yml":
    content => template('spaarti/octoauth.yml'),
    mode    => '0600',
    require => Class['::dotfiles']
  }
  -> exec { 'spaarti':
    command  => "sudo -u ${::user} spaarti",
    user     => 'root',
    timeout  => 0,
    schedule => 'daily',
    require  => Class['::ssh']
  }
  -> exec { "/Users/${::user}/.bin/repo_sync":
    cwd      => $codedir,
    timeout  => 0,
    schedule => 'daily'
  }
}
