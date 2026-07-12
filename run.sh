#!/bin/bash
# Helper script to run this Processing sketch with the necessary JOGL configuration on Arch Linux

# Path to the directory where we extracted the native JOGL/GlueGen libraries
NATIVES_PATH="/home/nuwa/processing_tmp/natives"

# Check if natives exist, if not, extract them
if [ ! -d "$NATIVES_PATH" ] || [ -z "$(ls -A "$NATIVES_PATH")" ]; then
    echo "Creating native library cache..."
    mkdir -p "$NATIVES_PATH"
    cd "$NATIVES_PATH"
    jar xf /usr/lib/processing/lib/app/gluegen-rt-2.6.0-natives-linux-amd64-*.jar
    jar xf /usr/lib/processing/lib/app/jogl-all-2.6.0-natives-linux-amd64-*.jar
    mv natives/linux-amd64/* .
    rm -rf natives META-INF jogamp
    cd - > /dev/null
fi

# Run the sketch
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS="-Djogamp.gluegen.UseTempJarCache=false -Djava.library.path=$NATIVES_PATH"

processing cli --sketch="$(pwd)" --run
