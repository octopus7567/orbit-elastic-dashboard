COMMIT_SUFFIX=$(git rev-parse --short HEAD)
OUTPUT_DIR=dist-Release

rm -rf $OUTPUT_DIR
echo "Getting dependencies"
flutter pub get
echo "Building flutter"
flutter build windows

echo "Putting everything in './$OUTPUT_DIR'"
mkdir $OUTPUT_DIR

cp -r build/windows/x64/runner/Release/* $OUTPUT_DIR