
USE rvv

DECLARE @matricula_usuario INT,
		@matricula_supervisor INT,
		@cod_indicador INT,
		@inico_vigencia DATE,
		@valor_meta DECIMAL(32,8)
		

SET @matricula_usuario = 1000002
SET @matricula_supervisor = 1000005
SET @cod_indicador = 1
SET @inico_vigencia = '2023-01-01'
SET @valor_meta = 380000;

EXEC dbo.spr_meta_supervisor @procedimento = 1,								-- int (1 INSERT | 2 UPDATE | 3 DELETE )
                             @matricula_usuario = 1000002,					-- int
                             @matricula_supervisor = @matricula_supervisor, -- int
                             @cod_indicador = @cod_indicador,				-- int
                             @inico_vigencia = @inico_vigencia,				-- date
                             @valor_meta = @valor_meta						-- decimal(32, 8)


SELECT * FROM dbo.Meta AS m
WHERE m.Matricula_do_Colaborador = @matricula_supervisor;
