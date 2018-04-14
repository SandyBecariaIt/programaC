USE PorVenir
GO

CREATE PROCEDURE AgregarUsuario
@nombreUse      VARCHAR(50),
@aPpUser        VARCHAR(50),
@aPmUser        VARCHAR(45),
@fechaNa        DATETIME,
@genero         VARCHAR(2),
@tipo           INT,
@telefono       VARCHAR(15),
@correo         VARCHAR(20),
@contrasena     VARCHAR(15),
@respuesta      VARCHAR(20) OUTPUT
AS
IF NOT EXISTS(SELECT * FROM Usuarios 
WHERE nombreUse = @nombreUse AND aPpUser = @aPpUser
AND aPmUser = @aPmUser) 
BEGIN
    INSERT INTO Usuarios VALUES(@nombreUse,@aPpUser,@aPmUser
    ,@fechaNa,@genero,@tipo,@telefono,@correo,1,@contrasena)
    SET @respuesta = 'El usuario fue agregado correctamente'
END
ELSE
BEGIN
    SET @respuesta = 'El usuario ya existe'
END
GO

CREATE PROCEDURE AgregaCompania
	@descripcion varchar (100)
as 
	if NOT EXISTS (select * from Compania where Compania.descripcion =@descripcion) 
	  begin 
		insert into Compania values (@descripcion)
	  end

CREATE PROCEDURE AgregaProveedor
	@marca VARCHAR(100), 
	@telefono VARCHAR(10),
	@compania VARCHAR(100),
	@respuesta VARCHAR(100) OUTPUT
AS
	declare @idCompania int
	select @idCompania= Compania.idCompania from Compania where descripcion = @compania
	if NOT EXISTS (select * from Proveedor where @marca=Proveedor.descripcion)
	begin 
		insert into Proveedor values(@marca,@telefono, @idCompania)
	set @respuesta='Proveedor agregado'
	end
	else 
	begin 
	set @respuesta='Este proveedor ya exite'
	end

CREATE PROCEDURE ModificaProv
	@telefono varchar (10),
	@marca varchar (100),
	@compania varchar (100)
AS
	declare @idCompania int
	select @idCompania=Compania.idCompania from Compania where descripcion=@compania
	update Proveedor set telefono=@telefono,idCompania=@idCompania where descripcion=@marca

ALTER PROCEDURE Loguea
	@usuario VARCHAR(100),
	@contrasena VARCHAR(100),
	@res INT OUTPUT
AS
	DECLARE @user VARCHAR(100);
	SELECT @user = tipoUser FROM Usuarios WHERE @usuario = telefono OR @usuario = correo 
	AND @contrasena = contrasena AND actividad = 1;
	IF(@user > 0)
		BEGIN
			SET @res = @user;
		END
	ELSE 
		BEGIN
			SET @res = 0;
		END

exec AgregarUsuario 'CESAR',	'MUÑOZ','ocampo','1994/09/27'
,'M',1,'0445533','cesar_dantexD','dantexD123',''