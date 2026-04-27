# python/app.py
import pandas as pd
import numpy as np

# Generate sample data
np.random.seed(123)
df = pd.DataFrame({
    'x': np.random.normal(0, 1, 100),
    'y': np.random.normal(0, 1, 100),
    'group': np.random.choice(['A', 'B'], 100)
})

# Print summary
print("Data Summary:")
print(df.describe())
print("\nGroup counts:")
print(df['group'].value_counts())

# Save to CSV
df.to_csv("python_output.csv", index=False)
print("\nData saved to python_output.csv")
