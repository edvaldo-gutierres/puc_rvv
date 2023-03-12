USE rvv;

SELECT Codigo_do_Cargo,
       Nome_do_Cargo,
       Status_do_Cargo,
       nivel_hierarquia
FROM [dbo].[Cargo];


SELECT Matricula_do_Colaborador,
       Nome_do_Colaborador,
       Sexo,
       CPF,
       Data_Nascimento,
       Codigo_do_Departamento,
       Codigo_do_Cargo,
       Salario
FROM [dbo].[Colaborador];


SELECT Codigo_do_Departamento,
       Nome_do_Departamento,
       Status_do_Departamento
FROM [dbo].[Departamento];


SELECT id_meta,
       Matricula_do_Colaborador,
       Codigo_do_Indicador,
       Inicio_Vigencia,
       Final_Vigencia,
       Valor_da_Meta
FROM [dbo].[Meta];


SELECT Codigo_do_Indicador,
       Nome_do_Indicador,
       Codigo_do_Departamento,
       Codigo_do_Cargo,
       Peso_do_Indicador,
       Inicio_Vigencia,
       Final_Vigencia
FROM [dbo].[Indicadores];


SELECT id_resultado,
       Matricula_do_Colaborador,
       Codigo_do_Indicador,
       Competencia,
       Valor_do_Resultado
FROM [dbo].[Resultado];


SELECT id_comissao,
       Matricula_do_Colaborador,
       Codigo_do_Indicador,
       Competencia,
       Valor_do_Resultado,
       Valor_da_Meta,
       Atingimento,
       Peso_do_Indicador,
       Base_Calculo,
       Comissao
FROM [dbo].[Comissao];