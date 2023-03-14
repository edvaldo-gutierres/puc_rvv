--USE rvv;

ALTER PROCEDURE spr_cadastro_departamento 
		@procedimento INT,
        @matricula_usuario INT,
        @nome_departamento VARCHAR(30),
        @status_departamento BIT,
        @cod_departamento_atualizacao INT 
AS
BEGIN
	/*
	Cod Desafio: D17
	Cod RF: RF10 - Criar e atualizar cadastro de departamentos
	Usuário chave: Administrativo
	*/
	---------------------------------------------------------------
	-- - PROCEDIMENTOS:
	-- VERIFICA SE O USUÁRIO TEM PERMISSÃO
	-- INSERIR NOVO DEPARTAMENTO
	-- ALTERAR DEPARTAMENTO


	-- EXCLUIR DEPARTAMENTO
	-- VERIFICA SE TEM FUNCIONARIO LOTADO
	-- VERIFICA SE PARTICIPA DE INDICADORES
	---------------------------------------------------------------

	--DECLARE @procedimento INT,
	--        @matricula_usuario INT,
	--        @nome_departamento VARCHAR(30),
	--        @status_departamento BIT,
	--        @cod_departamento_atualizacao INT;


	--SET @procedimento = 3;
	--SET @matricula_usuario = 1000006;
	--SET @nome_departamento = 'Teste';
	--SET @status_departamento = 1;
	--SET @cod_departamento_atualizacao = 1008;


	-- DEMAIS VARIAVEIS
	DECLARE @ind_permissao INT;


	-- HIERARQUIA PERMITIDA
	SELECT @ind_permissao = COUNT('')
	FROM dbo.Colaborador AS c
		LEFT JOIN dbo.Cargo AS c2
			ON c2.Codigo_do_Cargo = c.Codigo_do_Cargo
	WHERE c.Matricula_do_Colaborador = @matricula_usuario
		  AND c2.Codigo_do_Cargo IN ( 1001, 1004 ); -- CODIGO DE CARGOS QUE TENHAM PERMISSÃO


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

			INSERT dbo.Departamento
			(
				Nome_do_Departamento,
				Status_do_Departamento
			)
			VALUES
			(   @nome_departamento,             -- Nome_do_Departamento - varchar(30)
				ISNULL(@status_departamento, 1) -- Status_do_Departamento - bit
				);
				
			PRINT 'CADASTRO REALIZADO COM SUCESSO!!!';

		END;
		ELSE
			PRINT 'USUÁRIO NÃO TEM PERMISSÃO';


	--FIM
	----------------------------------------------------------------------------------------------------------------------------
	END;



	IF @procedimento = 2
	BEGIN
		--======================================================================================================================
		-- PROCEDIMENTO 2 - ATUALIZAR
		--======================================================================================================================
		----------------------------------------------------------------------------------------------------------------------------
		--INICIO
		PRINT 'INICIANDO PROCEDIMENTO DE ATUALIZAÇÃO';


		-- VERFICA SE O USUARIO TEM PERMISSÃO
		IF @ind_permissao > 0
		BEGIN

			UPDATE dbo.Departamento
			SET Nome_do_Departamento = @nome_departamento
			WHERE Codigo_do_Departamento = @cod_departamento_atualizacao;

			IF @status_departamento IS NOT NULL
			BEGIN
				UPDATE dbo.Departamento
				SET Status_do_Departamento = @status_departamento
				WHERE Codigo_do_Departamento = @cod_departamento_atualizacao;
			END;
			
			PRINT 'CADASTRO ATUALIZADO COM SUCESSO!!!'

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
		DECLARE @chk_depto INT,
				@chk_colaborador INT,
				@chk_indicador INT;

		-- VERIFICA SE EXISTE DEPARTAMENTO
		SELECT @chk_depto = COUNT('') FROM dbo.Departamento AS d
		WHERE d.Codigo_do_Departamento = @cod_departamento_atualizacao

		-- VERIFICA SE EXISTE FUNCIONARIO LOTADO
		SELECT @chk_colaborador = COUNT('')
		FROM dbo.Colaborador AS c
		WHERE c.Codigo_do_Departamento = @cod_departamento_atualizacao;

		-- VERIFICA SE PARTICIPA DE INDICADORES
		SELECT @chk_indicador = COUNT('')
		FROM dbo.Indicadores AS i
		WHERE i.Codigo_do_Departamento = @cod_departamento_atualizacao;


		PRINT 'INICIANDO PROCEDIMENTO DE EXCLUSÃO'

		-- VERFICA SE O USUARIO TEM PERMISSÃO
		IF @ind_permissao > 0
		BEGIN

			IF @chk_depto > 0
			BEGIN

				IF @chk_colaborador = 0
				BEGIN

					IF @chk_indicador = 0
					BEGIN

						DELETE FROM dbo.Departamento
						WHERE Codigo_do_Departamento = @cod_departamento_atualizacao;

						PRINT 'CADASTRO EXCLUÍDO COM SUCESSO!!!';

					END;
					ELSE
						PRINT 'NÃO É PERMITIDO A EXCLUSÃO, POIS PARTICIPA DE INDICADORES';

				END;
				ELSE
					PRINT 'NÃO É PERMITIDO A EXCLUSÃO, POIS EXISTE FUNCIONARIO LOTADO';

			END;
			ELSE
				PRINT 'CADASTRO NÃO EXISTE'

		END
		ELSE
			PRINT 'USUÁRIO NÃO TEM PERMISSÃO';


	--FIM
	----------------------------------------------------------------------------------------------------------------------------
	END;

END