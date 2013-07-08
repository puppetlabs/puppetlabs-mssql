class mssql (
  # See http://msdn.microsoft.com/en-us/library/ms144259.aspx
  $media          = 'D:\\',
  $instancename   = 'MSSQLSERVER',
  $features       = 'SQL,AS,RS,IS',
  $agtsvcaccount  = 'SQLAGTSVC',
  $agtsvcpassword = 'Sql!@gt#2008demo',
  $assvcaccount   = 'SQLASSVC',
  $assvcpassword  = 'Sql!@s#2008demo',
  $rssvcaccount   = 'SQLRSSVC',
  $rssvcpassword  = 'Sql!Rs#2008demo',
  $sqlsvcaccount  = 'SQLSVC',
  $sqlsvcpassword = 'Sql!#2008demo',
  $instancedir    = "C:\\Program Files\\Microsoft SQL Server",
  $ascollation    = 'Latin1_General_CI_AS',
  $sqlcollation   = 'SQL_Latin1_General_CP1_CI_AS',
  $admin          = 'Administrator'
) {

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
