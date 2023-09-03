BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[Prompt] DROP CONSTRAINT [Prompt_creatorId_fkey];

-- AlterTable
ALTER TABLE [dbo].[Prompt] ALTER COLUMN [creatorId] NVARCHAR(1000) NOT NULL;

-- AddForeignKey
ALTER TABLE [dbo].[Prompt] ADD CONSTRAINT [Prompt_creatorId_fkey] FOREIGN KEY ([creatorId]) REFERENCES [dbo].[Profile]([userId]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
