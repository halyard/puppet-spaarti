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
) {
  ruby_gem { 'spaarti':
    gem          => 'spaarti',
    ruby_version => '*'
  } ->
  file { "/Users/${::boxen_user}/.octoauth.d/spaarti.yml":
    content => template('spaarti/octoauth.yml'),
    mode    => '0600',
    require  => Class['::dotfiles']
  } ->
  exec { 'spaarti':
    timeout => 0
  } ->
  exec { "/Users/${::boxen_user}/.bin/repo_sync":
    cwd     => $::boxen_srcdir,
    timeout => 0
  }
}
