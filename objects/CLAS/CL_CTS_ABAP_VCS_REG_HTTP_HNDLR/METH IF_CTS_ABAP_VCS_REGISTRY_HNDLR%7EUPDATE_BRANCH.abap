  method if_cts_abap_vcs_registry_hndlr~update_branch.

    data: ls_body type ref to data.

    get reference of update_branch_info into ls_body.
    data(action) = if_cts_abap_vcs_registry_hndlr=>co_action_update_branch.
    me->logger->log_start( action = action info = |Repository: { id } | ) ##NO_TEXT.
    me->logger->log_info( action = action info = conv #( me->connection )  ) ##NO_TEXT.
    me->logger->log_info( action = action info = |Branch: { name } |  ) ##NO_TEXT.
    me->logger->log_info( action = action info = |Update Branch info name: { update_branch_info-name } | ) ##NO_TEXT.
    me->logger->log_info( action = action info = |Update Branch Del Comp: { update_branch_info-delivery_comp } Del Rel: { update_branch_info-delivery_rel } | ) ##NO_TEXT.
    data(http_response) = me->client->put(
      exporting
        iv_path    = |/repository/{ escape( val = id format = cl_abap_format=>e_url ) }/branches/{ escape( val = name format = cl_abap_format=>e_xss_url ) }|
        ir_data    = ls_body
            it_header = value #( ( field = if_cts_abap_vcs_registry_hndlr=>co_sap_username value = sy-uname ) )
        changing
            data = branch
    ).
    if http_response-exception is not initial.
      raise exception type cx_cts_abap_vcs_exception
        exporting
          textid             = cx_cts_abap_vcs_exception=>internal_error
          message_variable_1 = |{ http_response-exception }|. "#EC NOTEXT
    endif.
    me->logger->log_end( action = action ).
  endmethod.