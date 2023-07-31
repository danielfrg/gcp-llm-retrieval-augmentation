FROM python:3.9-slim

# Copy source code to the container image
ENV SRC /app
WORKDIR $SRC
COPY . ./

# Install production dependencies
RUN pip install -r requirements.lock

# Download model
RUN python setup.py

# Container startup
CMD uvicorn --host 0.0.0.0 --port $PORT main:app
