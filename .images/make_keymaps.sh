keymap="config/boards/shields/revxlp/revxlp.keymap"
LAYOUTS=('NC' 'QWERTY' 'QWERTY_FLIP' 'ENGRAM' 'ENGRAMMER')

for l in {1..4}; do
    echo "Rendering Layout ${LAYOUTS[l]}"
    yml=".images/revxlp${l}.yml"
    KEYMAP_zmk_preamble="#define LAYOUT ${l}" keymap parse -c 12 -z ${keymap} > "${yml}"
    # keymap draw -n '33333+2 2+33333' .images/swoon.yml > .images/swoon_keymap.svg
    keymap draw -n '333333+3 3+333333' "${yml}" > ".images/revxlp_${LAYOUTS[l]}.svg"
    rm "${yml}"
done