USE [master]
GO
/****** Object:  Database [LSProject]    Script Date: 2019/8/11 12:26:47 ******/
CREATE DATABASE [LSProject]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LSProject', FILENAME = N'G:\data\LSProject.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LSProject_log', FILENAME = N'G:\data\LSProject_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [LSProject] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LSProject].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LSProject] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LSProject] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LSProject] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LSProject] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LSProject] SET ARITHABORT OFF 
GO
ALTER DATABASE [LSProject] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LSProject] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LSProject] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LSProject] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LSProject] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LSProject] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LSProject] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LSProject] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LSProject] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LSProject] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LSProject] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LSProject] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LSProject] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LSProject] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LSProject] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LSProject] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LSProject] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LSProject] SET RECOVERY FULL 
GO
ALTER DATABASE [LSProject] SET  MULTI_USER 
GO
ALTER DATABASE [LSProject] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LSProject] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LSProject] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LSProject] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LSProject] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'LSProject', N'ON'
GO
ALTER DATABASE [LSProject] SET QUERY_STORE = OFF
GO
USE [LSProject]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [LSProject]
GO
/****** Object:  UserDefinedFunction [dbo].[f_menufunction]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  function  [dbo].[f_menufunction](
@menucode varchar(20)
) 
returns varchar(8000)
as
begin
  declare @strfuncode varchar(300)
  declare @funcode varchar(20)
  set @strfuncode=''

  declare funcur cursor
  for 
  select A.funcode from sys_menufunction A join sys_function  B
  on  A.funcode=B.funcode where A.menucode=@menucode

  open funcur
  fetch next  from funcur into @funcode
  while  @@FETCH_STATUS=0
  begin
  if(@strfuncode='')
  set @strfuncode=@funcode
  else
  set @strfuncode=@strfuncode+','+@funcode
  fetch next  from funcur into @funcode
  end
 return @strfuncode
end
GO
/****** Object:  UserDefinedFunction [dbo].[f_organizerole]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  function  [dbo].[f_organizerole](  
@orgcode varchar(20)  
)   
returns varchar(8000)  
as  
begin  
  declare @strfuncode varchar(300)  
  declare @funcode varchar(30)  
  set @strfuncode=''  
  
  declare funcur cursor  
  for   
  select B.rolename from sys_organizerole A join sys_role  B  
  on  A.rolecode=B.rolecode where A.orgcode=@orgcode  
  
  open funcur  
  fetch next  from funcur into @funcode  
  while  @@FETCH_STATUS=0  
  begin  
  if(@strfuncode='')  
  set @strfuncode=@funcode  
  else  
  set @strfuncode=@strfuncode+','+@funcode  
  fetch next  from funcur into @funcode  
  end  
 return @strfuncode  
end
GO
/****** Object:  Table [dbo].[sys_dictionary]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_dictionary](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dcode] [varchar](30) NOT NULL,
	[parentcode] [varchar](30) NULL,
	[dname] [nvarchar](20) NULL,
	[dseq] [int] NULL,
	[isenable] [bit] NULL,
	[dictype] [varchar](20) NULL,
	[remark] [nvarchar](200) NULL,
	[createby] [varchar](36) NULL,
	[createdate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_function]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_function](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[funcode] [varchar](20) NOT NULL,
	[funname] [nvarchar](20) NOT NULL,
	[funseq] [int] NULL,
	[funicon] [varchar](50) NULL,
	[remark] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_logs]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_logs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[logtype] [int] NULL,
	[logsource] [varchar](100) NULL,
	[logmsg] [nvarchar](500) NULL,
	[createtime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_menu]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_menu](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[menucode] [varchar](100) NOT NULL,
	[parentcode] [varchar](100) NULL,
	[menuname] [nvarchar](50) NOT NULL,
	[menuurl] [varchar](200) NULL,
	[menuicon] [varchar](50) NULL,
	[menuseq] [int] NULL,
	[isvisible] [bit] NULL,
	[isenable] [bit] NULL,
	[menulevel] [int] NULL,
	[createby] [varchar](36) NULL,
	[createdate] [datetime] NULL,
	[remark] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_menufunction]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_menufunction](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[menucode] [varchar](100) NOT NULL,
	[funcode] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_organize]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_organize](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orgcode] [varchar](100) NOT NULL,
	[orgname] [nvarchar](50) NOT NULL,
	[parentcode] [varchar](100) NULL,
	[orgseq] [int] NULL,
	[isdel] [bit] NULL,
	[remark] [nvarchar](100) NULL,
	[createby] [varchar](36) NULL,
	[createdate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_organizerole]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_organizerole](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orgcode] [varchar](100) NOT NULL,
	[rolecode] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_organizeuser]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_organizeuser](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orgcode] [varchar](100) NOT NULL,
	[usercode] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_role]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rolecode] [varchar](100) NOT NULL,
	[rolename] [nvarchar](50) NOT NULL,
	[roleseq] [int] NULL,
	[remark] [nvarchar](100) NULL,
	[createby] [varchar](36) NULL,
	[createdate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_rolemenu]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_rolemenu](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[menucode] [varchar](100) NOT NULL,
	[rolecode] [varchar](100) NOT NULL,
	[funcode] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_user]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[usercode] [varchar](100) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[userpwd] [varchar](100) NOT NULL,
	[rolenames] [nvarchar](200) NULL,
	[orgnames] [nvarchar](200) NULL,
	[configjson] [nvarchar](4000) NULL,
	[isenable] [bit] NULL,
	[createby] [varchar](36) NULL,
	[createdate] [datetime] NULL,
	[jobcode] [varchar](20) NULL,
	[positions] [varchar](20) NULL,
	[jobcodeName] [nvarchar](20) NULL,
	[positionsName] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_userinfo]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_userinfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[usercode] [varchar](100) NOT NULL,
	[realname] [nvarchar](100) NOT NULL,
	[sex] [char](1) NULL,
	[birthdate] [datetime] NULL,
	[nation] [nvarchar](10) NULL,
	[political] [nvarchar](10) NULL,
	[maritalstatus] [char](1) NULL,
	[presentaddress] [nvarchar](100) NULL,
	[placeorigin] [nvarchar](100) NULL,
	[education] [nvarchar](10) NULL,
	[university] [nvarchar](50) NULL,
	[specialty] [nvarchar](50) NULL,
	[hobby] [nvarchar](200) NULL,
	[perspecialty] [nvarchar](200) NULL,
	[comprehensive] [nvarchar](200) NULL,
	[telephone] [varchar](11) NULL,
	[email] [varchar](30) NULL,
	[photo] [varchar](50) NULL,
	[selfevaluation] [nvarchar](200) NULL,
	[createby] [varchar](36) NULL,
	[createdate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_userresume]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_userresume](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[usercode] [varchar](100) NULL,
	[retype] [int] NULL,
	[beginendyear] [nvarchar](50) NULL,
	[content] [nvarchar](100) NULL,
	[majorduty] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sys_userrole]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_userrole](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[usercode] [varchar](100) NOT NULL,
	[rolecode] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[p_getcoreI]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc  [dbo].[p_getcoreI]
(
@displayName varchar(50),--实际class名称
@dispalyDescription varchar(50)='' --类注释名称如XX管理
)
as
begin 

print 'using LS.Entitys;'
print 'using System;'
print 'using System.Collections.Generic;'
print 'using System.Linq;'
print 'using System.Text;'
print 'using System.Threading.Tasks;'
print 'namespace LS.Cores'
print '{'
print '/// <summary>'
print '/// '+@dispalyDescription+'自定义方法'
print '/// </summary>'
print 'public  interface  I'+@displayName+': RepositoryBase<'+@displayName+'Entity>'
print '{'
print '}'
print '}'
end
GO
/****** Object:  StoredProcedure [dbo].[p_getcoreS]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec  p_getModel 'sys_function','SysFunctionEntity','功能项管理'
--exec p_getcoreI 'SysFunction','功能项管理'
--exec [p_getcoreS] 'sys_function','SysFunction','功能项管理'
CREATE proc  [dbo].[p_getcoreS]
(
@tablename varchar(50),--实际数据库表名
@displayName varchar(50),--实际class名称
@dispalyDescription varchar(50)='' --类注释名称如XX管理
)
as
begin 
declare @colName varchar(50)
declare @typeName varchar(50)

print 'using System;'
print 'using System.Collections.Generic;'
print 'using System.Linq;'
print 'using System.Text;'
print 'using System.Threading.Tasks;'
print 'using LS.Entitys;'
print 'namespace  LS.Cores'

print '{'
print '/// <summary>'
print '/// 提供'+@dispalyDescription+'服务'
print '/// </summary>'
print '[Serializable]'
print 'public  class '+@displayName+'Service : I'+@displayName
print '{'

print '#region 实现接口方法'
print 'public int Delete(string id)'
print '{'
print 'string sql = "delete from  '+@tablename+' where id=@Id";'
print 'return SqlHelper.Execute(sql, new { Id = id });'
print '}'
print 'public '++@displayName+'Entity  GetById(int id)'
print '{'
print 'string sql = "select * from  '+@tablename+' where id=@Id";'
print 'return SqlHelper.Query<'+@displayName+'Entity>(sql, new { Id = id }).FirstOrDefault();'
print '}'
print 'public PageDataView<'+@displayName+'Entity> GetPageData(string strwhere,int currentPage=1,int pageSize=20)'
print '{'
print 'PageCriteria criteria = new PageCriteria();'
print 'criteria.Condition = "1=1";'
print ' if (!string.IsNullOrEmpty(strwhere))'
print ' {'
print ' criteria.Condition += strwhere;'
print ' }'
print ' criteria.CurrentPage = currentPage;'
print ' criteria.Fields = "*";'
print ' criteria.PageSize = pageSize;'
print ' criteria.TableName = "'+@tablename+'";'
print ' criteria.PrimaryKey = "id";'
print 'return SqlHelper.GetPageData<'+@displayName+'Entity>(criteria);'
print '}'
print 'public IList<'+@displayName+'Entity> Query(string strwhere)'
print '{'
print 'string sql = "select * From  '+@tablename+' where 1=1 ";'
print 'if (!string.IsNullOrEmpty(strwhere))'
print '{'
print ' sql += strwhere;'
print '}'
print 'return SqlHelper.Query<'+@displayName+'Entity>(sql).ToList();'
print '}'
declare @sqlinsert varchar(2000)
declare @sqlupdate varchar(2000)
set @sqlinsert=''
set @sqlupdate=''
declare my_cursor  cursor  
for
select A.name colName,B.name typeName From  sys.columns A left join  sys.types B
on A.user_type_id =B.user_type_id
where  A.object_id=(
select object_id From sys.tables where type='U'and name=@tablename
) and  A.name !='id'

open  my_cursor

fetch next from my_cursor into  @colName,@typeName
while @@FETCH_STATUS=0
	begin
	
	   set @sqlinsert=@sqlinsert+'@'+@colName+','
	   set @sqlupdate=@sqlupdate+@colName+'='+'@'+@colName+','
		fetch next from  my_cursor into  @colName,@typeName
	end
close my_cursor
deallocate my_cursor

print 'public int Insert('+@displayName+'Entity model)'
print '{'
print 'StringBuilder strsql = new StringBuilder();'
print 'strsql.Append("insert into '+@tablename+'('+replace(SUBSTRING(@sqlinsert,1,len(@sqlinsert)-1),'@','')+') ");'
print 'strsql.Append(" values('+SUBSTRING(@sqlinsert,1,len(@sqlinsert)-1)+')");'
print 'return  SqlHelper.Execute(strsql.ToString(), model);'
print '}'
print 'public int Update('+@displayName+'Entity model)'
print '{'
print 'StringBuilder strsql = new StringBuilder();'
print 'strsql.Append("update '+@tablename+' set  ");'
print 'strsql.Append("'+SUBSTRING(@sqlupdate,1,len(@sqlupdate)-1)+'" );'
print 'strsql.Append(" where id=@id ");'
print 'return  SqlHelper.Execute(strsql.ToString(), model);'
print '}'
print '#endregion 实现接口方法'
print '}'
print '}'
end


GO
/****** Object:  StoredProcedure [dbo].[p_getmodel]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc  [dbo].[p_getmodel]
(
@tablename varchar(50),--实际数据库表名
@displayName varchar(50),--实际class名称
@dispalyDescription varchar(50)='' --类注释名称如XX管理
)
as
begin 
declare @colName varchar(50)
declare @typeName varchar(50)

print 'using System;'
print 'using System.Collections.Generic;'
print 'using System.Linq;'
print 'using System.Text;'
print 'using System.Threading.Tasks;'
print 'namespace LS.Entitys'
print '{'
print '/// <summary>'
print '/// '+@dispalyDescription
print '/// </summary>'
print '[Serializable]'
print 'public  class '+@displayName
print '{'
declare my_cursor  cursor  
for
select A.name colName,B.name typeName From  sys.columns A left join  sys.types B
on A.user_type_id =B.user_type_id
where  A.object_id=(
select object_id From sys.tables where type='U'and name=@tablename
)

open  my_cursor

fetch next from my_cursor into  @colName,@typeName
while @@FETCH_STATUS=0
	begin
	    --print upper(substring(@colName,1,1))+substring(@colName,2,len(@colName))
		set @colName=upper(substring(@colName,1,1))+substring(@colName,2,len(@colName))
		if(@typeName='int' or @typeName='tinyint' or @typeName='smallint')
		   begin
		      print '/// <summary>'
			  print '/// '+@colName
			  print '/// <summary>'
		      print 'public int? '+@colName+' { get; set; }'
		   end
		  if(@typeName='bigint' )
		   begin
		      print '/// <summary>'
			  print '/// '+@colName
			  print '/// <summary>'
		      print 'public long? '+@colName+' { get; set; }'
		   end
		if(@typeName='varchar' or @typeName='nvarchar' or @typeName='char' or @typeName='nchar' or  @typeName='uniqueidentifier' or @typeName='text')
		   begin
		      print '/// <summary>'
			  print '/// '+@colName
			  print '/// <summary>'
		      print 'public string '+@colName+' { get; set; }'
		   end
        if(@typeName='datetime')
		   begin
		      print '/// <summary>'
			  print '/// '+@colName
			  print '/// <summary>'
		      print 'public DateTime? '+@colName+' { get; set; }'
		   end
		if(@typeName='decimal' or @typeName='numeric' or @typeName='money')
		   begin
		      print '/// <summary>'
			  print '/// '+@colName
			  print '/// <summary>'
		      print 'public decimal? '+@colName+' { get; set; }'
		   end
		if(@typeName='bit' )
		   begin
		      print '/// <summary>'
			  print '/// '+@colName
			  print '/// <summary>'
		      print 'public bool? '+@colName+' { get; set; }'
		   end
		if(@typeName='float'  or @typeName='real')
		   begin
		      print '/// <summary>'
			  print '/// '+@colName
			  print '/// <summary>'
		      print 'public double? '+@colName+' { get; set; }'
		   end
		fetch next from  my_cursor into  @colName,@typeName
	end
close my_cursor
deallocate my_cursor
print '}'
print '}'
end
GO
/****** Object:  StoredProcedure [dbo].[p_getUserMenu]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc  [dbo].[p_getUserMenu]
(
 @UserCode  varchar(30) --用户代码
)
as
 begin
            select A.*,B.rolecode,B.funcode from sys_menu A join sys_rolemenu B on A.menucode =B.menucode
            where B.rolecode in (select rolecode From  sys_userrole where usercode=@UserCode  )
			and isvisible=0 and isenable=1
			union
			select A.*,B.rolecode,B.funcode from sys_menu A join sys_rolemenu B on A.menucode =B.menucode
            where B.rolecode in ( select  D.rolecode from  sys_organizeuser C join sys_organizerole  D  on C.orgcode=D.orgcode  where C.usercode=@UserCode)
			and isvisible=0 and isenable=1
			
		     
 end
GO
/****** Object:  StoredProcedure [dbo].[proc_GetPageData]    Script Date: 2019/8/11 12:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[proc_GetPageData]
(  @TableName VARCHAR(1000), --表名,多表是请使用 tA a inner join tB b On a.AID = b.AID
   @PrimaryKey NVARCHAR(100),    --主键，可以带表头 a.AID
   @Fields NVARCHAR(2000) = '*',--读取字段
   @Condition NVARCHAR(3000) = '',--Where条件
   @CurrentPage INT = 1,    --开始页码
   @PageSize INT = 10,        --页大小
   @Sort NVARCHAR(200) = '', --排序字段
   @RecordCount INT = 0 OUT
)
AS
DECLARE @strWhere VARCHAR(2000)
DECLARE @strsql NVARCHAR(3900)
IF @Condition IS NOT NULL AND len(ltrim(rtrim(@Condition)))>0
  BEGIN
   SET @strWhere = ' WHERE ' + @Condition + ' '
  END
ELSE
  BEGIN
   SET @strWhere = ''
  END
        
IF (charindex(ltrim(rtrim(@PrimaryKey)),@Sort)=0)
BEGIN
    IF(@Sort='')
        SET @Sort = @PrimaryKey + ' DESC '
    ELSE
        SET @Sort = @Sort+ ' , '+@PrimaryKey + ' DESC '
END
SET @strsql = 'SELECT @RecordCount = Count(1) FROM ' + @TableName + @strWhere  
EXECUTE sp_executesql @strsql ,N'@RecordCount INT output',@RecordCount OUTPUT
IF @CurrentPage = 1 --第一页提高性能
BEGIN 
  SET @strsql = 'SELECT TOP ' + str(@PageSize) +' '+@Fields
              + '  FROM ' + @TableName + ' ' + @strWhere + ' ORDER BY  '+ @Sort
END 
ELSE
  BEGIN
    /* Execute dynamic query */    
    DECLARE @START_ID NVARCHAR(50)
    DECLARE @END_ID NVARCHAR(50)
    SET @START_ID = CONVERT(NVARCHAR(50),(@CurrentPage - 1) * @PageSize + 1)
    SET @END_ID = CONVERT(NVARCHAR(50),@CurrentPage * @PageSize)
    SET @strsql =  ' SELECT *
   FROM (SELECT ROW_NUMBER() OVER(ORDER BY '+@Sort+') AS rownum, 
     '+@Fields+ '
      FROM '+@TableName + @strWhere +') AS XX
   WHERE rownum BETWEEN '+@START_ID+' AND ' +@END_ID +' ORDER BY XX.rownum ASC'
  END
EXEC(@strsql)
RETURN
GO
USE [master]
GO
ALTER DATABASE [LSProject] SET  READ_WRITE 
GO
