--USE rvv;


ALTER PROCEDURE spr_cadastro_colaborador 
		@procedimento AS INT,
        @matricula_usuario INT,
        @nome_colaborador VARCHAR(150),
        @sexo VARCHAR(1),
        @cpf VARCHAR(14),
        @data_nascimento DATE,
        @codigo_departamento INT,
        @codigo_cargo INT,
        @salario DECIMAL(32, 2),
		@status_colaborador BIT,
        @matricula_atualizacao INT

AS

	BEGIN
	/*
	Cod Desafio: D04 e D20
	Cod RF: RF04 - Inserir e atualizar registros de funcionários
	Cod RNF: RFN04 - Não permitir alteração de CPF do colaborador
	Usuário chave: Administrativo
	*/
	---------------------------------------------------------------

	-- INCLUSÃO E ALTERAÇÃO
	-- VERIFICA SE O USUÁRIO TEM PERMISSÃO
	-- VERIFICA SE EXISTE CARGO INFORMADO
	-- VERIFICA SE EXISTE DEPARTAMENTO INFORMADO
	-- VERIFICA SE O CPF É EXCLUSIVO

	--EXCLUSÃO
	-- VERIFICA SE EXISTE META, RESULTADO OU COMISSÃO

	---------------------------------------------------------------

	-- VARIAVEIS DE ENTRADA
	--DECLARE @procedimento AS INT,
	--		@matricula_usuario INT,
	--		@nome_colaborador VARCHAR(150),
	--		@sexo VARCHAR(1),
	--		@cpf VARCHAR(14),
	--		@data_nascimento DATE,
	--		@codigo_departamento INT,
	--		@codigo_cargo INT,
	--		@salario DECIMAL(32, 2),
	--		@matricula_atualizacao INT,
	--		@status_colaborador BIT;

	--SET @procedimento = 3;
	--SET @matricula_usuario = 1000006;
	--SET @nome_colaborador = 'Teste22';
	--SET @sexo = 'M';
	--SET @cpf = '346.015.498-52';
	--SET @data_nascimento = '1988-09-22';
	--SET @codigo_departamento = 1004;
	--SET @codigo_cargo = 1004;
	--SET @salario = 7233.55;
	--SET @matricula_atualizacao = 1000026;
	--SET @status_colaborador = 1



	-- DEMAIS VARIAVEIS
	DECLARE @ind_permissao INT,
			@ind_cargo INT,
			@ind_dpto INT,
			@ind_cpf INT;

	-- HIERARQUIA PERMITIDA
	SELECT @ind_permissao = COUNT('')
	FROM dbo.Colaborador AS c
		LEFT JOIN dbo.Cargo AS c2
			ON c2.Codigo_do_Cargo = c.Codigo_do_Cargo
	WHERE c.Matricula_do_Colaborador = @matricula_usuario
		  AND c2.Codigo_do_Cargo IN ( 1001, 1004 ) -- CODIGO DE CARGOS QUE TENHAM PERMISSÃO
	;

	-- VERIFICA SE EXISTE CARGO INFORMADO
	SELECT @ind_cargo = COUNT('')
	FROM dbo.Cargo AS c
	WHERE c.Codigo_do_Cargo = @codigo_cargo;


	-- VERIFICA SE EXISTE DEPARTAMENTO INFORMADO
	SELECT @ind_dpto = COUNT('')
	FROM dbo.Departamento AS d
	WHERE d.Codigo_do_Departamento = @codigo_departamento
	AND d.Status_do_Departamento = 1;


	-- VERIFICA SE O CPF É EXCLUSIVO
	SELECT @ind_cpf = COUNT('')
	FROM dbo.Colaborador AS c
	WHERE c.CPF = @cpf;


	IF @procedimento = 1
	BEGIN
		--======================================================================================================================
		-- PROCEDIMENTO 1 - INSERIR
		--======================================================================================================================
		----------------------------------------------------------------------------------------------------------------------------
		--INICIO
		PRINT 'INICIANDO PROCEDIMENTO DE INSERÇÃO';

		-- VERFICA SE O USUARIO TEM PERMISSÃO
		IF @ind_permissao > 0
		BEGIN

			IF @ind_dpto > 0
			BEGIN

				IF @ind_cargo > 0
				BEGIN

					IF @ind_cpf = 0
					BEGIN

						INSERT INTO dbo.Colaborador
						(
							Nome_do_Colaborador,
							Sexo,
							CPF,
							Data_Nascimento,
							Codigo_do_Departamento,
							Codigo_do_Cargo,
							Salario,
							Status_do_Colaborador
						)
						VALUES
						(   @nome_colaborador,    -- Nome_do_Colaborador - varchar(150)
							@sexo,                -- Sexo - varchar(1)
							@cpf,                 -- CPF - varchar(14)
							@data_nascimento,     -- Data_Nascimento - date
							@codigo_departamento, -- Codigo_do_Departamento - int
							@codigo_cargo,        -- Codigo_do_Cargo - int
							@salario,             -- Salario - decimal(32, 2)
							1                     -- Status_do_Colaborador - bit
							);

						PRINT 'CADASTRO REALIZADO COM SUCESSO!!!';

					END;
					ELSE
						PRINT 'JÁ EXISTE CADASTRO PARA O CPF INFORMADO';

				END;
				ELSE
					PRINT 'CARGO INFORMADO NÃO EXISTE';

			END;
			ELSE
				PRINT 'DEPARTAMENTO INFORMADO NÃO EXISTE';

		END;
		ELSE
			PRINT 'USUÁRIO NÃO TEM PERMISSÃO';

	--FIM
	----------------------------------------------------------------------------------------------------------------------------
	END;


	IF @procedimento = 2
	BEGIN


		-- VERIFICA SE EXISTE CARGO INFORMADO
		SELECT @ind_cargo = COUNT('')
		FROM dbo.Cargo AS c
		WHERE c.Codigo_do_Cargo = (SELECT c2.Codigo_do_Cargo FROM dbo.Colaborador AS c2 WHERE c2.Matricula_do_Colaborador = @matricula_atualizacao);


		-- VERIFICA SE EXISTE DEPARTAMENTO INFORMADO
		SELECT @ind_dpto = COUNT('')
		FROM dbo.Departamento AS d
		WHERE d.Codigo_do_Departamento = (SELECT c2.Codigo_do_Departamento FROM dbo.Colaborador AS c2 WHERE c2.Matricula_do_Colaborador = @matricula_atualizacao);


		-- VERIFICA SE O CPF É EXCLUSIVO
		SELECT @ind_cpf = COUNT('')
		FROM dbo.Colaborador AS c
		WHERE c.CPF = (SELECT c2.CPF FROM dbo.Colaborador AS c2 WHERE c2.Matricula_do_Colaborador = @matricula_atualizacao)


		--======================================================================================================================
		-- PROCEDIMENTO 2 - ATUALIZAR
		--======================================================================================================================
		----------------------------------------------------------------------------------------------------------------------------
		--INICIO
		PRINT 'INICIANDO PROCEDIMENTO DE ATUALIZAÇÃO';


		-- VERFICA SE O USUARIO TEM PERMISSÃO
		IF @ind_permissao > 0
		BEGIN

			IF @ind_dpto > 0
			BEGIN

				IF @ind_cargo > 0
				BEGIN

					IF @nome_colaborador IS NOT NULL
					BEGIN
						UPDATE dbo.Colaborador SET Nome_do_Colaborador = @nome_colaborador WHERE Matricula_do_Colaborador = @matricula_atualizacao;
					END;

					IF @sexo IS NOT NULL
					BEGIN
						UPDATE dbo.Colaborador SET Sexo = @sexo WHERE Matricula_do_Colaborador = @matricula_atualizacao;
					END;

					IF @data_nascimento IS NOT NULL
					BEGIN
						UPDATE dbo.Colaborador SET Data_Nascimento = @data_nascimento WHERE Matricula_do_Colaborador = @matricula_atualizacao;
					END;

					IF @codigo_departamento IS NOT NULL
					BEGIN
						UPDATE dbo.Colaborador SET Codigo_do_Departamento = @codigo_departamento WHERE Matricula_do_Colaborador = @matricula_atualizacao;
					END;

					IF @codigo_cargo IS NOT NULL
					BEGIN
						UPDATE dbo.Colaborador SET Codigo_do_Cargo = @codigo_cargo WHERE Matricula_do_Colaborador = @matricula_atualizacao;
					END;

					IF @salario IS NOT NULL
					BEGIN
						UPDATE dbo.Colaborador SET Salario = @salario WHERE Matricula_do_Colaborador = @matricula_atualizacao;
					END;

					IF @status_colaborador IS NOT NULL
					BEGIN
						UPDATE dbo.Colaborador SET Status_do_Colaborador = @status_colaborador WHERE Matricula_do_Colaborador = @matricula_atualizacao;
					END

					PRINT 'CADASTRO ATUALIZADO COM SUCESSO!!!';

				END;
				ELSE
					PRINT 'CARGO INFORMADO NÃO EXISTE';

			END;
			ELSE
				PRINT 'DEPARTAMENTO INFORMADO NÃO EXISTE';

		END;
		ELSE
			PRINT 'USUÁRIO NÃO TEM PERMISSÃO';

	--FIM
	----------------------------------------------------------------------------------------------------------------------------
	END;



	IF @procedimento = 3
	BEGIN
		--======================================================================================================================
		-- PROCEDIMENTO 3 - EXCLUIR
		--======================================================================================================================
		----------------------------------------------------------------------------------------------------------------------------
		--INICIO
	
		DECLARE @chk_meta INT,
				@chk_resultado INT,
				@chk_comissao INT,
				@chk_cadastro INT

		-- VERIFICA SE EXISTE O CADASTRO
		SELECT @chk_cadastro = COUNT('') FROM dbo.Colaborador AS c
		WHERE c.Matricula_do_Colaborador = @matricula_atualizacao

		-- VERIFICA SE EXISTE META LANÇADA
		SELECT @chk_meta = COUNT('') FROM dbo.Meta AS m
		WHERE m.Matricula_do_Colaborador = @matricula_atualizacao

		-- VERIFICA SE EXISTE RESULTADO LANÇADO
		SELECT @chk_resultado = COUNT('') FROM dbo.Resultado AS r
		WHERE r.Matricula_do_Colaborador = @matricula_atualizacao

		-- VERIFICA SE EXISTE COMISSÃO CALCULADA
		SELECT @chk_comissao = COUNT('') FROM dbo.Comissao AS c
		WHERE c.Matricula_do_Colaborador = @matricula_atualizacao



		PRINT 'INICIANDO PROCEDIMENTO DE EXCLUSÃO'


		-- VERFICA SE O USUARIO TEM PERMISSÃO
		IF @ind_permissao > 0
		BEGIN

			IF @chk_cadastro > 0
			BEGIN

				IF @chk_meta = 0
				BEGIN

					IF @chk_resultado = 0
					BEGIN

						IF @chk_comissao = 0
						BEGIN

							DELETE dbo.Colaborador
							WHERE Matricula_do_Colaborador = @matricula_atualizacao

							PRINT 'CADASTRO EXCLUÍDO COM SUCESSO!!!';
				    
						END
						ELSE
							PRINT 'NÃO É PERMITIDO A EXCLUSÃO, POIS EXISTE COMISSÃO CALCULADA'
		
					END
					ELSE
						PRINT 'NÃO É PERMITIDO A EXCLUSÃO, POIS EXISTE RESULTADO DE VENDAS'

				END
				ELSE
					PRINT 'NÃO É PERMITIDO A EXCLUSÃO, POIS EXISTE META LANÇADA'
	
			END
			ELSE
				PRINT 'CADASTRO NÃO EXISTE'
		END
		ELSE
			PRINT 'USUÁRIO NÃO TEM PERMISSÃO';


		--FIM
		----------------------------------------------------------------------------------------------------------------------------
	END

END