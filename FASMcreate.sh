fasm $1".asm"
ld $1".o" -o $1
rm $1".o"

echo "Файл" $1 "готов"