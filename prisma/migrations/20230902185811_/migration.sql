BEGIN TRY

BEGIN TRAN;

-- RedefineTables
BEGIN TRANSACTION;
DECLARE @SQL NVARCHAR(MAX) = N''
SELECT @SQL += N'ALTER TABLE '
    + QUOTENAME(OBJECT_SCHEMA_NAME(PARENT_OBJECT_ID))
    + '.'
    + QUOTENAME(OBJECT_NAME(PARENT_OBJECT_ID))
    + ' DROP CONSTRAINT '
    + OBJECT_NAME(OBJECT_ID) + ';'
FROM SYS.OBJECTS
WHERE TYPE_DESC LIKE '%CONSTRAINT'
    AND OBJECT_NAME(PARENT_OBJECT_ID) = 'Prompt'
    AND SCHEMA_NAME(SCHEMA_ID) = 'dbo'
EXEC sp_executesql @SQL
;
CREATE TABLE [dbo].[_prisma_new_Prompt] (
    [creator] INT NOT NULL,
    [prompt] NVARCHAR(1000) NOT NULL,
    [tag] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Prompt_pkey] PRIMARY KEY CLUSTERED ([creator])
);
IF EXISTS(SELECT * FROM [dbo].[Prompt])
    EXEC('INSERT INTO [dbo].[_prisma_new_Prompt] ([creator],[prompt],[tag]) SELECT [creator],[prompt],[tag] FROM [dbo].[Prompt] WITH (holdlock tablockx)');
DROP TABLE [dbo].[Prompt];
EXEC SP_RENAME N'dbo._prisma_new_Prompt', N'Prompt';
COMMIT;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
