USE rvv


DECLARE @procedimento INT,
        @matricula_usuario INT,
        @nome_cargo VARCHAR(30),
        @status_cargo BIT,
        @hierarquia_cargo INT,
        @cod_cargo_atualizacao INT;


SET @procedimento = 3;
SET @matricula_usuario = 1000006;
SET @nome_cargo = 'Teste';
SET @status_cargo = 1;
SET @hierarquia_cargo = 2;
SET @cod_cargo_atualizacao = 1007;



EXEC dbo.spr_cadastro_cargo @procedimento = @procedimento,					-- int
                            @matricula_usuario = @matricula_usuario,		-- int
                            @nome_cargo = @nome_cargo,						-- varchar(30)
                            @status_cargo = @status_cargo,					-- bit
							@hierarquia_cargo = @hierarquia_cargo,			-- int
                            @cod_cargo_atualizacao = @cod_cargo_atualizacao	-- int


SELECT * FROM dbo.Cargo AS c