#! /bin/sh

# Generate gcc's config.h, which is not your normal autoconf-generated
# config.h (that's auto-(host|build).h).  $1 is the file to generate.
# HEADERS, DEFINES, and possibly TARGET_CPU_DEFAULT are expected to be
# set in the environment.

if [ -z "$1" ]; then
    echo "Usage: HEADERS='list' DEFINES='list' mkconfig.sh FILE" >&2
    exit 1
fi

output=$1
rm -f $output.T
exec > $output.T

# Define TARGET_CPU_DEFAULT if the system wants one.
# This substitutes for lots of *.h files.
if [ "$TARGET_CPU_DEFAULT" != "" ]; then
    echo "#define TARGET_CPU_DEFAULT ($TARGET_CPU_DEFAULT)"
fi

# The first entry in HEADERS may be auto-host.h or auto-build.h;
# it wants to be included even when not -DIN_GCC.
if [ -n "$HEADERS" ]; then
    set $HEADERS; first=$1
    case $first in auto-* )
	echo "#include \"$first\""
	shift
	HEADERS=$*
	;;
    esac
fi

if [ -n "$HEADERS" ]; then
    echo '#ifdef IN_GCC'
    for file in $HEADERS; do
	echo "# include \"$file\""
    done
    echo '#endif'
fi

for def in $DEFINES; do
    echo "#ifndef $def"
    echo "# define $def"
    echo "#endif"
done

# Include insn-codes.h last, because it includes machmode.h,
# and we want EXTRA_CC_MODES to be taken into account.
echo "#ifndef GENERATOR_FILE"
echo "#include \"insn-codes.h\""
echo "#endif"

exec >&-

# Avoid changing the actual file if possible.
if [ -f $output ] && cmp $output.T $output; then
    echo $output is unchanged >&2
    rm -f $output.T
else
    mv -f $output.T $output
fi

# Touch a stamp file for Make's benefit.
rm -f cs-$output
echo timestamp > cs-$output
