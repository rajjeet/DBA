USE [Credit];
GO

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

WHILE 1 = 1 
    BEGIN  

        BEGIN TRY
	
	-- Stops the count of the number of rows affected messages 
            SET NOCOUNT ON;

	-- Automatically roll back the transaction when a run-time error		occurs
	-- THROW honors this.  RAISERROR does not.
            SET XACT_ABORT ON;

	-- Non-transaction code here 

            BEGIN TRANSACTION;
        
            UPDATE  [dbo].[member]
            SET     [member].[lastname] = 'Zuckerton'
            WHERE   [member].[member_no] = 104;

            UPDATE  [dbo].[payment]
            SET     [payment].[payment_amt] = 4193.00
            WHERE   [payment].[member_no] = 104;

            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
    
	   	-- 0 = no active transaction needing to be rolled back
            IF XACT_STATE() <> 0 
                ROLLBACK TRANSACTION;

    -- Error information (if you want it returned as a result set)
            SELECT  ERROR_LINE() AS [Error_Line],
                    ERROR_MESSAGE() AS [Error_Message],
                    ERROR_NUMBER() AS [Error_Number],
                    ERROR_SEVERITY() AS [Error_Severity],
                    ERROR_PROCEDURE() AS [Error_Procedure];

            THROW; -- Uses THROW, so this assumes use of SQL Server							2012 
		 

        END CATCH
    END
GO
