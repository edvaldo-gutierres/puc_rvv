
ALTER PROCEDURE spr_meta_supervisor
	@procedimento AS INT,
    @matricula_usuario INT,
    @matricula_supervisor INT,
    @cod_indicador INT,
    @inico_vigencia DATE,
    @valor_meta DECIMAL(32, 8)
AS
BEGIN

	/*
	Cod Desafio: D02
	Cod RF: RF02 - Inserir metas dos Supervisores
	Usuário chave: Gerente
	*/
    -- VERIFICA SE O HORARIO DE LANÇAMENTO É ANTES DAS 8H - OK
    -- VERIFICA SE O INICIO DA VIGENCIA INFORMADA NÃO É RETROATIVO - OK
    -- VERIFICA SE O USUARIO É GERENTE - OK
    -- VERIFICA SE O FUNCIONARIO POSSUI META LANÇADA NO PERIODO CORRESPONDENTE - OK
    -- VERIFICA SE É PRIMEIRA META, SE VERDADEIRO INSERE OS DADOS DE META, SE FALSO, ALTERA A FINAL DA VIGENCIA DA META ANTERIOR E INSERE OS DADOS DA NOVA META VIGENTE - OK
    ------------------------------------------------------------

    ------------------------------------------------------------
    -- VARIAVEIS DE ENTRADA

	--DECLARE 	
	--@procedimento AS INT,
 --   @matricula_usuario INT,
 --   @matricula_supervisor INT,
 --   @cod_indicador INT,
 --   @inico_vigencia DATE,
 --   @valor_meta DECIMAL(32, 8)

	--SET @procedimento = 3

 --   SET @matricula_usuario = 1000002;

 --   SET @matricula_supervisor = 1000005;
 --   SET @cod_indicador = 1;
 --   SET @inico_vigencia = '2023-03-01';
 --   SET @valor_meta = 280000.00;

    ------------------------------------------------------------

    -- DEMAIS VARIAVEIS
    DECLARE @hora_atual INT,
            @data_controle DATE,
            @nivel_hierarquia INT,
			@hierarquia_permitida INT,
			@hora_permitida INT,
			@maior_vigencia DATE,
            @count_meta INT,
            @inedito INT,
			@id_meta INT;

    -- HORA DA EXECUÇÃO
    SET @hora_atual = DATEPART(HOUR, GETDATE());

    -- DATA CONTROLE (RESTRINGE INICIO DE VIGENCIA RETROATIVO)
    SELECT @data_controle = DATEADD(DAY, 1, EOMONTH(GETDATE(), -1));


    --BUSCA O NIVEL DE HIERARQUIA
    SELECT @nivel_hierarquia = c2.nivel_hierarquia
    FROM dbo.Colaborador AS c
        LEFT JOIN dbo.Cargo AS c2
            ON c2.Codigo_do_Cargo = c.Codigo_do_Cargo
    WHERE c.Matricula_do_Colaborador = @matricula_usuario;

	--BUSCA A MAIOR VIGENCIA
	SELECT @maior_vigencia = MAX(m.Inicio_Vigencia) 
	FROM dbo.Meta AS m
	WHERE m.Matricula_do_Colaborador = @matricula_supervisor
	AND m.Codigo_do_Indicador = @cod_indicador


	-- HIERARQUI PERMITIDA
	SET @hierarquia_permitida = 2

	-- HORARIO PERMITIDO
	SET @hora_permitida = 19



	IF @procedimento = 1
	BEGIN
		--======================================================================================================================
		-- PROCEDIMENTO 1 - INSERIR
		--======================================================================================================================
		----------------------------------------------------------------------------------------------------------------------------
		--INICIO
		PRINT 'INICIANDO PROCEDIMENTO DE INSERÇÃO'

		-- VERIFICA HORARIO DA TRANSAÇÃO 
		IF @hora_atual < @hora_permitida
		BEGIN

			--VERIFICA SE O INICIO DA VIGENCIA É RETROATIVO
			IF @inico_vigencia >= @data_controle 
			BEGIN

				IF @inico_vigencia >= @maior_vigencia
				BEGIN

					-- VERFICA SE O USUARIO TEM PERMISSÃO
					IF @nivel_hierarquia = @hierarquia_permitida 
					BEGIN

						-- SETA VARIAVEL INEDITO
						SELECT @inedito = COUNT('')
						FROM dbo.Meta AS m
						WHERE m.Matricula_do_Colaborador = @matricula_supervisor
							  AND m.Codigo_do_Indicador = @cod_indicador;


						-- SETA VARIAVEL COUNT_META
						WITH id
						AS (SELECT MAX(m.id_meta) AS id_max
							FROM dbo.Meta AS m
							WHERE m.Matricula_do_Colaborador = @matricula_supervisor
								  AND m.Codigo_do_Indicador = @cod_indicador),
							 base
						AS (SELECT *
							FROM dbo.Meta AS m
							WHERE m.id_meta =
							(
								SELECT id_max FROM id
							))
						SELECT @count_meta = COUNT('')
						FROM base
						WHERE Matricula_do_Colaborador = @matricula_supervisor
							  AND Codigo_do_Indicador = @cod_indicador
							  AND @inico_vigencia = Inicio_Vigencia ;

						--SETA VARIAVEL ID_META
						SELECT @id_meta = MAX(m.id_meta) 
						FROM dbo.Meta AS m
						WHERE m.Matricula_do_Colaborador = @matricula_supervisor
								  AND m.Codigo_do_Indicador = @cod_indicador


						IF @inedito > 0
						BEGIN

							IF @count_meta = 0
							BEGIN

								PRINT 'ATUALIZA FINAL DA VIGENCIA DA META ANTERIOR';
								UPDATE dbo.Meta
								SET Final_Vigencia = EOMONTH(Inicio_Vigencia, 0)
								WHERE id_meta = @id_meta;
								PRINT 'META ANTERIOR ATUALIZADA';



								PRINT 'LANÇAR NOVA META';
								INSERT INTO dbo.Meta
								(
									Matricula_do_Colaborador,
									Codigo_do_Indicador,
									Inicio_Vigencia,
									Valor_da_Meta
								)
								VALUES
								(@matricula_supervisor, @cod_indicador, @inico_vigencia, @valor_meta);
								PRINT 'META LANÇADA COM SUCESSO!!!';


							END;

							IF @count_meta > 0
							BEGIN
								PRINT 'SUPERVISOR JÁ POSSUI META CADASTRADA NO PERIODO INFORMADO';
							END;


						END;

						IF @inedito = 0
						BEGIN

							PRINT 'LANCAR PRIMEIRA META';
							INSERT INTO dbo.Meta
							(
								Matricula_do_Colaborador,
								Codigo_do_Indicador,
								Inicio_Vigencia,
								Valor_da_Meta
							)
							VALUES
							(@matricula_supervisor, @cod_indicador, @inico_vigencia, @valor_meta);
							PRINT 'PRIMEIRA META LANÇADA COM SUCESSO!!!';

						END;

					END;

					ELSE
						PRINT 'USUÁRIO NÃO TEM PERMISSÃO';

				END
				ELSE
					PRINT 'VIGENCIA FORA DO INTERVALO';

			END;
			ELSE
				PRINT 'VIGENCIA INFORMADA NÃO PERMITIDA';

		END;
		ELSE
			PRINT 'HORARIO NÃO PERMITIDO PARA LANÇAMENTO DE META';


		--FIM
		----------------------------------------------------------------------------------------------------------------------------
	END
	
	IF @procedimento = 2
	BEGIN
		--======================================================================================================================
		-- PROCEDIMENTO 2 - ATUALIZAR
		--======================================================================================================================
		----------------------------------------------------------------------------------------------------------------------------
		--INICIO
		PRINT 'INICIANDO PROCEDIMENTO DE ATUALIZAÇÃO'

		-- VERIFICA HORARIO DA TRANSAÇÃO 
		IF @hora_atual < @hora_permitida
		BEGIN

			--VERIFICA SE O INICIO DA VIGENCIA É RETROATIVO
			IF @inico_vigencia >= @data_controle 
			BEGIN

				-- VERFICA SE O USUARIO TEM PERMISSÃO
				IF @nivel_hierarquia = @hierarquia_permitida 
				BEGIN
					
					PRINT 'ATUALIZANDO META'

					UPDATE dbo.Meta
					SET Valor_da_Meta = @valor_meta
					WHERE Matricula_do_Colaborador = @matricula_supervisor
					AND Codigo_do_Indicador = @cod_indicador
					AND	Inicio_Vigencia = @inico_vigencia
					
					PRINT 'META ATUALIZADA COM SUCESSO!!!'

				END
				ELSE
					PRINT 'USUÁRIO NÃO TEM PERMISSÃO';

			END
			ELSE
				PRINT 'VIGENCIA INFORMADA NÃO PERMITIDA';

		END
		ELSE
			PRINT 'HORARIO NÃO PERMITIDO PARA ATUALIZAÇÃO DE META';

		--FIM
		----------------------------------------------------------------------------------------------------------------------------
	 END  


	 IF @procedimento = 3
	 BEGIN
		--======================================================================================================================
		-- PROCEDIMENTO 3 - EXCLUIR
		--======================================================================================================================
		----------------------------------------------------------------------------------------------------------------------------
		--INICIO
		PRINT 'INICIANDO PROCEDIMENTO DE EXCLUSÃO'

		-- VERIFICA HORARIO DA TRANSAÇÃO 
		IF @hora_atual < @hora_permitida
		BEGIN

			--VERIFICA SE O INICIO DA VIGENCIA É RETROATIVO
			IF @inico_vigencia >= @data_controle 
			BEGIN

				-- VERFICA SE O USUARIO TEM PERMISSÃO
				IF @nivel_hierarquia = @hierarquia_permitida 
				BEGIN

					SELECT @count_meta = COUNT('')
					FROM dbo.Meta
					WHERE Matricula_do_Colaborador = @matricula_supervisor
					AND Codigo_do_Indicador = @cod_indicador
					AND	Inicio_Vigencia = @inico_vigencia
					AND Valor_da_Meta = @valor_meta

					IF @count_meta > 0
					BEGIN
						
						PRINT 'EXCLUINDO META LANÇADA'

						DELETE FROM dbo.Meta
						WHERE Matricula_do_Colaborador = @matricula_supervisor
						AND Codigo_do_Indicador = @cod_indicador
						AND	Inicio_Vigencia = @inico_vigencia
						AND Valor_da_Meta = @valor_meta
					
						PRINT 'META EXCLUIDA COM SUCESSO!!!'

					END
					ELSE
						PRINT 'NÃO EXISTE META'

				END
				ELSE
					PRINT 'USUÁRIO NÃO TEM PERMISSÃO';

			END
			ELSE
				PRINT 'VIGENCIA INFORMADA NÃO PERMITIDA';

		END
		ELSE
			PRINT 'HORARIO NÃO PERMITIDO PARA EXCLUSÃO DE META';


		--FIM
		----------------------------------------------------------------------------------------------------------------------------
	END

END;