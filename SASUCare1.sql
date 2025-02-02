USE [master]
GO
/****** Object:  Database [test1]    Script Date: 1/23/2025 8:17:43 PM ******/
CREATE DATABASE [test1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'test1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\test1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'test1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\test1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [test1] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [test1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [test1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [test1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [test1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [test1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [test1] SET ARITHABORT OFF 
GO
ALTER DATABASE [test1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [test1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [test1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [test1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [test1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [test1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [test1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [test1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [test1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [test1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [test1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [test1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [test1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [test1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [test1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [test1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [test1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [test1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [test1] SET  MULTI_USER 
GO
ALTER DATABASE [test1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [test1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [test1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [test1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [test1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [test1] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [test1] SET QUERY_STORE = ON
GO
ALTER DATABASE [test1] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [test1]
GO
/****** Object:  User [sa]    Script Date: 1/23/2025 8:17:43 PM ******/
CREATE USER [sa] FOR LOGIN [sa] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Application]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Application](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[date] [date] NULL,
	[doctor_id] [int] NULL,
 CONSTRAINT [PK_Application] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Appointment]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[doctor_id] [int] NULL,
	[date] [date] NULL,
	[customer_id] [int] NULL,
	[status] [varchar](50) NULL,
 CONSTRAINT [PK_Appointment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](255) NULL,
	[gmail] [varchar](50) NULL,
	[gender] [bit] NULL,
	[dob] [date] NULL,
	[address] [varchar](50) NULL,
	[phone_number] [varchar](50) NULL,
	[google_id] [varchar](255) NULL,
	[fullname] [nvarchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Doctor] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctor_Department]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor_Department](
	[doctor_id] [int] NOT NULL,
	[department_id] [int] NOT NULL,
 CONSTRAINT [PK_Doctor_Department] PRIMARY KEY CLUSTERED 
(
	[doctor_id] ASC,
	[department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feature]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feature](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[url] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Feature] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Google_Authen]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Google_Authen](
	[account_id] [varchar](255) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[name] [varchar](50) NULL,
	[first_name] [varchar](50) NULL,
	[given_name] [varchar](50) NULL,
	[family_name] [varchar](50) NULL,
	[picture] [varchar](255) NULL,
	[verified_email] [bit] NOT NULL,
 CONSTRAINT [PK_Google_Authen] PRIMARY KEY CLUSTERED 
(
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[price] [float] NULL,
	[date] [date] NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleFeature]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleFeature](
	[role_id] [int] NOT NULL,
	[feature_id] [int] NOT NULL,
 CONSTRAINT [PK_RoleFeature] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[feature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[level] [int] NULL,
	[price] [float] NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service_Appointment]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service_Appointment](
	[service_id] [int] NOT NULL,
	[Appointment_id] [int] NOT NULL,
 CONSTRAINT [PK_Service_Appointment] PRIMARY KEY CLUSTERED 
(
	[service_id] ASC,
	[Appointment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[gender] [bit] NULL,
	[email] [varchar](50) NULL,
	[phone_number] [varchar](50) NULL,
	[fullname] [nvarchar](50) NULL,
	[dob] [date] NULL,
	[address] [varchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StaffRole]    Script Date: 1/23/2025 8:17:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffRole](
	[staff_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[staff_id] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([id], [username], [password], [gmail], [gender], [dob], [address], [phone_number], [google_id], [fullname]) VALUES (1, N'giangvt', N'123', N'test@gmail.com', 1, CAST(N'2000-01-02' AS Date), N'ad', N'0123432123', NULL, N'VuTRUongGiang')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Feature] ON 

INSERT [dbo].[Feature] ([id], [name], [url]) VALUES (3, N'Create account for System user', N'/hr/create')
SET IDENTITY_INSERT [dbo].[Feature] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([id], [name]) VALUES (1, N'admin')
INSERT [dbo].[Role] ([id], [name]) VALUES (2, N'Finance Department')
INSERT [dbo].[Role] ([id], [name]) VALUES (3, N'Human Resources Department')
INSERT [dbo].[Role] ([id], [name]) VALUES (4, N'Customer Service Department')
INSERT [dbo].[Role] ([id], [name]) VALUES (5, N'Doctor')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
INSERT [dbo].[RoleFeature] ([role_id], [feature_id]) VALUES (3, 3)
GO
SET IDENTITY_INSERT [dbo].[Staff] ON 

INSERT [dbo].[Staff] ([id], [username], [password], [gender], [email], [phone_number], [fullname], [dob], [address]) VALUES (1, N'giangvtadmin', N'123', 1, N'giangvthe187264@fpt.edu.vn', N'0362678790', N'Vu Truong Giang', NULL, NULL)
INSERT [dbo].[Staff] ([id], [username], [password], [gender], [email], [phone_number], [fullname], [dob], [address]) VALUES (2, N'giangvthr', N'123', 1, N'giangvthe187264@fpt.edu.vn', N'0362678790', N'Vu Truong Giang', NULL, NULL)
INSERT [dbo].[Staff] ([id], [username], [password], [gender], [email], [phone_number], [fullname], [dob], [address]) VALUES (3, N'giangvtfinance', N'123', 1, N'giangvthe187264@fpt.edu.vn', N'0362678790', N'Vu Truong Giang', CAST(N'2004-03-29' AS Date), N'narutobaco')
SET IDENTITY_INSERT [dbo].[Staff] OFF
GO
INSERT [dbo].[StaffRole] ([staff_id], [role_id]) VALUES (1, 1)
INSERT [dbo].[StaffRole] ([staff_id], [role_id]) VALUES (1, 2)
INSERT [dbo].[StaffRole] ([staff_id], [role_id]) VALUES (1, 3)
INSERT [dbo].[StaffRole] ([staff_id], [role_id]) VALUES (1, 4)
INSERT [dbo].[StaffRole] ([staff_id], [role_id]) VALUES (1, 5)
INSERT [dbo].[StaffRole] ([staff_id], [role_id]) VALUES (2, 3)
GO
ALTER TABLE [dbo].[Application]  WITH CHECK ADD  CONSTRAINT [FK_Application_Doctor] FOREIGN KEY([doctor_id])
REFERENCES [dbo].[Doctor] ([id])
GO
ALTER TABLE [dbo].[Application] CHECK CONSTRAINT [FK_Application_Doctor]
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Appointment] CHECK CONSTRAINT [FK_Appointment_Customer]
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Doctor] FOREIGN KEY([doctor_id])
REFERENCES [dbo].[Doctor] ([id])
GO
ALTER TABLE [dbo].[Appointment] CHECK CONSTRAINT [FK_Appointment_Doctor]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_GoogleAuthen] FOREIGN KEY([google_id])
REFERENCES [dbo].[Google_Authen] ([account_id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_GoogleAuthen]
GO
ALTER TABLE [dbo].[Doctor]  WITH CHECK ADD  CONSTRAINT [FK_Doctor_User] FOREIGN KEY([id])
REFERENCES [dbo].[Staff] ([id])
GO
ALTER TABLE [dbo].[Doctor] CHECK CONSTRAINT [FK_Doctor_User]
GO
ALTER TABLE [dbo].[Doctor_Department]  WITH CHECK ADD  CONSTRAINT [FK_Doctor_Department_Department] FOREIGN KEY([department_id])
REFERENCES [dbo].[Department] ([id])
GO
ALTER TABLE [dbo].[Doctor_Department] CHECK CONSTRAINT [FK_Doctor_Department_Department]
GO
ALTER TABLE [dbo].[Doctor_Department]  WITH CHECK ADD  CONSTRAINT [FK_Doctor_Department_Doctor] FOREIGN KEY([doctor_id])
REFERENCES [dbo].[Doctor] ([id])
GO
ALTER TABLE [dbo].[Doctor_Department] CHECK CONSTRAINT [FK_Doctor_Department_Doctor]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Appointment] FOREIGN KEY([id])
REFERENCES [dbo].[Appointment] ([id])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Appointment]
GO
ALTER TABLE [dbo].[RoleFeature]  WITH CHECK ADD  CONSTRAINT [FK_RoleFeature_Feature] FOREIGN KEY([feature_id])
REFERENCES [dbo].[Feature] ([id])
GO
ALTER TABLE [dbo].[RoleFeature] CHECK CONSTRAINT [FK_RoleFeature_Feature]
GO
ALTER TABLE [dbo].[RoleFeature]  WITH CHECK ADD  CONSTRAINT [FK_RoleFeature_Role] FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[RoleFeature] CHECK CONSTRAINT [FK_RoleFeature_Role]
GO
ALTER TABLE [dbo].[Service]  WITH CHECK ADD  CONSTRAINT [FK_Service_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[Staff] ([id])
GO
ALTER TABLE [dbo].[Service] CHECK CONSTRAINT [FK_Service_User]
GO
ALTER TABLE [dbo].[Service_Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Service_Appointment_Appointment] FOREIGN KEY([Appointment_id])
REFERENCES [dbo].[Appointment] ([id])
GO
ALTER TABLE [dbo].[Service_Appointment] CHECK CONSTRAINT [FK_Service_Appointment_Appointment]
GO
ALTER TABLE [dbo].[Service_Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Service_Appointment_Service] FOREIGN KEY([service_id])
REFERENCES [dbo].[Service] ([id])
GO
ALTER TABLE [dbo].[Service_Appointment] CHECK CONSTRAINT [FK_Service_Appointment_Service]
GO
ALTER TABLE [dbo].[StaffRole]  WITH CHECK ADD  CONSTRAINT [FK_StaffRole_Role] FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[StaffRole] CHECK CONSTRAINT [FK_StaffRole_Role]
GO
ALTER TABLE [dbo].[StaffRole]  WITH CHECK ADD  CONSTRAINT [FK_StaffRole_Staff] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([id])
GO
ALTER TABLE [dbo].[StaffRole] CHECK CONSTRAINT [FK_StaffRole_Staff]
GO
USE [master]
GO
ALTER DATABASE [test1] SET  READ_WRITE 
GO
