



class { 'mysql': }

class { 'mysql::server' :
  config_hash => { 'root_password' => 'alabama' },
  #subscribe => File['/etc/mysql/conf.d/gs-mysqld-lowercase-table-names_my.cnf'],

}


#mysql::config { 'basic_config':
#   settings=> "[mysqld]\nlower_case_table_names=1",
#}

mysql::db { 'globalsight':
  charset => 'utf8',
  user => 'globalsight',
  password => 'globalsight',
  host => 'localhost',
  grant => ['all'],
#  require => Class['mysql::server']  ,
  require => File['/root/.my.cnf']

}

file { '/etc/mysql/conf.d/gs-mysqld-lowercase-table-names_my.cnf':
   content => "[mysqld]\nlower_case_table_names=1",
   before=> Exec['mysqld-restart']
}


#package & service postfix
package { 'postfix':
      ensure => present,
      before => Service['postfix'],
    }

    service { 'postfix':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
#      subscribe  => File['/etc/ssh/sshd_config'],
    }
#user jboss
user { 'jboss':
   ensure=> 'present',
   home=>'/home/jboss'
}


package { 'openjdk-7-jdk':
  ensure=> present,

}

package { 'libdb-dev':
  ensure => present,

}

package { 'make':
 ensure => present,

}

package { 'gcc':
  ensure => present,

}


package { 'autoconf':
  ensure => present,

}

package { 'wget' :
 ensure => present,
}

package { 'nginx' :
 ensure => present,
}
