# Northeast Ohio Home Value Explorer: data publisher
# Work from the ds_lab project root. Run sections interactively as you learn.
# Downloads public data and writes a local pin. Website publication is separate.

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(glue)
library(pins)

# Source: https://www.zillow.com/research/data/
# Home values: ZHVI, all homes, mid-tier, smoothed, seasonally adjusted.
# Geography: City. Direct CSV download; no API key required.
source_url <- paste0(
  "https://files.zillowstatic.com/research/public_csvs/zhvi/",
  "City_zhvi_uc_sfrcondo_tier_0.33_0.67_sm_sa_month.csv"
)

communities <- c(
  "Cleveland",
  "Lakewood",
  "Rocky River",
  "Westlake",
  "Parma",
  "Cleveland Heights",
  "Shaker Heights",
  "Beachwood",
  "Solon",
  "Strongsville"
)

board_path <- "experiments/housing-pins/board"
pin_name <- "home-values"

housing_raw <- read_csv(source_url)

housing_local <- housing_raw |>
  filter(State == "OH", RegionName %in% communities)

housing_long <- housing_local |>
  pivot_longer(
    cols = matches("^\\d{4}-\\d{2}-\\d{2}$"),
    names_to = "date",
    values_to = "value",
    names_transform = list(date = as.Date)
  ) |>
  select(community = RegionName, date, value)

# Check required communities, unique community/date pairs, valid dates,
# and positive nonmissing values. Stop on failure before writing a pin.
# Make a simple local line chart to inspect the prepared data.
stopifnot(
  nrow(housing_local) == length(communities),
  setequal(housing_local$RegionName, communities),
  nrow(housing_long) > 0,
  !anyDuplicated(housing_long[c("community", "date")]),
  !anyNA(housing_long$date),
  all(
    is.na(housing_long$value) |
      (is.finite(housing_long$value) & housing_long$value > 0)
  )
)

message(glue(
  "Prepared {nrow(housing_long)} observations across ",
  "{n_distinct(housing_long$community)} communities; data through ",
  "{max(housing_long$date)}."
))

housing_long |>
  ggplot(aes(x = date, y = value, color = community)) +
  geom_line() +
  labs(y = "Typical home value ($)", x = NULL)

# 4. WRITE AND READ A LOCAL PIN
# Create pins::board_folder(board_path, versioned = TRUE).
# Write the prepared data with pin_write(), name = pin_name, type = "rds".
# Include the source URL and retrieval time in metadata.
# Read it back with pin_read() and compare it with the prepared data.
# Call pins::write_board_manifest() AFTER writing the pin.
board <- pins::board_folder(
  path = board_path,
  versioned = TRUE
)

pins::pin_write(
  board,
  housing_long,
  name = pin_name,
  type = "rds",
  description = "Monthly Zillow home values for ten Northeast Ohio communities",
  metadata = list(source_url = source_url)
)

# Verify the round trip.
housing_pinned <- pins::pin_read(board, pin_name)
stopifnot(identical(housing_long, housing_pinned))

# Create `board/_pins.yaml`, an index listing the pins and their versions. A
# local board can inspect folders directly; a web reader needs that index to
# discover what’s available.
pins::write_board_manifest(board)

# Pins protects its RDS files as read-only. Quarto's Windows resource copying
# needs writable copies so subsequent renders can replace the output files.
Sys.chmod(
  list.files(board_path, pattern = "\\.rds$", recursive = TRUE, full.names = TRUE),
  mode = "0644"
)

# 5. PUBLISH -- a separate, explicit step
# Follow index.qmd and the root README; do not deploy the app to update data.
