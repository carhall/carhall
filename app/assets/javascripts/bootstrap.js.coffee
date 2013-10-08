jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], i[rel~=tooltip], .has-tooltip").tooltip()

  # For fluid containers
  $('.datatable').dataTable
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    oLanguage:
      sProcessing:   "处理中...",  
      sLengthMenu:   "显示 _MENU_ 项结果",  
      sZeroRecords:  "没有匹配结果",  
      sInfo:         "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",  
      sInfoEmpty:    "显示第 0 至 0 项结果，共 0 项",  
      sInfoFiltered: "(由 _MAX_ 项结果过滤)",  
      sInfoPostFix:  "",  
      sSearch:       "搜索:",  
      sUrl:          "",  
      oPaginate:
          sFirst:    "首页",  
          sPrevious: "上页",  
          sNext:     "下页",  
          sLast:     "末页"  

  $('.select2').select2
