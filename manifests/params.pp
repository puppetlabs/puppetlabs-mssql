# == class: mssql::params
#
# This class manages MSSQL paraameters
#
# == Paramaters
#
# $instancename
# $features
# $agtsvcaccount
# $agtsvcpassword
# $assvcaccount
# $assvcpassword
# $rssvcaccount
# $rssvcpassword
# $sqlsvcaccount
# $sqlsvcpassword
# $instancedir
# $ascollation
# $sqlcollation
# $admin
#
class mssql::params {
  $instancename   = 'MSSQLSERVER'
  $features       = 'SQL,AS,RS,IS'
  $agtsvcaccount  = 'SQLAGTSVC'
  $agtsvcpassword = 'Sql!@gt#2008demo'
  $assvcaccount   = 'SQLASSVC'
  $assvcpassword  = 'Sql!@s#2008demo'
  $rssvcaccount   = 'SQLRSSVC'
  $rssvcpassword  = 'Sql!Rs#2008demo'
  $sqlsvcaccount  = 'SQLSVC'
  $sqlsvcpassword = 'Sql!#2008demo'
  $instancedir    = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Binn\sqlservr.exe'
  $ascollation    = 'Latin1_General_CI_AS'
  $sqlcollation   = 'SQL_Latin1_General_CP1_CI_AS'
  $admin          = 'Administrator'
}
