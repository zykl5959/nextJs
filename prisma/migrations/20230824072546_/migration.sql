/*
  Warnings:

  - The primary key for the `Person` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[Profile] DROP CONSTRAINT [Profile_userId_fkey];

-- DropIndex
ALTER TABLE [dbo].[Profile] DROP CONSTRAINT [Profile_userId_key];

-- AlterTable
ALTER TABLE [dbo].[Profile] ALTER COLUMN [userId] NVARCHAR(1000) NOT NULL;

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
    AND OBJECT_NAME(PARENT_OBJECT_ID) = 'Person'
    AND SCHEMA_NAME(SCHEMA_ID) = 'dbo'
EXEC sp_executesql @SQL
;
CREATE TABLE [dbo].[_prisma_new_Person] (
    [PersonId] NVARCHAR(1000) NOT NULL,
    [FirstName] NVARCHAR(128) NOT NULL,
    [MiddelInitial] NVARCHAR(10),
    [LastName] NVARCHAR(128) NOT NULL,
    [DateOfBirth] DATE NOT NULL,
    CONSTRAINT [PK__Person__AA2FFBE5BC3FEE8D] PRIMARY KEY CLUSTERED ([PersonId])
);
IF EXISTS(SELECT * FROM [dbo].[Person])
    EXEC('INSERT INTO [dbo].[_prisma_new_Person] ([DateOfBirth],[FirstName],[LastName],[MiddelInitial],[PersonId]) SELECT [DateOfBirth],[FirstName],[LastName],[MiddelInitial],[PersonId] FROM [dbo].[Person] WITH (holdlock tablockx)');
DROP TABLE [dbo].[Person];
EXEC SP_RENAME N'dbo._prisma_new_Person', N'Person';
COMMIT;

-- CreateIndex
ALTER TABLE [dbo].[Profile] ADD CONSTRAINT [Profile_userId_key] UNIQUE NONCLUSTERED ([userId]);

-- AddForeignKey
ALTER TABLE [dbo].[Profile] ADD CONSTRAINT [Profile_userId_fkey] FOREIGN KEY ([userId]) REFERENCES [dbo].[Person]([PersonId]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
