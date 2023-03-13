

ALTER PROCEDURE spr_meta_vendedor
	@procedimento AS INT,
    @matricula_usuario INT,
    @matricula_vendedor INT,
    @cod_indicador INT,
    @inico_vigencia DATE,
    @valor_meta DECIMAL(32, 8)
AS
BEGIN

	/*
	Cod Desafio: D05
	Cod RF: RF05 - Inserir metas dos Vendedores
	Usu�rio chave: Supervisor
	*/
    -- VERIFICA SE O HORARIO DE LAN�AMENTO � ANTES DAS 8H - OK
    -- VERIFICA SE O INICIO DA VIGENCIA INFORMADA N�O � RETROATIVO - OK
    -- VERIFICA SE O USUARIO � SUPERVISOR E PERTENCE AO MESMO DEPARTAMENTO DO VENDEDOR - OK
    -- VERIFICA SE O FUNCIONARIO POSSUI META LAN�ADA NO PERIODO CORRESPONDENTE - OK
    -- VERIFICA SE � PRIMEIRA META, SE VERDADEIRO INSERE OS DADOS DE META, SE FALSO, ALTERA A FINAL DA VIGENCIA DA META ANTERIOR E INSERE OS DADOS DA NOVA META VIGENTE - OK
    ------------------------------------------------------------

    ------------------------------------------------------------
    -- VARIAVEIS DE ENTRADA

	--DECLARE 	
	--@procedimento AS INT,
 --   @matricula_usuario INT,
 --   @matricula_vendedor INT,
 --   @cod_indicador INT,
 --   @inico_vigencia DATE,
 --   @valor_meta DECIMAL(32, 8)

	--SET @procedimento = 1

 --   SET @matricula_usuario = 1000003;

 --   SET @matricula_vendedor = 1000007;
 --   SET @cod_indicador = 1;
 --   SET @inico_vigencia = '2023-03-01';
 --   SET @valor_meta = 80000.00;

    ------------------------------------------------------------

    -- DEMAIS VARIAVEIS
    DECLARE @hora_atual INT,
            @data_controle DATE,
            @nivel_hierarquia INT,
			@hierarquia_permitida INT,
			@dpto_supervisor INT,
			@dpto_vendedor INT,
			@hora_permitida INT,
			@maior_vigencia DATE,
            @count_meta INT,
            @inedito INT,
			@id_meta INT;

    -- HORA DA EXECU��O
    SET @hora_atual = DATEPART(HOUR, GETDATE());

    -- DATA CONTROLE (RESTRINGE INICIO DE VIGENCIA RETROATIVO)
    SELECT @data_controle = DATEADD(DAY, 1, EOMONTH(GETDATE(), -1));


    --BUSCA O NIVEL DE HIERARQUIA
    SELECT @nivel_hierarquia = c2.nivel_hierarquia
    FROM dbo.Colaborador AS c
        LEFT JOIN dbo.Cargo AS c2
            ON c2.Codigo_do_Cargo = c.Codigo_do_Cargo
    WHERE c.Matricula_do_Colaborador = @matricula_usuario;


	--BUSCA DEPARTAMENTO DO USUARIO (SUPERVISOR)
	SELECT @dpto_supervisor = c.Codigo_do_Departamento 
	FROM dbo.Colaborador AS c
	WHERE c.Matricula_do_Colaborador = @matricula_usuario


	--BUSCA DEPARTAMENTO DO VENDEDOR
	SELECT @dpto_vendedor = c.Codigo_do_Departamento 
	FROM dbo.Colaborador AS c
	WHERE c.Matricula_do_Colaborador = @matricula_vendedor
	

	--BUSCA A MAIOR VIGENCIA
	SELECT @maior_vigencia = MAX(m.Inicio_Vigencia) 
	FROM dbo.Meta AS m
	WHERE m.Matricula_do_Colaborador = @matricula_vendedor
	AND m.Codigo_do_Indicador = @cod_indicador


	-- HIERARQUI PERMITIDA 
	SET @hierarquia_permitida = 3    -- HIERARQUIA DO USUARIO

	-- HORARIO PERMITIDO
	SET @hora_permitida = 22



	IF @procedimento = 1
	BEGIN
		--======================================================================================================================
		-- PROCEDIMENTO 1 - INSERIR
		--======================================================================================================================
		----------------------------------------------------------------------------------------------------------------------------
		--INICIO
		PRINT 'INICIANDO PROCEDIMENTO DE INSER��O'

		-- VERIFICA HORARIO DA TRANSA��O 
		IF @hora_atual < @hora_permitida
		BEGIN

			--VERIFICA SE O INICIO DA VIGENCIA � RETROATIVO
			IF @inico_vigencia >= @data_controle 
			BEGIN

				--VERIFICA SE H� META NO INTERVALO
				IF @inico_vigencia >= ISNULL(@maior_vigencia,@inico_vigencia)
				BEGIN

					-- VERFICA SE O USUARIO TEM PERMISS�O
					IF @nivel_hierarquia = @hierarquia_permitida AND @dpto_supervisor = @dpto_vendedor
					BEGIN

						-- SETA VARIAVEL INEDITO
						SELECT @inedito = COUNT('')
						FROM dbo.Meta AS m
						WHERE m.Matricula_do_Colaborador = @matricula_vendedor
							  AND m.Codigo_do_Indicador = @cod_indicador;


						-- SETA VARIAVEL COUNT_META
						WITH id
						AS (SELECT MAX(m.id_meta) AS id_max
							FROM dbo.Meta AS m
							WHERE m.Matricula_do_Colaborador = @matricula_vendedor
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
						WHERE Matricula_do_Colaborador = @matricula_vendedor
							  AND Codigo_do_Indicador = @cod_indicador
							  AND @inico_vigencia = Inicio_Vigencia ;

						--SETA VARIAVEL ID_META
						SELECT @id_meta = MAX(m.id_meta) 
						FROM dbo.Meta AS m
						WHERE m.Matricula_do_Colaborador = @matricula_vendedor
								  AND m.Codigo_do_Indicador = @cod_indicador


						IF @inedito > 0
						BEGIN

							IF @count_meta = 0
							BEGIN

								PRINT 'ATUALIZA FINAL DA VIGENCIA DA META ANTERIOR';
								UPDATE dbo.Meta
								SET Final_Vigencia = EOMONTH(@inico_vigencia, -1)
								WHERE id_meta = @id_meta;
								PRINT 'META ANTERIOR ATUALIZADA';



								PRINT 'LAN�AR NOVA META';
								INSERT INTO dbo.Meta
								(
									Matricula_do_Colaborador,
									Codigo_do_Indicador,
									Inicio_Vigencia,
									Valor_da_Meta
								)
								VALUES
								(@matricula_vendedor, @cod_indicador, @inico_vigencia, @valor_meta);
								PRINT 'META LAN�ADA COM SUCESSO!!!';


							END;

							IF @count_meta > 0
							BEGIN
								PRINT 'SUPERVISOR J� POSSUI META CADASTRADA NO PERIODO INFORMADO';
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
							(@matricula_vendedor, @cod_indicador, @inico_vigencia, @valor_meta);
							PRINT 'PRIMEIRA META LAN�ADA COM SUCESSO!!!';

						END;

					END;

					ELSE
						PRINT 'USU�RIO N�O TEM PERMISS�O';

				END
				ELSE
					PRINT 'VIGENCIA FORA DO INTERVALO';

			END;
			ELSE
				PRINT 'VIGENCIA INFORMADA N�O PERMITIDA';

		END;
		ELSE
			PRINT 'HORARIO N�O PERMITIDO PARA LAN�AMENTO DE META';


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
		PRINT 'INICIANDO PROCEDIMENTO DE ATUALIZA��O'

		-- VERIFICA HORARIO DA TRANSA��O 
		IF @hora_atual < @hora_permitida
		BEGIN

			--VERIFICA SE O INICIO DA VIGENCIA � RETROATIVO
			IF @inico_vigencia >= @data_controle 
			BEGIN

				-- VERFICA SE O USUARIO TEM PERMISS�O
				IF @nivel_hierarquia = @hierarquia_permitida AND @dpto_supervisor = @dpto_vendedor
				BEGIN
					
					PRINT 'ATUALIZANDO META'

					UPDATE dbo.Meta
					SET Valor_da_Meta = @valor_meta
					WHERE Matricula_do_Colaborador = @matricula_vendedor
					AND Codigo_do_Indicador = @cod_indicador
					AND	Inicio_Vigencia = @inico_vigencia
					
					PRINT 'META ATUALIZADA COM SUCESSO!!!'

				END
				ELSE
					PRINT 'USU�RIO N�O TEM PERMISS�O';

			END
			ELSE
				PRINT 'VIGENCIA INFORMADA N�O PERMITIDA';

		END
		ELSE
			PRINT 'HORARIO N�O PERMITIDO PARA ATUALIZA��O DE META';

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
		PRINT 'INICIANDO PROCEDIMENTO DE EXCLUS�O'

		-- VERIFICA HORARIO DA TRANSA��O 
		IF @hora_atual < @hora_permitida
		BEGIN

			--VERIFICA SE O INICIO DA VIGENCIA � RETROATIVO
			IF @inico_vigencia >= @data_controle 
			BEGIN

				-- VERFICA SE O USUARIO TEM PERMISS�O
				IF @nivel_hierarquia = @hierarquia_permitida AND @dpto_supervisor = @dpto_vendedor
				BEGIN

					SELECT @count_meta = COUNT('')
					FROM dbo.Meta
					WHERE Matricula_do_Colaborador = @matricula_vendedor
					AND Codigo_do_Indicador = @cod_indicador
					AND	Inicio_Vigencia = @inico_vigencia
					AND Valor_da_Meta = @valor_meta

					IF @count_meta > 0
					BEGIN
						
						PRINT 'EXCLUINDO META LAN�ADA'

						DELETE FROM dbo.Meta
						WHERE Matricula_do_Colaborador = @matricula_vendedor
						AND Codigo_do_Indicador = @cod_indicador
						AND	Inicio_Vigencia = @inico_vigencia
						AND Valor_da_Meta = @valor_meta
					
						PRINT 'META EXCLUIDA COM SUCESSO!!!'

					END
					ELSE
						PRINT 'N�O EXISTE META'

				END
				ELSE
					PRINT 'USU�RIO N�O TEM PERMISS�O';

			END
			ELSE
				PRINT 'VIGENCIA INFORMADA N�O PERMITIDA';

		END
		ELSE
			PRINT 'HORARIO N�O PERMITIDO PARA EXCLUS�O DE META';


		--FIM
		----------------------------------------------------------------------------------------------------------------------------
	END

END;