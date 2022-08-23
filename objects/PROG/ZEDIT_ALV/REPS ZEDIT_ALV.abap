*&---------------------------------------------------------------------*
*& Report ZEDIT_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDIT_ALV.

type-pools : slis.

data : lv_vbeln type vbak-vbeln.

types : BEGIN OF ty_vbak,

vbeln type vbak-vbeln,

erdat TYPE vbak-erdat,

erzet TYPE vbak-erzet,

ernam type vbak-ernam,

end of ty_vbak.

data : lt_vbak type STANDARD TABLE OF ty_vbak,

ls_vbak type ty_vbak.

types : begin of ty_vbap,

vbeln type vbap-vbeln,

posnr type vbap-posnr,

matnr TYPE vbap-matnr,

end of ty_vbap.

data : lt_vbap type STANDARD TABLE OF ty_vbap,

ls_vbap type ty_vbap.

data : lt_fcat type SLIS_T_FIELDCAT_ALV,

ls_fcat like LINE OF lt_fcat.

data : lt_events type SLIS_T_EVENT,

ls_events like line of lt_events.

SELECT-OPTIONS so_vbeln FOR lv_vbeln.

INITIALIZATION.

so_vbeln-low = '4970'.

so_vbeln-high = '4975'.

append so_vbeln.

START-OF-SELECTION.

perform getdata.

if sy-subrc eq 0.

perform fldcat.

perform events.

perform display.

endif.

form GETDATA .

select vbeln erdat erzet ernam FROM vbak

into CORRESPONDING FIELDS OF TABLE lt_vbak

where vbeln in so_vbeln.

endform. " GETDATA

form FLDCAT .

clear ls_fcat.

ls_fcat-fieldname = 'VBELN'.

ls_fcat-col_pos = 1.

ls_fcat-seltext_m = 'Sales No'.

ls_fcat-outputlen = 10.

ls_fcat-edit = 'X'.

APPEND ls_fcat to lt_fcat.

clear ls_fcat.

ls_fcat-fieldname = 'ERDAT'.

ls_fcat-col_pos = 2.

ls_fcat-seltext_m = 'Date'.

ls_fcat-outputlen = 10.

APPEND ls_fcat to lt_fcat.

clear ls_fcat.

ls_fcat-fieldname = 'ERZET'.

ls_fcat-col_pos = 3.

ls_fcat-seltext_m = 'Time'.

ls_fcat-outputlen = 10.

APPEND ls_fcat to lt_fcat.

clear ls_fcat.

ls_fcat-fieldname = 'ERNAM'.

ls_fcat-col_pos = 4.

ls_fcat-seltext_m = 'Created By'.

ls_fcat-outputlen = 10.

APPEND ls_fcat to lt_fcat.

endform. " FLDCAT

form pf-status USING status.

set PF-STATUS 'SETABC'.

ENDFORM.

form DISPLAY .

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

EXPORTING

I_CALLBACK_PROGRAM = sy-repid

IT_FIELDCAT = lt_fcat[]

IT_EVENTS = lt_events[]

TABLES

t_outtab = lt_vbak[].

endform. " DISPLAY

form EVENTS .

clear lt_events.

ls_events-name = 'USER_COMMAND'.

ls_events-form = 'ZITEM'.

append ls_events to lt_events.

endform. " EVENTS

form zitem using ucomm type sy-ucomm

sel type slis_selfield.

read table lt_vbak into ls_vbak index

sel-tabindex.

if sy-subrc eq 0.

clear lv_vbeln.

lv_vbeln = ls_vbak-vbeln.

if lv_vbeln is not INITIAL.

perform getvbap.

if lt_vbap[] is not INITIAL.

perform fieldcat.

perform displayvbap.

ENDIF.

endif.

endif.

ENDFORM.

form GETVBAP .

select vbeln posnr matnr FROM vbap into table lt_vbap

where vbeln = lv_vbeln.

endform. " GETVBAP

form FIELDCAT .

REFRESH lt_fcat[].

clear ls_fcat.

ls_fcat-fieldname = 'VBELN'.

ls_fcat-col_pos = 1.

ls_fcat-seltext_m = 'Sales No'.

ls_fcat-outputlen = 10.

APPEND ls_fcat to lt_fcat.

clear ls_fcat.

ls_fcat-fieldname = 'POSNR'.

ls_fcat-col_pos = 2.

ls_fcat-seltext_m = 'Item No'.

ls_fcat-outputlen = 10.

APPEND ls_fcat to lt_fcat.

clear ls_fcat.

ls_fcat-fieldname = 'MATNR'.

ls_fcat-col_pos = 3.

ls_fcat-seltext_m = 'Material No'.

ls_fcat-outputlen = 10.

APPEND ls_fcat to lt_fcat.

endform. " FIELDCAT

form DISPLAYVBAP .

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

EXPORTING

IT_FIELDCAT = lt_fcat[]

TABLES

t_outtab = lt_vbap[].

endform. " DISPLAYVBAP