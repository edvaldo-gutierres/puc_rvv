USE rvv

DECLARE @procedimento AS INT,
		@matricula_usuario INT,
		@nome_colaborador VARCHAR(150),
		@sexo VARCHAR(1),
		@cpf VARCHAR(14),
		@data_nascimento DATE,
		@codigo_departamento INT,
		@codigo_cargo INT,
		@salario DECIMAL(32, 2),
		@matricula_atualizacao INT;

SET @procedimento = 3;
SET @matricula_usuario = 1000006;
SET @nome_colaborador = 'Teste21';
SET @sexo = 'M';
SET @cpf = '346.015.498-52';
SET @data_nascimento = '1988-09-22';
SET @codigo_departamento = 1004;
SET @codigo_cargo = 1004;
SET @salario = 7233.55
SET @matricula_atualizacao = 1000008;

EXEC dbo.spr_cadastro_colaborador @procedimento = @procedimento,					-- int (1 INSERT | 2 UPDATE | 3 DELETE )
                                  @matricula_usuario = @matricula_usuario,          -- int
                                  @nome_colaborador = @nome_colaborador,			-- varchar(150)
                                  @sexo = @sexo,									-- varchar(1)
                                  @cpf = @cpf,										-- varchar(14)
                                  @data_nascimento = @data_nascimento,				-- date
                                  @codigo_departamento = @codigo_departamento,      -- int
                                  @codigo_cargo = @codigo_cargo,					-- int
                                  @salario = @salario,								-- decimal(32, 2)
                                  @matricula_atualizacao = @matricula_atualizacao   -- int


--SELECT * FROM dbo.Colaborador AS c
