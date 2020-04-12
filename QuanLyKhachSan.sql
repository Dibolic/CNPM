CREATE DATABASE QuanLyKhachSan
GO

USE QuanLyKhachSan
GO

--Room
--Customer
--
--Support
--Account 
--Bill
--BillInfo

CREATE TABLE Room
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100)DEFAULT N'Chưa đặt tên',
	status NVARCHAR(100) DEFAULT N'Trống',
	amountBed INT DEFAULT 2,	
)
GO

CREATE TABLE Customer
(
	idCus NVARCHAR(100) PRIMARY KEY ,
	gender NVARCHAR(100) ,
	name NVARCHAR(100) DEFAULT N'Chưa nhập tên',
	cmnd NVARCHAR(100) DEFAULT N'0',
	address NVARCHAR(100) DEFAULT N'Chưa nhập địa chỉ',
	country NVARCHAR(100) DEFAULT N'Chưa nhập quốc tịch',
	sdt NVARCHAR(100) DEFAULT 0,
	email NVARCHAR(100) DEFAULT N'Chưa nhập email',
	idRoom int ,
	amount nvarchar DEFAULT N'0'
	
	FOREIGN KEY (idRoom) REFERENCES dbo.Room(id),
	
)
GO



CREATE TABLE Account
(
	id INT IDENTITY PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'Staff',
	UserName NVARCHAR(100) NOT NULL,
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL DEFAULT 0 -- 1 la admin || 0 la staff
)
GO


CREATE TABLE Support -- dich vu
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	price INT NOT NULL DEFAULT 0,
	
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	dateIn DATE NOT NULL DEFAULT GETDATE(),
	dateOut DATE,
	idRoom 	INT NOT NULL,
	status INT NOT NULL,
	idCus NVARCHAR(100) DEFAULT N'Chưa có mã khách hàng'
	
	FOREIGN KEY (idRoom) REFERENCES dbo.Room(id),
	FOREIGN KEY (idCus) REFERENCES dbo.Customer(idCus)
)
GO


CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT ,
	idSupport INT 
	
	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idSupport) REFERENCES dbo.Support(id)
)
GO


INSERT INTO dbo.Account
	(
		UserName,
		DisplayName,
		PassWord,
		Type
	)
VALUES 
	(
		N'Dung',
		N'DungBacLieu',
		N'0',
		1 --Type = int
	)

INSERT INTO dbo.Account
	(
		UserName,
		DisplayName,
		PassWord,
		Type
	)
VALUES 
	(
		N'Staff1',
		N'Nhân viên 1',
		N'1',
		0 --Type = int
	)

INSERT INTO dbo.Account
	(
		UserName,
		DisplayName,
		PassWord,
		Type
	)
VALUES 
	(
		N'nv',
		N'Nhân viên 2',
		N'1',
		0 --Type = int
	)
	-- thêm phòng
	DECLARE @j int = 0
	while @j<12
	begin
		INSERT dbo.Room (name, status, amountBed) VALUES (N'Phòng ' + CAST(@j+1 AS nvarchar(1000)), N'Trống', 2)
		SET @j = @j+1
	end

	--thêm khách
	INSERT INTO dbo.Customer
	(
		idCus,
		gender,
		name, 
		cmnd,
		address,
		country,
		sdt,
		email,
		idRoom, 
		amount
	)
VALUES 
	(
		N'KH1',
		N'Nữ',--1 là nam, 0 là nữ
		N'Lê Thị Thúy',
		N'47261531',
		N'Xóm Ngụ Cư , xã Nam Điền, Tỉnh Khánh Hòa',
		N'Việt Nam',
		N'0949455826',
		N'ThuyCute123@gmail.com',
		2,
		N'1'
	)

	INSERT INTO dbo.Customer
	(
		idCus,
		gender,
		name, 
		cmnd,
		address,
		country,
		sdt,
		email,
		idRoom, 
		amount
	)
VALUES 
	(
		N'KH2',
		N'Nam',--1 là nam, 0 là nữ
		N'Nguyễn Hoàng Dũng',
		N'47265874',
		N'307 Vĩnh Châu khóm 6 phường 7 Bạc Liêu',
		N'Việt Nam',
		N'0949408212',
		N'NguyenDung1705@gmail.com',
		2,
		N'1'
	)
	
		INSERT INTO dbo.Customer
	(
		idCus,
		gender,
		name, 
		cmnd,
		address,
		country,
		sdt,
		email,
		idRoom, 
		amount
	)
VALUES 
	(
		N'KH3',
		N'Nam',--1 là nam, 0 là nữ
		N'Tràng A Hải',
		N'47261531',
		N'Làng Vũ Đông A, huyện Kim Tiền, Gia Lai',
		N'Việt Nam',
		N'09423523',
		N'HaiVipPro@gmail.com',
		4,
		N'1'
	)

	INSERT INTO dbo.Customer
	(
		idCus,
		gender,
		name, 
		cmnd,
		address,
		country,
		sdt,
		email,
		idRoom, 
		amount
	)
