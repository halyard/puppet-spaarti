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
  exec { 'spaarti':
    require => Class['::dotfiles']
  } ->
  exec { 'repo_sync':
    cwd => $::boxen_srcdir
  }
}
