#!/bin/bash

OUTPUT_FILENAME="$(pwd)/temp_codescript.txt"

# Eliminar el archivo temp_codescript.txt si existe
rm -f "$OUTPUT_FILENAME"

OUTPUT_TO_FILE=false

# Función para imprimir el contenido de un archivo
print_file_content() {
    local file="$1"
    if $OUTPUT_TO_FILE; then
        echo "$file:" >> "$OUTPUT_FILENAME"
        echo "" >> "$OUTPUT_FILENAME"
        cat "$file" >> "$OUTPUT_FILENAME"
        echo "" >> "$OUTPUT_FILENAME"
        echo "----------------------------------------" >> "$OUTPUT_FILENAME"
        echo "" >> "$OUTPUT_FILENAME"
    else
        echo "$file:"
        echo ""
        cat "$file"
        echo ""
        echo "----------------------------------------"
        echo ""
    fi
}

# Verificar si se proporcionó la opción -o
if [[ "$1" == "-o" ]]; then
    OUTPUT_TO_FILE=true
    shift  # Eliminar la opción -o de los argumentos
fi

# Iterar sobre todos los argumentos proporcionados
for entry in "$@"; do
    # Si la entrada es un directorio, buscar archivos dentro
    if [[ -d $entry ]]; then
        for file in $(find "$entry" -type f); do
            print_file_content "$file"
        done
    # Si la entrada es un archivo, imprimir su contenido
    elif [[ -f $entry ]]; then
        print_file_content "$entry"
    else
        echo "La entrada $entry no existe o no es reconocida."
    fi
done

# Si se usó la opción -o, abrir el archivo de salida
if $OUTPUT_TO_FILE; then
    sync  # Asegurarse de que todos los datos se han escrito en el disco
    sleep 1  # Esperar un segundo (opcional)
    open "$OUTPUT_FILENAME"
fi
