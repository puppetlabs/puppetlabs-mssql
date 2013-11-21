# == class: MSSQL
#
# == Parameters
#
# $media
# location of installation files.  This is a required parameter, because
# without it, how can we install SQL server?
#
# == Authors
#
# PuppetLabs
#
class mssql (
  # See http://msdn.microsoft.com/en-us/library/ms144259.aspx
  # Media is required to install
  $media,
  $instancename   = $mssql::params::instancename,
  $features       = $mssql::params::features,
  $agtsvcaccount  = $mssql::params::agtsvcaccount,
  $agtsvcpassword = $mssql::params::agtsvcpassword,
  $assvcaccount   = $mssql::params::assvcaccount,
  $assvcpassword  = $mssql::params::assvcpassword,
  $rssvcaccount   = $mssql::params::rssvcaccount,
  $rssvcpassword  = $mssql::params::rssvcpassword,
  $sqlsvcaccount  = $mssql::params::sqlsvcaccount,
  $sqlsvcpassword = $mssql::params::sqlsvcpassword,
  $instancedir    = $mssql::params::instancedir,
  $ascollation    = $mssql::params::ascollation,
  $sqlcollation   = $mssql::params::sqlcollation,
  $admin          = $mssql::params::admin,
) inherits mssql::params {

  # validation
  validate_string($media)
  validate_string($instancename)
  validate_string($features)
  validate_string($agtsvcaccount)
  validate_string($agtsvcpassword)
  validate_string($assvcaccount)
  validate_string($assvcpassword)
  validate_string($rssvcaccount)
  validate_string($rssvcpassword)
  validate_string($sqlsvcaccount)
  validate_string($sqlsvcpassword)
  validate_string($instancedir)
  validate_string($ascollation)
  validate_string($sqlcollation)
  validate_string($admin)

  User {
    ensure   => present,
    before => Exec['install_mssql2008'],
  }

  user { 'SQLAGTSVC':
    comment  => 'SQL 2008 Agent Service.',
    password => $agtsvcpassword,
  }
  user { 'SQLASSVC':
    comment  => 'SQL 2008 Analysis Service.',
    password => $assvcpassword,
  }
  user { 'SQLRSSVC':
    comment  => 'SQL 2008 Report Service.',
    password => $rssvcpassword,
  }
  user { 'SQLSVC':
    comment  => 'SQL 2008 Service.',
    groups   => 'Administrators',
    password => $sqlsvcpassword,
  }

  file { 'C:\sql2008install.ini':
    content => template('mssql/config.ini.erb'),
  }

  dism { 'NetFx3':
    ensure => present,
  }

  exec { 'install_mssql2008':
    command   => "${media}\\setup.exe /Action=Install /IACCEPTSQLSERVERLICENSETERMS /QS /CONFIGURATIONFILE=C:\\sql2008install.ini /SQLSVCPASSWORD=\"${sqlsvcpassword}\" /AGTSVCPASSWORD=\"${agtsvcpassword}\" /ASSVCPASSWORD=\"${assvcpassword}\" /RSSVCPASSWORD=\"${rssvcpassword}\"",
    cwd       => $media,
    path      => $media,
    logoutput => true,
    creates   => $instancedir,
    timeout   => 1200,
    require   => [ File['C:\sql2008install.ini'],
                   Dism['NetFx3'] ],
  }
}
