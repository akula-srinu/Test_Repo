
select * from wb_join_key_templates j
 --  set j.key_name = j.key_name||'_1'
 WHERE j.view_label            = 'PO_All_Distribution_Vsat'
 and revision_id = '7bd531842ba846fe98754587032161d8'
--   AND j.key_name              = 'ROWID_FK_POHDR'
--   AND j.referenced_view_label = 'PO_Vendor_Contacts';
   
-------------
select * from 

delete wb_join_key_templates j
 --  set j.key_name = j.key_name||'_1'
 WHERE j.view_label            = 'PO_All_Distribution_Vsat'
   AND j.key_name              = 'ROWID_FK_POHDR'
   AND j.referenced_view_label = 'PO_Vendor_Contacts';
   

select * from 

delete wb_view_column_templates
where view_label            = 'PO_All_Distribution_Vsat'
--and revision_id = '7bd531842ba846fe98754587032161d8'
and column_type = 'ROWID'
and column_label = 'POHDR$PO_Vendor_Contacts'

-------

delete 
 from wb_join_key_templates j
 --  set j.key_name = j.key_name||'_1'
 WHERE j.view_label            = 'PO_All_Distribution_Vsat'
   AND j.key_name              = 'ROWID_FK_POHDR'
   AND j.referenced_view_label = 'PO_Vendor_Sites';
   

select * from 

delete
 from  wb_view_column_templates
where view_label            = 'PO_All_Distribution_Vsat'
--and revision_id = '7bd531842ba846fe98754587032161d8'
and column_type = 'ROWID'
and column_label = 'POHDR$PO_Vendor_Sites'

-----------

delete 
 from wb_join_key_templates j
 --  set j.key_name = j.key_name||'_1'
 WHERE j.view_label            = 'PO_All_Distribution_Vsat'
   AND j.key_name              = 'ROWID_FK_POHDR'
   AND j.referenced_view_label = 'PO_Blanket_POs';
   

select * from 

delete
from  wb_view_column_templates
where view_label            = 'PO_All_Distribution_Vsat'
--and revision_id = '7bd531842ba846fe98754587032161d8'
and column_type = 'ROWID'
and column_label = 'POHDR$PO_Blanket_POs'

-----



select distinct referenced_view_label, key_name 

delete from wb_join_key_templates j
 --  set j.key_name = j.key_name||'_1'
 WHERE j.view_label            = 'PO_PO_Distributions'
   AND j.key_name              in ( 'ROWID_FK_PDSTR' )
--   and revision_id = '0f6c9de7210e4cdb81e8a57b40fff90f'
   AND j.referenced_view_label = 'PO_PO_Lines';
   
delete from wb_join_key_templates j
 --  set j.key_name = j.key_name||'_1'
 WHERE j.view_label            = 'PO_PO_Distributions'
   AND j.key_name              in ( 'ROWID_FK_PDSTR' )
--   and revision_id = '0f6c9de7210e4cdb81e8a57b40fff90f'
   AND j.referenced_view_label = 'PO_PO_Shipments';
   
delete from wb_join_key_templates j
 --  set j.key_name = j.key_name||'_1'
 WHERE j.view_label            = 'PO_PO_Distributions'
   AND j.key_name              in ( 'ROWID_FK_PDSTR' )
--   and revision_id = '0f6c9de7210e4cdb81e8a57b40fff90f'
   AND j.referenced_view_label = 'PO_Purchase_Orders';
   
delete from wb_join_key_templates j
 --  set j.key_name = j.key_name||'_1'
 WHERE j.view_label            = 'PO_PO_Distributions'
   AND j.key_name              in ( 'ROWID_FK_POHDR' )
--   and revision_id = '0f6c9de7210e4cdb81e8a57b40fff90f'
   AND j.referenced_view_label = 'PO_Vendor_Contacts';
   
delete from wb_join_key_templates j
 --  set j.key_name = j.key_name||'_1'
 WHERE j.view_label            = 'PO_PO_Distributions'
   AND j.key_name              in ( 'ROWID_FK_POHDR' )
--   and revision_id = '0f6c9de7210e4cdb81e8a57b40fff90f'
   AND j.referenced_view_label = 'PO_Vendor_Sites';
   
select * from 

delete


select distinct column_label 

delete  from  wb_view_column_templates
where view_label            = 'PO_PO_Distributions'
--and revision_id = '7bd531842ba846fe98754587032161d8'
and column_type = 'ROWID'
and column_label in ('PDSTR$PO_Purchase_Orders','PDSTR$PO_PO_Shipments','POHDR$PO_Vendor_Contacts', 'PDSTR$PO_PO_Lines', 'POHDR$PO_Vendor_Sites' )

-----

select *

delete from wb_join_key_templates j
--   set j.key_name = j.key_name||'_2'
 WHERE j.view_label            = 'PO_Expected_Receipts_Vsat_Bkp'
   AND j.key_name              = 'ROWID_FK_POHDR'
      AND j.referenced_view_label = 'PO_Vendor_Contacts';

select *

delete from  wb_view_column_templates
where view_label            = 'PO_Expected_Receipts_Vsat_Bkp'
--and revision_id = '7bd531842ba846fe98754587032161d8'
and column_type = 'ROWID'
and column_label = 'POHDR$PO_Vendor_Contacts'


select *

delete from wb_join_key_templates j
--   set j.key_name = j.key_name||'_2'
 WHERE j.view_label            = 'PO_Expected_Receipts_Vsat_Bkp'
   AND j.key_name              = 'ROWID_FK_RCVTR'
         AND j.referenced_view_label <> 'PO_PO_Shipments';


select * 

delete from  wb_view_column_templates
where view_label            = 'PO_Expected_Receipts_Vsat_Bkp'
--and revision_id = '7bd531842ba846fe98754587032161d8'
and column_type = 'ROWID'
and column_label in ('RCVTR$PO_PO_Lines', 'RCVTR$PO_Vendor_Sites', 'RCVTR$PO_PO_Distributions' )

select * from wb_join_key_col_templates
where revision_id = '7bd531842ba846fe98754587032161d8'
and wb_join_key_id = 'eb478635142248c083bc9ea83b126a06'

select * from wb_join_key_templates j
 --  set j.key_name = j.key_name||'_1'
 WHERE j.view_label            = 'PO_All_Distribution_Vsat'
   AND j.key_name              = 'ROWID_FK_POHDR'
   AND j.referenced_view_label = 'PO_Vendor_Contacts';