VALUES 
	(
		N'KH4',
		N'Nam',--1 là nam, 0 là nữ
		N'Lý Nam',
		N'44124154',
		N'Đường Cách Mạng, tỉnh Biên Hòa',
		N'Việt Nam',
		N'012401512',
		N'NamLy@gmail.com',
		3,
		N'1'
	)

	select * from dbo.Customer

	delete dbo.Customer

CREATE PROC USP_GetRoomList
AS SELECT * FROM dbo.Room
go

exec dbo.USP_GetRoomList

go
CREATE PROC USP_GetBillList
AS SELECT * FROM dbo.Bill
go

USP_GetBillList
	
SELECT * FROM dbo.Account

SELECT * FROM dbo.Support

SELECT * FROM dbo.BillInfo

SELECT * FROM dbo.Room

SELECT * FROM dbo.Customer

SELECT MAX(idCus) FROM dbo.Customer

select count(*) from dbo.Customer

select count(idSupport) from dbo.BillInfo where idBill = 1

SELECT * FROM dbo.Bill where id = 2

SELECT * FROM dbo.BillInfo where idBill = 2 

select s.name, bi.idBill,s.price from dbo.BillInfo as bi, dbo.Bill as b, dbo.Support as s
where bi.idBill = b.id and bi.idSupport = s.id and idRoom = 2

select s.name, bi.idBill,s.price from dbo.BillInfo as bi, dbo.Bill as b, dbo.Support as s
where bi.idBill = b.id and bi.idSupport = s.id and idBill = 2

select s.name, bi.idBill,s.price from dbo.BillInfo as bi, dbo.Support as s
where bi.idSupport = s.id and idSupport =2 

select * from dbo.Support where id= 2

delete from dbo.BillInfo where idBill = 2 and idSupport = 5

go


exec dbo.USP_GetBillList

alter proc USP_InsertNewBillInfo
@idBill int,@idSupport int
AS
BEGIN 
	DECLARE @isExistsBillInfo int

	select @isExistsBillInfo = id from dbo.BillInfo where idBill = @idBill and idSupport = @idSupport

	INSERT dbo.BillInfo
	(
		idBill,
		idSupport
	)
VALUES 
	(
		@idBill,
		@idSupport
	)
END
GO


create proc USP_InsertNewBillInfo
@idBill int,@idSupport int

as
begin
INSERT dbo.BillInfo
	(
		idBill,
		idSupport
	)
VALUES 
	(
		@idBill,
		@idSupport
	)
END

go




go
-- sửa thông tin
DECLARE @k int = 5
	while @k<10
	begin
		update dbo.Room (status, amount, amountPeople) VALUES (N'Trống',0,0) WHERE id = @k
		SET @k = @k+1
	end


select * from dbo.Bill

select * from dbo.Customer

select * from dbo.Room
go

-- thêm khách
create proc USP_InsertCustomer
@idCus nvarchar(50),@gender int,  @name nvarchar(50), @cmnd int,@address nvarchar(50), @country nvarchar(50), @sdt int,@email nvarchar(50), @idRoom int, @amount int
AS
BEGIN 
	INSERT dbo.Customer
	(
		idCus ,
		gender ,
		name , 
		cmnd ,
		address,
		country,
		sdt,
		email,
		idRoom,
		amount
	)
VALUES 
	(
		@idCus ,
		@gender ,
		@name , 
		@cmnd ,
		@address,
		@country,
		@sdt,
		@email,
		@idRoom,
		@amount --g thái hóa đơn (0 là chưa trả tiền, 1 là trả tiền)
	)
END
GO
-- thêm bill

create proc USP_InsertBill
@DateIn datetime,@DateOut datetime,  @idRoom int,@idCus nvarchar(50)
AS
BEGIN 
	INSERT dbo.Bill
	(
		DateIn ,
		DateOut ,
		idRoom , 
		idCus ,
		status
	)
VALUES 
	(
		@DateIn , --ngày vào
		@DateOut , --ngày ra
		@idRoom, --mã phòng
		@idCus, -- mã khách hàng
		0 -- trạng thái hóa đơn (0 là chưa trả tiền, 1 là trả tiền)
	)
END
GO






INSERT INTO dbo.Bill
	(
		DateIn,
		DateOut,
		idRoom, 
		idCus,
		status
	)
VALUES 
	(
		GETDATE(), --ngày vào
		GETDATE(), --ngày ra
		2, --mã phòng
		N'KH2', -- mã khách hàng
		0 -- trạng thái hóa đơn (0 là chưa trả tiền, 1 là trả tiền)
	)

