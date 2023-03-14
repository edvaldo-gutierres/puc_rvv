--USE rvv;

ALTER PROCEDURE spr_cadastro_cargo
		@procedimento INT,
        @matricula_usuario INT,
        @nome_cargo VARCHAR(30),
        @status_cargo BIT,
		@hierarquia_cargo INT,
        @cod_cargo_atualizacao INT 
AS
BEGIN
    /*
	Cod Desafio: D18
	Cod RF: RF11 - Criar e atualizar cadastro de cargos
	Usuário chave: Administrativo
	*/
    ---------------------------------------------------------------
    -- - PROCEDIMENTOS:
    -- VERIFICA SE O USUÁRIO TEM PERMISSÃO
    -- INSERIR NOVO CARGO
    -- ALTERAR CARGO


    -- EXCLUIR CARGO
    -- VERIFICA SE TEM FUNCIONARIO POSICIONADO
    -- VERIFICA SE PARTICIPA DE INDICADORES
    ---------------------------------------------------------------

    --DECLARE @procedimento INT,
    --        @matricula_usuario INT,
    --        @nome_cargo VARCHAR(30),
    --        @status_cargo BIT,
    --        @hierarquia_cargo INT,
    --        @cod_cargo_atualizacao INT;


    --SET @procedimento = 3;
    --SET @matricula_usuario = 1000006;
    --SET @nome_cargo = 'Teste';
    --SET @status_cargo = 1;
    --SET @hierarquia_cargo = 2;
    --SET @cod_cargo_atualizacao = 1006;


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

            INSERT dbo.Cargo
            (
                Nome_do_Cargo,
                Status_do_Cargo,
                nivel_hierarquia
            )
            VALUES
            (   @nome_cargo,      -- Nome_do_Cargo - varchar(30)
                1,                -- Status_do_Cargo - bit
                @hierarquia_cargo -- nivel_hierarquia - int
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

            UPDATE dbo.Cargo
            SET Nome_do_Cargo = @nome_cargo
            WHERE Codigo_do_Cargo = @cod_cargo_atualizacao;

            IF @status_cargo IS NOT NULL
            BEGIN
                UPDATE dbo.Cargo
                SET Status_do_Cargo = @status_cargo
                WHERE Codigo_do_Cargo = @cod_cargo_atualizacao;
            END;

            IF @hierarquia_cargo IS NOT NULL
            BEGIN
                UPDATE dbo.Cargo
                SET nivel_hierarquia = @hierarquia_cargo
                WHERE Codigo_do_Cargo = @cod_cargo_atualizacao;
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
        SELECT @chk_depto = COUNT('')
        FROM dbo.Cargo AS d
        WHERE d.Codigo_do_Cargo = @cod_cargo_atualizacao;

        -- VERIFICA SE EXISTE FUNCIONARIO LOTADO
        SELECT @chk_colaborador = COUNT('')
        FROM dbo.Colaborador AS c
        WHERE c.Codigo_do_Cargo = @cod_cargo_atualizacao;

        -- VERIFICA SE PARTICIPA DE INDICADORES
        SELECT @chk_indicador = COUNT('')
        FROM dbo.Indicadores AS i
        WHERE i.Codigo_do_Cargo = @cod_cargo_atualizacao;


        PRINT 'INICIANDO PROCEDIMENTO DE EXCLUSÃO';

        -- VERFICA SE O USUARIO TEM PERMISSÃO
        IF @ind_permissao > 0
        BEGIN

            IF @chk_depto > 0
            BEGIN

                IF @chk_colaborador = 0
                BEGIN

                    IF @chk_indicador = 0
                    BEGIN

                        DELETE FROM dbo.Cargo
                        WHERE Codigo_do_Cargo = @cod_cargo_atualizacao;

                        PRINT 'CADASTRO EXCLUÍDO COM SUCESSO!!!';

                    END;
                    ELSE
                        PRINT 'NÃO É PERMITIDO A EXCLUSÃO, POIS PARTICIPA DE INDICADORES';

                END;
                ELSE
                    PRINT 'NÃO É PERMITIDO A EXCLUSÃO, POIS EXISTE FUNCIONARIO LOTADO';

            END;
            ELSE
                PRINT 'CADASTRO NÃO EXISTE';

        END;
        ELSE
            PRINT 'USUÁRIO NÃO TEM PERMISSÃO';


    --FIM
    ----------------------------------------------------------------------------------------------------------------------------
    END;

END;