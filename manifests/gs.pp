



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
 before => Exec["./configure-ldap"],
}


package { 'autoconf':
  ensure => present,

}


package { 'nginx' :
 ensure => present,
}

package { 'wget':
 ensure => present,
}

exec { "getopenldap":
      command => "wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.33.tgz",
      cwd => "/tmp/",
	path=> '/usr/bin'
}

exec { "untaropenldap":
       command => '/bin/tar -xzf openldap-2.4.33.tgz',
       cwd => "/tmp/",
       require => Exec["getopenldap"],
	creates => '/tmp/openldap-2.4.33/',
 }

exec { "./configure-ldap":
      command => '/tmp/openldap-2.4.33/configure --prefix=/usr/local/openldap',
      cwd => "/tmp/openldap-2.4.33/",
	creates => '/tmp/openldap-2.4.33/Makefile',      
      require => Exec["untaropenldap"]
}

exec { 'make_dep_openldap':
  command => 'make depend',
  cwd => "/tmp/openldap-2.4.33/",
  require => Exec['./configure-ldap'],
  path => '/bin:/usr/bin:/usr/local/bin'
}


exec { 'make_openldap':
  command => 'make -j2',
  timeout => '1000',
  cwd => "/tmp/openldap-2.4.33/",
  require => Exec['make_dep_openldap'],
  path => '/bin:/usr/bin:/usr/local/bin'
}


exec { 'make_install_openldap':
  command => 'make install',
  cwd => "/tmp/openldap-2.4.33/",
  require => Exec['make_openldap'],
  path => '/bin:/usr/bin:/usr/local/bin'
}

