local text = {
   breakpoint = {
      text = "",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
   },
   breakpoint_rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
   },
   stopped = {
      text = "",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
   },
}

vim.fn.sign_define("DapBreakpoint", text.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", text.breakpoint_rejected)
vim.fn.sign_define("DapStopped", text.stopped)
