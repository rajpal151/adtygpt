class-pool .
*"* class pool for class ZCL_GCTS_TEST

*"* local type definitions
include ZCL_GCTS_TEST=================ccdef.

*"* class ZCL_GCTS_TEST definition
*"* public declarations
  include ZCL_GCTS_TEST=================cu.
*"* protected declarations
  include ZCL_GCTS_TEST=================co.
*"* private declarations
  include ZCL_GCTS_TEST=================ci.
endclass. "ZCL_GCTS_TEST definition

*"* macro definitions
include ZCL_GCTS_TEST=================ccmac.
*"* local class implementation
include ZCL_GCTS_TEST=================ccimp.

*"* test class
include ZCL_GCTS_TEST=================ccau.

class ZCL_GCTS_TEST implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_GCTS_TEST implementation
