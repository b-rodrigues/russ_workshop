library(rix)

rix(r_ver = "4.3.1",
    r_pkgs = c("dplyr", "ggplot2"),
    system_pkgs = NULL,
    git_pkgs = NULL,
    tex_pkgs = NULL,
    ide = "rstudio",
    shell_hook = "export QT_XCB_GL_INTEGRATION=none",
    project_path = ".")
