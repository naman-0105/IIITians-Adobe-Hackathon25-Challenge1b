FROM --platform=linux/amd64 python:3.10-slim

# Set working directory
WORKDIR /app

# Copy all files to container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Run the main.py script for each Collection folder
CMD for dir in Collection*; do \
      if [ -d "$dir" ] && [ -f "$dir/challenge1b_input.json" ]; then \
        echo "Processing $dir/challenge1b_input.json"; \
        cd "$dir"; \
        python /app/main.py challenge1b_input.json challenge1b_output.json; \
        cd /app; \
      fi; \
    done
