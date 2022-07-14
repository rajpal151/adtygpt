  method if_cts_abap_vcs_registry_hndlr~get_repository.

    data(action) = if_cts_abap_vcs_registry_hndlr=>co_action_get_repository.
    me->logger->log_start( action = action info = |Repository: { id }| ) ##NO_TEXT.
    me->logger->log_info( action = action info = conv #( me->connection )  ) ##NO_TEXT.
    data(http_response) = me->client->get(
        exporting
            iv_path    = |/repository/{ escape( val = id format = cl_abap_format=>e_url ) }|
            it_header = value #( ( field = if_cts_abap_vcs_registry_hndlr=>co_sap_username value = sy-uname ) )
        changing
            data = repository
    ).
    if http_response-exception is not initial.
      raise exception type cx_cts_abap_vcs_exception
        exporting
          textid             = cx_cts_abap_vcs_exception=>internal_error
          message_variable_1 = |{ http_response-exception }|. "#EC NOTEXT
    endif.
    me->logger->log_end( action = action info = |Successful repository retrieval : { repository-id } | ) ##NO_TEXT.
  endmethod.