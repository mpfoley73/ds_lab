# Run manually from the ds_lab repository root.
# Deploys app code; data publication is a separate workflow.

rsconnect::deployApp(
  appDir = "experiments/housing-pins/app",
  appName = "neohio-home-values",
  account = "mpfoley73",
  server = "shinyapps.io"
)
