cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

executablePath="$1"
selfUpdateDirectory="$SCRIPT_DIR/self-update"

packageFile="package.tar.gz"

function unpackPackageAndMoveFiles {
    cd "$selfUpdateDirectory"
    tar -xzf $packageFile && rm $packageFile
    mv -f ./**/* $SCRIPT_DIR
    cd ..
    rm -rf $selfUpdateDirectory
}

function startApp {
    (exec "$executablePath")
}

sleep 2
unpackPackageAndMoveFiles
sleep 2
startApp
