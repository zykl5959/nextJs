/*
  Warnings:

  - The primary key for the `Prompt` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `creator` on the `Prompt` table. All the data in the column will be lost.
  - Added the required column `creatorId` to the `Prompt` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Prompt` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- AlterTable
ALTER TABLE [dbo].[Prompt] DROP CONSTRAINT [Prompt_pkey];
ALTER TABLE [dbo].[Prompt] DROP COLUMN [creator];
-- ALTER TABLE [dbo].[Prompt] ADD CONSTRAINT Prompt_pkey PRIMARY KEY CLUSTERED ([id]);
ALTER TABLE [dbo].[Prompt] ADD [creatorId] INT NOT NULL,
[id] INT NOT NULL IDENTITY(1,1);

-- AddForeignKey
ALTER TABLE [dbo].[Prompt] ADD CONSTRAINT [Prompt_creatorId_fkey] FOREIGN KEY ([creatorId]) REFERENCES [dbo].[Profile]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
