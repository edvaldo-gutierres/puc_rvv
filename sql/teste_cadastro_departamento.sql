USE rvv


DECLARE @procedimento INT,
        @matricula_usuario INT,
        @nome_departamento VARCHAR(30),
        @status_departamento BIT,
        @cod_departamento_atualizacao INT;


SET @procedimento = 3;
SET @matricula_usuario = 1000006;
SET @nome_departamento = 'Teste';
SET @status_departamento = 1;
SET @cod_departamento_atualizacao = 1006;



EXEC dbo.spr_cadastro_departamento @procedimento = @procedimento,									-- int
                                   @matricula_usuario = @matricula_usuario,							-- int
                                   @nome_departamento = @nome_departamento,							-- varchar(30)
                                   @status_departamento = @status_departamento,						-- bit
                                   @cod_departamento_atualizacao = @cod_departamento_atualizacao	-- int


SELECT * FROM dbo.Departamento AS d