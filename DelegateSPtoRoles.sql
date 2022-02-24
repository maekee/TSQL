#This T-SQL creates two AD group Logins, one for executing GET (SELECT) stored procedures and one write that gets to executes all stored procedures
#Then Roles are created, where the reader role gets GRANT EXECUTE on only GET stored procedures, and then the write role that gets EXECUTE on all.
#If there are more GET (SELECT) stored procedures, add them to the list under the 'Read Role'

#This is a better alternative than giving permissions on tables, this way we can control what can be done against the tables with stored procedures.
#Good to know if you use SSRS reports that have T-SQL these will stop working here, stored procedures (with or without stored procedures) needs to be created also.

-- Create Logins for Roles
USE [master];
GO
CREATE LOGIN [DOMAIN\ADGroupName-Read] FROM WINDOWS WITH DEFAULT_DATABASE=[master];
CREATE LOGIN [DOMAIN\ADGroupName-Write] FROM WINDOWS WITH DEFAULT_DATABASE=[master];
GO

-- Read Role
USE [DATABASENAMEHERE];
GO
CREATE ROLE [SQLROLENAME-ExecRead]
ALTER ROLE [SQLROLENAME-ExecRead] ADD MEMBER [DOMAIN\ADGroupName-Read]
GO
GRANT EXECUTE ON [dbo].[GETSTOREPROCEDURENAME1HERE] TO [SQLROLENAME-ExecRead]
GRANT EXECUTE ON [dbo].[GETSTOREPROCEDURENAME2HERE] TO [SQLROLENAME-ExecRead]

-- Writer Role
USE [DATABASENAMEHERE];
GO
CREATE ROLE [SQLROLENAME_ExecAll_SP];
ALTER ROLE [SQLROLENAME_ExecAll_SP] ADD MEMBER [DOMAIN\ADGroupName-Write]
GRANT EXECUTE TO [SQLROLENAME_ExecAll_SP]
