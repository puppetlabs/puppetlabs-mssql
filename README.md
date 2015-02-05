#mssql

* This module is no longer maintained and has been replaced by
 [Enterprise SQLServer](https://forge.puppetlabs.com/puppetlabs/sqlserver)

This module installs Microsoft SQL Server 2008R2 on Windows 2008R2.

## Installation

This module depends on DISM module to enable .net 3.5 on Windows Server:

* [dism module](http://forge.puppetlabs.com/puppetlabs/dism)

## Configuration

The installer support the following options:

    media          = 'D:\\',
    instancename   = 'MSSQLSERVER',
    features       = 'SQL,AS,RS,IS',
    agtsvcaccount  = 'SQLAGTSVC',
    agtsvcpassword = 'sqlagtsvc2008demo',
    assvcaccount   = 'SQLASSVC',
    assvcpassword  = 'sqlassvc2008demo',
    rssvcaccount   = 'SQLRSSVC',
    rssvcpassword  = 'sqlrssvc2008demo',
    sqlsvcaccount  = 'SQLSVC',
    sqlsvcpassword = 'sqlsvc2008demo',
    instancedir    = "C:\\Program Files\\Microsoft SQL Server",
    ascollation    = 'Latin1_General_CI_AS',
    sqlcollation   = 'SQL_Latin1_General_CP1_CI_AS',
    admin          = 'Administrator'

See http://msdn.microsoft.com/en-us/library/ms144259.aspx for more information about these options.
