
class { 'mysql': }

class { 'mysql::server' :
  config_hash => { 'root_password' => 'alabama' }
}

mysql::db { 'globalsight':
  charset => 'utf8',
  user => 'globalsight',
  password => 'globalsight',
  host => 'localhost',
  grant => ['all'],
}


