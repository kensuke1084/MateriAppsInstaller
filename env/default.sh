#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
. $SCRIPT_DIR/../util.sh
set_prefix
set_build_dir

cat << EOF > $BUILD_DIR/env.sh
PATH=$PREFIX_OPT/bin:\$PATH
LD_LIBRARY_PATH=$PREFIX_OPT/lib:\$LD_LIBRARY_PATH
EOF
$SUDO mkdir -p $PREFIX_OPT
$SUDO cp -f $BUILD_DIR/env.sh $PREFIX_OPT
