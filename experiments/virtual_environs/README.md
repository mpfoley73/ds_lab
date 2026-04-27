# Virtual Environments Tutorial

This repository contains a comprehensive tutorial on virtual environments for data science, focusing on R with Python integration.

## Setup Instructions

### Prerequisites
- R (version 4.0 or later)
- Python (version 3.8 or later)
- Quarto (for rendering the tutorial)

### Initial Setup

1. **Clone or download this repository**

2. **Set up R environment with renv:**
   ```r
   # Install renv if not already installed
   install.packages("renv")

   # Initialize renv (this will create renv.lock)
   renv::init()

   # Install required packages
   install.packages(c("ggplot2", "shiny"))

   # Snapshot the environment
   renv::snapshot()
   ```

3. **Set up Python environment:**
   ```bash
   # Create virtual environment
   python -m venv .venv

   # Activate environment (Windows)
   .venv\Scripts\activate

   # Install requirements
   pip install -r python/requirements.txt
   ```

4. **Render the tutorial:**
   ```bash
   quarto render tutorial.qmd
   ```

## Project Structure

- `tutorial.qmd` - Main tutorial document
- `R/analysis.R` - R data analysis script
- `R/shiny_app.R` - Shiny app for deployment demo
- `python/app.py` - Python data analysis script
- `python/requirements.txt` - Python dependencies
- `.github/workflows/ci.yml` - GitHub Actions CI configuration

## Running the Examples

### R Analysis
```r
source("R/analysis.R")
```

### Python Analysis
```bash
# Activate virtual environment first
source .venv/bin/activate  # or .venv\Scripts\activate on Windows
python python/app.py
```

### Shiny App
```r
source("R/shiny_app.R")
```

## Deployment

### Posit Cloud
1. Push this repository to GitHub
2. Create a new project in Posit Cloud from Git
3. The environment will automatically restore from `renv.lock`

### Local Deployment
- Run the Shiny app locally for testing
- Use `renv::snapshot()` before deployment to ensure lockfile is current

## Contributing

This tutorial is designed for presentation at R Meetups. Feel free to modify examples or add sections as needed.

## Resources

- [renv documentation](https://rstudio.github.io/renv/)
- [Quarto guide](https://quarto.org/)
- [Posit Cloud](https://posit.cloud/)