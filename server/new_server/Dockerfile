FROM google/dart:latest
WORKDIR /app

COPY . /app

# Install dependencies, pre-build
RUN pub get

# Optionally build generaed sources.
# RUN pub run build_runner build

# Set environment, start server
ENV ANGEL_ENV=production
EXPOSE 3000
CMD dart bin/prod.dart --address=0.0.0.0