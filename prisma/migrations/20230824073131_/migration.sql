BEGIN TRY

BEGIN TRAN;

-- AlterTable
EXEC SP_RENAME N'dbo.PK__Person__AA2FFBE5BC3FEE8D', N'Person_pkey';

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH