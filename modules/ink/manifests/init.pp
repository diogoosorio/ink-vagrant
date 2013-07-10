class ink (
  $user = 'vagrant',
  $ink_repository = 'git@github.com:sapo/Ink.git',
  $ink_js_repository = 'git@github.com:sapo/Ink.js.git'
) {

  user {"${user}":
    ensure => "present",
    home => "/home/${user}",
    managehome => true,
    name => $user,
    provider => "useradd",
    shell => "/bin/bash"
  }

  host {'ink.local':
    ip => '127.0.0.1',
    host_aliases => ['ink.js.local']
  }

  file { "/workspace":
    ensure => "directory",
    owner => 'vagrant'
  }

  file {"/home/${user}/.ssh/known_hosts":
    owner => "vagrant",
    group => "vagrant",
    mode => 755,
    source => "puppet:///modules/ink/known_hosts",
    require => User["${user}"],
  }

  git::repo { 'Ink.js':
    path => '/workspace/ink.js',
    source => $ink_js_repository,
    owner => 'vagrant',
    require => [ User["${user}"], File["/home/${user}/.ssh/known_hosts"] ],
  }

  git::repo { 'Ink':
    path => '/workspace/ink',
    source => $ink_repository,
    owner => 'vagrant',
    branch => 'develop',
    require => [ User["${user}"], File["/home/${user}/.ssh/known_hosts"] ],
  }

  package {'apache2':
    ensure => 'latest'
  }

  service {'apache2':
    ensure => 'running',
    hasstatus => true,
    hasrestart => true,
    require => Package['apache2']
  }

  file {'ink.local.conf':
    ensure => 'file',
    source => 'puppet:///modules/ink/ink.local.conf',
    path => '/etc/apache2/sites-enabled/ink.local.conf',
    require => Package['apache2'],
    notify => Service['apache2']
  }

  file {'ink.js.local.conf':
    ensure => 'file',
    source => 'puppet:///modules/ink/ink.js.local.conf',
    path => '/etc/apache2/sites-enabled/ink.js.local.conf',
    require => Package['apache2'],
    notify => Service['apache2']
  }


  apt::pin {'lts-quantal':
    priority => 100
  }

  class {'nodejs':
    require => Apt::Pin['lts-quantal']
  }

  package {'yuidocjs':
    ensure => latest,
    provider => 'npm',
    require => Class['nodejs'],
  }

  package {'plato':
    ensure => latest,
    provider => 'npm',
    require => Class['nodejs'],
  }

  package {'uglify-js':
    ensure => latest,
    provider => 'npm',
    require => Class['nodejs'],
  }

  package {'async':
    ensure => latest,
    provider => 'npm',
    require => Class['nodejs'],
  }
}