INSERT INTO dbo.Bill
	(
		DateIn,
		DateOut,
		idRoom, 
		idCus,
		status
	)
VALUES 
	(
		GETDATE(), --ngày vào
		GETDATE(), --ngày ra
		4, --mã phòng
		N'KH4', -- mã khách hàng
		0 -- trạng thái hóa đơn (0 là chưa trả tiền, 1 là đã trả tiền)
	)

INSERT INTO dbo.Bill
	(
		DateIn,
		DateOut,
		idRoom, 
		idCus,
		status
	)
VALUES 
	(
		GETDATE(), --ngày vào
		GETDATE(), --ngày ra
		9, --mã phòng
		N'KH1', -- mã khách hàng
		1 -- trạng thái hóa đơn (0 là chưa trả tiền, 1 là đã trả tiền)
	)


	INSERT INTO dbo.Bill
	(
		DateIn,
		DateOut,
		idRoom, 
		idCus,
		status
	)
VALUES 
	(
		GETDATE(), --ngày vào
		GETDATE(), --ngày ra
		7, --mã phòng
		N'KH3', -- mã khách hàng
		1 -- trạng thái hóa đơn (0 là chưa trả tiền, 1 là đã trả tiền)
	)



	


select * from dbo.BillInfo

select * from dbo.Bill

delete dbo.Bill
go
-- thêm billinfo

INSERT INTO dbo.BillInfo
	(
		idBill,
		idSupport
	)
VALUES 
	(
		1, -- mã bill
		1 -- mã dịch vụ
	)


INSERT dbo.BillInfo
	(
		idBill,
		idSupport
	)
VALUES 
	(
		1, -- mã bill
		2 -- mã dịch vụ
	)

	INSERT dbo.BillInfo
	(
		idBill,
		idSupport
	)
VALUES 
	(
		1, -- mã bill
		4 -- mã dịch vụ
	)

	INSERT dbo.BillInfo
	(
		idBill,
		idSupport
	)
VALUES 
	(
		2, -- mã bill
		5 -- mã dịch vụ
	)

	INSERT dbo.BillInfo
	(
		idBill,
		idSupport
	)
VALUES 
	(
		2, -- mã bill
		3 -- mã dịch vụ
	)

select * from dbo.Support
go
-- thêm dịch vụ
INSERT INTO dbo.Support
	(
		name,
		price
		
	)
VALUES 
	(
		N'Dịch vụ Spa',
		1000000
	)

	INSERT INTO dbo.Support
	(
		name,
		price
		
	)
VALUES 
	(
		N'Dịch vụ ủi quần áo',
		200000
	)
	INSERT INTO dbo.Support
	(
		name,
		price
	)
VALUES 
	(
		N'Dịch vụ Gym',
		500000
	)
	INSERT INTO dbo.Support
	(
		name,
		price
		
	)
VALUES 
	(
		N'Dịch vụ đưa rước',
		100000
	)
INSERT INTO dbo.Support
	(
		name,
		price
		
	)
VALUES 
	(
		N'Dịch vụ Yoga',
		700000
	)

select * from dbo.Customer where idRoom = 2

select s.name, bi.idBill,s.price from dbo.BillInfo as bi, dbo.Bill as b, dbo.Support as s
where bi.idBill = b.id and bi.idSupport = s.id and idRoom = 2

select cus.name from dbo.Customer as cus, dbo.Room as ro, dbo.Bill as bil
where cus.idRoom = ro.id AND cus.idRoom = bil.idRoom and bil.idRoom = 2 and bil.status = 0
and cus.idCus = N'KH2'

select idCus from dbo.Bill where idRoom =2 and status = 0

select * from dbo.Customer where idCus = N'KH2'

select dateIn from dbo.Bill where idCus = N'KH5'

select * from dbo.Bill

select * from dbo.BillInfo

select * from dbo.Customer where idCus = N'KH2'

select * from dbo.Room

update dbo.Customer set gender =N'Nữ', name =N'Lý Thùy'
where idCus = N'KH4'

update dbo.Bill set status = 0 where id = 5

delete dbo.Support

delete dbo.Bill where id = 3

delete dbo.Customer where idCus = N'KH5'


update dbo.Room SET STATUS = N'Có khách' WHERE id = 4
update dbo.Room SET amountBed = 2 WHERE id = 4

update dbo.Room SET STATUS = N'Có khách' WHERE id = 2
update dbo.Room SET amountBed = 2 WHERE id = 2

update dbo.Room SET amountBed = 4 WHERE id = 11
update dbo.Room SET amountBed = 4 WHERE id = 12

update dbo.Customer set amount = N'2', name = N'Lý Tự Nam' where idCus = N'KH5'
