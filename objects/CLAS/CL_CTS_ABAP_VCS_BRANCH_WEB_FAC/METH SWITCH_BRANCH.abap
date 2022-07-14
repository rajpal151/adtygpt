  method switch_branch.

    data: ls_request type cl_cts_abap_vcs_branch_facade=>ty_switch_branch_request.
    data: ls_response type cl_cts_abap_vcs_branch_facade=>ty_switch_branch_response.

    ls_request-repository = repository.
    ls_request-branch   = cl_http_client=>if_http_client~unescape_url( branch ).
    ls_response = cl_cts_abap_vcs_branch_facade=>switch_branch( ls_request ).

    response-code = prepare_response( changing data = ls_response ).
    response-content = /ui2/cl_json=>serialize(
      data = ls_response
      compress = abap_true
      pretty_name = /ui2/cl_json=>pretty_mode-camel_case
    ).
  endmethod.