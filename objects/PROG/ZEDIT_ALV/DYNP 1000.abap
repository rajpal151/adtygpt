PROCESS BEFORE OUTPUT.

MODULE %_INIT_PBO.

MODULE %_PBO_REPORT.

MODULE %_PF_STATUS.

MODULE %_SO_VBELN.

MODULE %_END_OF_PBO.

PROCESS AFTER INPUT.

  MODULE %_BACK AT EXIT-COMMAND.

  MODULE %_INIT_PAI.

CHAIN.
  FIELD  SO_VBELN-LOW.
  FIELD  SO_VBELN-HIGH.
  MODULE %_SO_VBELN.
ENDCHAIN.

CHAIN.
  FIELD  SO_VBELN-LOW.
  FIELD  SO_VBELN-HIGH.
  MODULE %_END_OF_SCREEN.
  MODULE %_OK_CODE_1000.
ENDCHAIN.