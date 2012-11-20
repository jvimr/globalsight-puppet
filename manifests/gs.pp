



class { 'mysql': }

class { 'mysql::server' :
  config_hash => { 'root_password' => 'alabama' }

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
  require => Class['mysql::server']  ,
}

file { '/etc/mysql/conf.d/gs-mysqld-lowercase-table-names_my.cnf':
   require => Package['mysql-server'],
   content => "[mysqld]\nlower_case_table_names=1",
}
