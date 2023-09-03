BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[Person] (
    [PersonId] INT NOT NULL IDENTITY(1,1),
    [FirstName] NVARCHAR(128) NOT NULL,
    [MiddelInitial] NVARCHAR(10),
    [LastName] NVARCHAR(128) NOT NULL,
    [DateOfBirth] DATE NOT NULL,
    CONSTRAINT [PK__Person__AA2FFBE5BC3FEE8D] PRIMARY KEY CLUSTERED ([PersonId])
);

-- CreateTable
CREATE TABLE [dbo].[Profile] (
    [id] INT NOT NULL IDENTITY(1,1),
    [bio] NVARCHAR(1000),
    [userId] INT NOT NULL,
    CONSTRAINT [Profile_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Profile_userId_key] UNIQUE NONCLUSTERED ([userId])
);

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
