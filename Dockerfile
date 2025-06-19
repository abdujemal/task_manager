# Step 1: Use a base image with Flutter and Android SDK installed
FROM cirrusci/flutter:stable

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the Flutter project files into the container
COPY pubspec.yaml .

# Step 4: Install Flutter dependencies
RUN flutter pub get

COPY . .

# Step 5: Ensure ADB is installed in the container (Optional, should be pre-installed in the base image)
RUN apt-get update && apt-get install -y adb

# Step 6: Start the app on the connected device
CMD ["flutter", "run", "-d", "android"]
