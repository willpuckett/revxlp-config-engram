#!/bin/bash

PROJECT=revxlp
LAYOUTS=('qwerty' 'qwerty_flip' 'engram' 'engrammer')
COLS=8
KEYMAP="config/${PROJECT}.keymap"
# See [this link](https://github.com/caksoylar/keymap-drawer/blob/main/KEYMAP_SPEC.md#colsthumbs-notation-specification)
# for info on cols-thumbs notation
COLS_THUMBS='333333+3> 3<+333333'
# Or, pick a keyboard from https://config.qmk.fm
QMK_KEYBOARD=""

# Store the flag and variable in an array to expand 
# each element as a seperate shell word in the command later....
KMD_LAYOUT=(-n "$COLS_THUMBS") &&
    [[ -n $QMK_KEYBOARD ]] &&
    KMD_LAYOUT=(--qmk-keyboard "$QMK_KEYBOARD")

for l in "${!LAYOUTS[@]}"; do
    echo "Rendering Layout ${LAYOUTS[$l]}"
    BASE=".images/${PROJECT}_${LAYOUTS[$l]}"
    YML="$BASE.yml"
    echo $KMD_LAYOUT
    # note you have to have the quotes for KMD_LAYOUT expansion
    KEYMAP_zmk_preamble="#define LAYOUT $l" keymap parse -c $COLS -z "$KEYMAP" >"$YML" &&
        keymap draw "${KMD_LAYOUT[@]}" "$YML" >"$BASE.svg"
    [[ $? -ne 0 ]] && exit 1
    rm "$YML"
done


