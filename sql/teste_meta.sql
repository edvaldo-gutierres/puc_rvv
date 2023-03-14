USE rvv

DECLARE @matricula_usuario INT,
		@matricula_supervisor INT,
		@matricula_vendedor INT,
		@cod_indicador INT,
		@inico_vigencia DATE,
		@valor_meta DECIMAL(32,8),
		@procedimento INT
		

-- TESTE META DE SUPERVISOR
--/*
SET @procedimento = 1
SET @matricula_usuario = 1000002
SET @matricula_supervisor = 1000005
SET @cod_indicador = 5
SET @inico_vigencia = '2023-04-01'
SET @valor_meta = 380000;

EXEC dbo.spr_meta_supervisor @procedimento = @procedimento,					-- int (1 INSERT | 2 UPDATE | 3 DELETE )
                             @matricula_usuario = @matricula_usuario,		-- int
                             @matricula_supervisor = @matricula_supervisor, -- int
                             @cod_indicador = @cod_indicador,				-- int
                             @inico_vigencia = @inico_vigencia,				-- date
                             @valor_meta = @valor_meta						-- decimal(32, 8)


SELECT * FROM dbo.Meta AS m
WHERE m.Matricula_do_Colaborador = @matricula_supervisor;
--*/


-- TESTE META DE VENDEDOR
/*
SET @matricula_usuario = 1000003
SET @matricula_vendedor = 1000007 -- 1000012
SET @cod_indicador = 5
SET @inico_vigencia = '2023-04-01'
SET @valor_meta = 80000;


EXEC dbo.spr_meta_vendedor	@procedimento = @procedimento,					-- int (1 INSERT | 2 UPDATE | 3 DELETE )
                            @matricula_usuario = @matricula_usuario,		-- int
                            @matricula_vendedor = @matricula_vendedor,		-- int
                            @cod_indicador = @cod_indicador,				-- int
                            @inico_vigencia = @inico_vigencia,				-- date
                            @valor_meta = @valor_meta						-- decimal(32, 8)

SELECT * FROM dbo.Meta AS m
WHERE m.Matricula_do_Colaborador = @matricula_vendedor;
*/
