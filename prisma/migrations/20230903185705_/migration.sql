/*
  Warnings:

  - The primary key for the `Prompt` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
BEGIN TRY

BEGIN TRAN;

-- AlterTable
ALTER TABLE [dbo].[Prompt] DROP CONSTRAINT [Prompt_pkey];
ALTER TABLE [dbo].[Prompt] ALTER COLUMN [creator] NVARCHAR(1000) NOT NULL;
ALTER TABLE [dbo].[Prompt] ADD CONSTRAINT Prompt_pkey PRIMARY KEY CLUSTERED ([creator]);

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
