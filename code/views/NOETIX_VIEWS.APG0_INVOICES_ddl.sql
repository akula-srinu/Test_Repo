-- Purpose: NOETIX_VIEWS.APG0_INVOICES
--
-- MODIFICATION HISTORY
-- Person      Date         Comments
-- ---------   ------       ------------------------------------------
-- Srini Gutha 22-Sep-2014  Initial Version from R12 EBSTST
-- Srini Akula 11-Nov-2014  Latest  Version (from S3B11 Pkg)   


CREATE OR REPLACE FORCE VIEW NOETIX_VIEWS.APG0_INVOICES
(
   A$BATCH_DATE,
   A$BATCH_NAME,
   A$CHART_OF_ACCOUNTS_NAME,
   A$EXPENDITURE_ORGANIZATION_NAM,
   A$INVOICE_CREATION_DATE,
   A$INVOICE_DATE,
   A$INVOICE_NUMBER,
   A$LEDGER_NAME,
   A$OPERATING_UNIT_NAME,
   A$PROJECT_NAME,
   A$PROJECT_NUMBER,
   A$TERMS,
   A$ZZ__________________________,
   ACCTLIAB$CV$ACCOUNTING_KFF,
   ACCTLIAB$CODE_COMBINATION_ID,
   ACCTLIAB$QV$BALANCING,
   ACCTLIAB$QV$COST_CENTER,
   ACCTLIAB$QV$NATURAL_ACCOUNT,
   ACCTLIAB$SEGMENT_NAME_LIST,
   ACCTLIAB$STRUCTURE_NAME,
   ACCTPROJ$CV$ACCOUNTING_KFF,
   ACCTPROJ$CODE_COMBINATION_ID,
   ACCTPROJ$QV$BALANCING,
   ACCTPROJ$QV$COST_CENTER,
   ACCTPROJ$QV$NATURAL_ACCOUNT,
   ACCTPROJ$SEGMENT_NAME_LIST,
   ACCTPROJ$STRUCTURE_NAME,
   AMOUNT_APPLICABLE_TO_DISCOUNT,
   AMOUNT_PAID,
   AMOUNT_PAID_BASE,
   AMT_APPLICABLE_TO_DISC_BASE,
   BASE_AMOUNT,
   BASE_CURRENCY_CODE,
   BATCH_DATE,
   BATCH_NAME,
   CHART_OF_ACCOUNTS_NAME,
   DESCRIPTION,
   DISCOUNT_AMOUNT_TAKEN,
   DISCOUNT_AMOUNT_TAKEN_BASE,
   DISTRIBUTION_TOTAL,
   DOCUMENT_CATEGORY_CODE,
   DOCUMENT_CATEGORY_NAME,
   EXCHANGE_DATE,
   EXCHANGE_RATE,
   EXCHANGE_RATE_TYPE,
   EXPENDITURE_ITEM_DATE,
   EXPENDITURE_ORGANIZATION_NAME,
   EXPENDITURE_TYPE,
   GL_DATE,
   GOODS_RECEIVED_DATE,
   HOLD_ALL_PAYMENTS_FLAG,
   INV$TEST,
   INVOICE_AMOUNT,
   INVOICE_AMOUNT_BASE,
   INVOICE_APPROVAL_STATUS,
   INVOICE_CANCELED_DATE,
   INVOICE_CREATION_DATE,
   INVOICE_CURRENCY_CODE,
   INVOICE_DATE,
   INVOICE_DISTRIBUTION_TOTAL,
   INVOICE_NUMBER,
   INVOICE_RECEIVED_DATE,
   INVOICE_TYPE_LOOKUP_CODE,
   LEDGER_NAME,
   MANUAL_APPROVAL_AMOUNT,
   MANUAL_APPROVAL_AMOUNT_BASE,
   MANUAL_APPROVAL_DESCRIPTION,
   MANUAL_APPROVAL_STATUS,
   OPERATING_UNIT_NAME,
   PA_QUANTITY,
   PAY_ALONE_FLAG,
   PAY_GROUP_LOOKUP_CODE,
   PAYMENT_AMOUNT_TOTAL,
   PAYMENT_AMOUNT_TOTAL_BASE,
   PAYMENT_CURRENCY_CODE,
   PAYMENT_METHOD,
   PAYMENT_METHOD_LOOKUP_CODE,
   PAYMENT_STATUS,
   POSTING_STATUS,
   PROJECT_NAME,
   PROJECT_NUMBER,
   SET_OF_BOOKS_NAME,
   SOURCE,
   TASK_NAME,
   TASK_NUMBER,
   TAX_AMOUNT,
   TAX_AMOUNT_BASE,
   TERMS,
   TERMS_DATE,
   VEND$CERTIFIED_8_A__SB,
   VEND$D_B_D_U_N_S_NUMBER,
   VEND$DISABLED_VETERAN,
   VEND$DISADVANTAGED,
   VEND$FOREIGN_BUSINESS,
   VEND$HUBZONE,
   VEND$HISTORICALLY_BLACK_INSTIT,
   VEND$ITAR_COMPLIANT,
   VEND$LATE_EMAIL_NOTIFICATIONS,
   VEND$MINORITY_INSTITUTIONS,
   VEND$REPS___CERTS_ON_FILE,
   VEND$REQUIRE_PO_ACKNOWLEDGEMEN,
   VEND$SCOPE_OF_APPROVAL,
   VEND$SOURCE_SYSTEM,
   VEND$VETERAN_OWNED,
   VAT_CODE,
   VENDOR_ALTERNATE_NAME,
   VENDOR_NAME,
   VENDOR_NUMBER,
   VENDOR_PREPAY_AMOUNT,
   VENDOR_PREPAY_AMOUNT_BASE,
   VENDOR_SITE_CODE,
   VOUCHER_NUMBER,
   Z$$_________________________,
   Z$APG0_INVOICES,
   Z$ACCTLIAB$XXK_GL_ACCT,
   Z$ACCTPROJ$XXK_GL_ACCT,
   Z$POG0_VENDORS
)
AS
   SELECT BATCH.BATCH_DATE A$Batch_Date,
          BATCH.BATCH_NAME A$Batch_Name,
          XMAP.CHART_OF_ACCOUNTS_NAME A$Chart_Of_Accounts_Name,
          Expenditure_Organization_Name.NAME A$Expenditure_Organization_Nam,
          INV.CREATION_DATE A$Invoice_Creation_Date,
          INV.INVOICE_DATE A$Invoice_Date,
          INV.INVOICE_NUM A$Invoice_Number,
          XMAP.LEDGER_NAME A$Ledger_Name,
          XMAP.OPERATING_UNIT_NAME A$Operating_Unit_Name,
          PROJ.NAME A$Project_Name,
          PROJ.SEGMENT1 A$Project_Number,
          Terms.NAME A$Terms,
          'A$ZZ__________________________Copyright Noetix Corporation 1992-2013'
             A$ZZ__________________________,
          AcctLiab.CV$Accounting_KFF AcctLiab$CV$Accounting_KFF,
          AcctLiab.CODE_COMBINATION_ID AcctLiab$Code_Combination_Id,
          AcctLiab.QV$Balancing AcctLiab$QV$Balancing,
          AcctLiab.QV$Cost_Center AcctLiab$QV$Cost_Center,
          AcctLiab.QV$Natural_Account AcctLiab$QV$Natural_Account,
          AcctLiab.Segment_Name_List AcctLiab$Segment_Name_List,
          AcctLiab.Structure_Name AcctLiab$Structure_Name,
          GL#1.CV$Accounting_KFF AcctProj$CV$Accounting_KFF,
          GL#1.CODE_COMBINATION_ID AcctProj$Code_Combination_Id,
          GL#1.QV$Balancing AcctProj$QV$Balancing,
          GL#1.QV$Cost_Center AcctProj$QV$Cost_Center,
          GL#1.QV$Natural_Account AcctProj$QV$Natural_Account,
          GL#1.Segment_Name_List AcctProj$Segment_Name_List,
          GL#1.Structure_Name AcctProj$Structure_Name,
          NVL (INV.AMOUNT_APPLICABLE_TO_DISCOUNT, 0)
             Amount_Applicable_To_Discount,
          NVL (INV.AMOUNT_PAID, 0) Amount_Paid,
            (  NVL (INV.AMOUNT_PAID, 0)
             / DECODE (INV.PAYMENT_CROSS_RATE,
                       0, 1,
                       NULL, 1,
                       INV.PAYMENT_CROSS_RATE))
          * NVL (
               INV.EXCHANGE_RATE,
               DECODE (INV.INVOICE_CURRENCY_CODE, BOOK.CURRENCY_CODE, 1, 0))
             Amount_Paid_Base,
            (NVL (INV.AMOUNT_APPLICABLE_TO_DISCOUNT, 0))
          * NVL (
               INV.EXCHANGE_RATE,
               DECODE (INV.INVOICE_CURRENCY_CODE,
                       BOOK.CURRENCY_CODE, 1,
                       NULL))
             Amt_Applicable_To_Disc_Base,
          NVL (
             INV.BASE_AMOUNT,
             DECODE (INV.INVOICE_CURRENCY_CODE,
                     BOOK.CURRENCY_CODE, INV.INVOICE_AMOUNT,
                     NULL))
             Base_Amount,
          BOOK.CURRENCY_CODE Base_Currency_Code,
          BATCH.BATCH_DATE Batch_Date,
          BATCH.BATCH_NAME Batch_Name,
          XMAP.CHART_OF_ACCOUNTS_NAME Chart_Of_Accounts_Name,
          INV.DESCRIPTION Description,
          NVL (INV.DISCOUNT_AMOUNT_TAKEN, 0) Discount_Amount_Taken,
            (  NVL (INV.DISCOUNT_AMOUNT_TAKEN, 0)
             / DECODE (INV.PAYMENT_CROSS_RATE,
                       0, 1,
                       NULL, 1,
                       INV.PAYMENT_CROSS_RATE))
          * NVL (
               INV.EXCHANGE_RATE,
               DECODE (INV.INVOICE_CURRENCY_CODE, BOOK.CURRENCY_CODE, 1, 0))
             Discount_Amount_Taken_Base,
          (SELECT SUM (NVL (AID.AMOUNT, 0))
             FROM AP.AP_INVOICE_DISTRIBUTIONS_ALL AID,
                  AP.AP_INVOICE_LINES_ALL AIL
            WHERE     AIL.INVOICE_ID = INV.INVOICE_ID
                  AND AID.INVOICE_ID = AIL.INVOICE_ID
                  AND AID.INVOICE_LINE_NUMBER = AIL.LINE_NUMBER
                  AND (   (    AID.LINE_TYPE_LOOKUP_CODE NOT IN ('PREPAY',
                                                                 'AWT')
                           AND AID.PREPAY_DISTRIBUTION_ID IS NULL)
                       OR NVL (AIL.INVOICE_INCLUDES_PREPAY_FLAG, 'N') = 'Y'))
             Distribution_Total,
          INV.DOC_CATEGORY_CODE Document_Category_Code,
          FDSC.NAME Document_Category_Name,
          INV.EXCHANGE_DATE Exchange_Date,
          INV.EXCHANGE_RATE Exchange_Rate,
          INV.EXCHANGE_RATE_TYPE Exchange_Rate_Type,
          INV.EXPENDITURE_ITEM_DATE Expenditure_Item_Date,
          Expenditure_Organization_Name.NAME Expenditure_Organization_Name,
          INV.EXPENDITURE_TYPE Expenditure_Type,
          INV.GL_DATE GL_Date,
          INV.GOODS_RECEIVED_DATE Goods_Received_Date,
          NVL (VEND.HOLD_ALL_PAYMENTS_FLAG, 'N') Hold_All_Payments_Flag,
          INV.ATTRIBUTE1 INV$Test,
          INV.INVOICE_AMOUNT Invoice_Amount,
          NVL (
             INV.BASE_AMOUNT,
             DECODE (INV.INVOICE_CURRENCY_CODE,
                     BOOK.CURRENCY_CODE, INV.INVOICE_AMOUNT,
                     NULL))
             Invoice_Amount_Base,
          NOETIX_AP_INVOICES_PKG.GET_APPROVAL_STATUS (
             INV.INVOICE_ID,
             INV.INVOICE_AMOUNT,
             INV.PAYMENT_STATUS_FLAG,
             INV.INVOICE_TYPE_LOOKUP_CODE,
             INV.ORG_ID)
             Invoice_Approval_Status,
          INV.CANCELLED_DATE Invoice_Canceled_Date,
          INV.CREATION_DATE Invoice_Creation_Date,
          INV.INVOICE_CURRENCY_CODE Invoice_Currency_Code,
          INV.INVOICE_DATE Invoice_Date,
          DECODE (1, 2, 1, NULL) Invoice_Distribution_Total,
          INV.INVOICE_NUM Invoice_Number,
          INV.INVOICE_RECEIVED_DATE Invoice_Received_Date,
          INV.INVOICE_TYPE_LOOKUP_CODE Invoice_Type_Lookup_Code,
          XMAP.LEDGER_NAME Ledger_Name,
          NVL (INV.APPROVED_AMOUNT, 0) Manual_Approval_Amount,
            (NVL (INV.APPROVED_AMOUNT, 0))
          * NVL (
               INV.EXCHANGE_RATE,
               DECODE (INV.INVOICE_CURRENCY_CODE,
                       BOOK.CURRENCY_CODE, 1,
                       NULL))
             Manual_Approval_Amount_Base,
          INV.APPROVAL_DESCRIPTION Manual_Approval_Description,
          INV.APPROVAL_STATUS Manual_Approval_Status,
          XMAP.OPERATING_UNIT_NAME Operating_Unit_Name,
          NVL (INV.PA_QUANTITY, 0) Pa_Quantity,
          NVL (INV.EXCLUSIVE_PAYMENT_FLAG, 'N') Pay_Alone_Flag,
          INV.PAY_GROUP_LOOKUP_CODE Pay_Group_Lookup_Code,
          NVL (INV.PAYMENT_AMOUNT_TOTAL, 0) Payment_Amount_Total,
            (NVL (INV.PAYMENT_AMOUNT_TOTAL, 0))
          * NVL (
               INV.EXCHANGE_RATE,
               DECODE (INV.INVOICE_CURRENCY_CODE,
                       BOOK.CURRENCY_CODE, 1,
                       NULL))
             Payment_Amount_Total_Base,
          INV.PAYMENT_CURRENCY_CODE Payment_Currency_Code,
          Payment_Method.PAYMENT_METHOD_NAME Payment_Method,
          INV.PAYMENT_METHOD_CODE Payment_Method_Lookup_Code,
          DECODE (INV.PAYMENT_STATUS_FLAG,
                  'N', 'No',
                  'Y', 'Yes',
                  'P', 'Partial',
                  INV.PAYMENT_STATUS_FLAG)
             Payment_Status,
          INV.POSTING_STATUS Posting_Status,
          PROJ.NAME Project_Name,
          PROJ.SEGMENT1 Project_Number,
          TO_CHAR (NULL) Set_Of_Books_Name,
          INV.SOURCE Source,
          TASK.TASK_NAME Task_Name,
          TASK.TASK_NUMBER Task_Number,
          NVL (INV.TOTAL_TAX_AMOUNT, 0) Tax_Amount,
            (NVL (INV.TOTAL_TAX_AMOUNT, 0))
          * NVL (
               INV.EXCHANGE_RATE,
               DECODE (INV.INVOICE_CURRENCY_CODE,
                       BOOK.CURRENCY_CODE, 1,
                       NULL))
             Tax_Amount_Base,
          Terms.NAME Terms,
          INV.TERMS_DATE Terms_Date,
          VEND.ATTRIBUTE7 VEND$Certified_8_a__SB,
          VEND.ATTRIBUTE10 VEND$D_B_D_U_N_S_Number,
          VEND.ATTRIBUTE3 VEND$Disabled_Veteran,
          VEND.ATTRIBUTE1 VEND$Disadvantaged,
          VEND.ATTRIBUTE8 VEND$Foreign_Business,
          VEND.ATTRIBUTE4 VEND$HUBzone,
          VEND.ATTRIBUTE5 VEND$Historically_Black_Instit,
          VEND.ATTRIBUTE12 VEND$ITAR_Compliant,
          VEND.ATTRIBUTE13 VEND$Late_Email_Notifications,
          VEND.ATTRIBUTE6 VEND$Minority_Institutions,
          VEND.ATTRIBUTE14 VEND$Reps___Certs_on_File,
          VEND.ATTRIBUTE11 VEND$Require_PO_Acknowledgemen,
          VEND.ATTRIBUTE9 VEND$Scope_of_Approval,
          VEND.ATTRIBUTE15 VEND$Source_System,
          VEND.ATTRIBUTE2 VEND$Veteran_Owned,
          INV.VAT_CODE Vat_Code,
          VEND.VENDOR_NAME_ALT Vendor_Alternate_Name,
          NVL (VEND.VENDOR_NAME, PRTY.PARTY_NAME) Vendor_Name,
          NVL (VEND.SEGMENT1, PRTY.PARTY_NUMBER) Vendor_Number,
          NVL (NOETIX_AP_INVOICES_PKG.GET_PREPAID_AMOUNT (INV.INVOICE_ID), 0)
             Vendor_Prepay_Amount,
          NOETIX_AP_INVOICES_PKG.GET_PREPAID_AMOUNT_BASE (
             INV.INVOICE_ID,
             INV.INVOICE_CURRENCY_CODE,
             BOOK.CURRENCY_CODE)
             Vendor_Prepay_Amount_Base,
          NVL (VSITE.VENDOR_SITE_CODE, PSITE.PARTY_SITE_NUMBER)
             Vendor_Site_Code,
          NVL (INV.VOUCHER_NUM, INV.DOC_SEQUENCE_VALUE) Voucher_Number,
          'Z$$_________________________' Z$$_________________________,
          INV.ROWID Z$APG0_Invoices,
          AcctLiab.Z$XXK_GL_Acct Z$AcctLiab$XXK_GL_Acct,
          GL#1.Z$XXK_GL_Acct Z$AcctProj$XXK_GL_Acct,
          VEND.ROWID Z$POG0_Vendors
     FROM IBY.IBY_PAYMENT_METHODS_TL Payment_Method,
          HR.HR_ALL_ORGANIZATION_UNITS_TL Expenditure_Organization_Name,
          NOETIX_VIEWS.XXK_GL_Acct GL#1,
          GL.GL_CODE_COMBINATIONS AcctProj,
          NOETIX_VIEWS.XXK_GL_Acct AcctLiab,
          AP.AP_TERMS_TL Terms,
          APPLSYS.FND_DOC_SEQUENCE_CATEGORIES FDSC,
          AR.HZ_PARTY_SITES PSITE,
          AR.HZ_PARTIES PRTY,
          PA.PA_PROJECTS_ALL PROJ,
          PA.PA_TASKS TASK,
          AP.AP_SUPPLIER_SITES_ALL VSITE,
          GL.GL_LEDGERS BOOK,
          AP.AP_BATCHES_ALL BATCH,
          AP.AP_SUPPLIERS VEND,
          NOETIX_VIEWS.APG0_OU_ACL_Map_Base XMAP,
          AP.AP_INVOICES_ALL INV
    WHERE     'Copyright Noetix Corporation 1992-2013' IS NOT NULL
          AND VEND.VENDOR_ID(+) = INV.VENDOR_ID
          AND NVL (INV.ORG_ID, -9999) = XMAP.ORG_ID
          AND BATCH.BATCH_ID(+) = INV.BATCH_ID
          AND INV.SET_OF_BOOKS_ID = BOOK.LEDGER_ID
          AND NVL (BATCH.ORG_ID, XMAP.ORG_ID) = XMAP.ORG_ID
          AND INV.VENDOR_SITE_ID = VSITE.VENDOR_SITE_ID(+)
          AND NVL (VSITE.ORG_ID, XMAP.ORG_ID) = XMAP.ORG_ID
          AND TASK.TASK_ID(+) = INV.TASK_ID
          AND PROJ.PROJECT_ID(+) = INV.PROJECT_ID
          AND PRTY.PARTY_ID(+) = INV.PARTY_ID
          AND PSITE.PARTY_SITE_ID(+) = INV.PARTY_SITE_ID
          AND FDSC.CODE(+) = INV.DOC_CATEGORY_CODE
          AND FDSC.APPLICATION_ID(+) = 200
          AND INV.TERMS_ID = Terms.TERM_ID(+)
          AND Terms.LANGUAGE(+) = NOETIX_ENV_PKG.GET_LANGUAGE
          AND INV.ACCTS_PAY_CODE_COMBINATION_ID =
                 AcctLiab.CODE_COMBINATION_ID(+)
          AND INV.PA_DEFAULT_DIST_CCID = AcctProj.CODE_COMBINATION_ID(+)
          AND INV.EXPENDITURE_ORGANIZATION_ID =
                 Expenditure_Organization_Name.ORGANIZATION_ID(+)
          AND Expenditure_Organization_Name.LANGUAGE(+) =
                 NOETIX_ENV_PKG.GET_LANGUAGE
          AND INV.PAYMENT_METHOD_CODE = Payment_Method.PAYMENT_METHOD_CODE(+)
          AND Payment_Method.LANGUAGE(+) = NOETIX_ENV_PKG.GET_LANGUAGE
          AND AcctProj.CODE_COMBINATION_ID = GL#1.CODE_COMBINATION_ID(+);

