FROM python:3.12-slim

WORKDIR /app

# Install Poetry
RUN pip install poetry

# Copy only requirements to cache them in docker layer
COPY pyproject.toml poetry.lock* README.md /app/

# Configure poetry to not use a virtual environment
RUN poetry config virtualenvs.create false

# Install dependencies WITHOUT the root package
RUN poetry install --no-interaction --no-ansi --no-root

# Copy project code
COPY . /app/

# Now install the root package after the code is available
RUN poetry install --no-interaction --no-ansi

# Command to run the server
CMD ["python", "-m", "src.server"]