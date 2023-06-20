
.model small
.stack 64 ;declaracion del tamaño de la pila
.data
    numero1 db 0 ;Dato para almacenar el valor del primer número a ocupar
    numero2 db 0 ;Dato para almacenar el valor del segundo número a ocupar
    dos db 2 ;Variable utilizada para el proceso de conversion del número entrante


    msj1 db 10,13, "Calculadora binaria", "$"
    msj2 db 10,13, "Digite 1 para realizar sumas", "$"
    msj3 db 10,13, "Digite 2 para realizar restas", "$"
    msj4 db 10,13, "Digite 3 para realizar multiplicaciones", "$"
    msj5 db 10,13, "Digite 4 para realizar divisiones", "$"
    msj6 db 10,13, "Digite 5 para ayuda", "$"
    msj7 db 10,13, "Digite 6 para salir",10,13, "$"
    msj8 db 10,13, "Digite el primer numero = ", "$"
    msj9 db 10,13, "Digite el segundo numero = ", "$"

    help db 10,13, "Debe de seleccionar un numero del menu y ", "$"
    help2 db 10,13, "luego proceder a insertar los numeros para", "$"
    help3 db 10,13, "la operacion seleccionada", "$"

.code ;inicio del código
    mov ax, @data 
    mov ds,ax ;Direccionamiento de los datos linea 26 y 27
    jmp inicio ;Brinca a la etiqueta inicio para iniciar el menú

imprimir proc near;funcion para imprimir datos del dx en consola
    mov ah, 09 ;mueve a la parte baja de ax para invocación en consola
    int 21h ;interrupcion para imprimir en consola lo que se tiene cargado en dx
    ret ;retorna al lugar donde fue llamada la funcion dentro del codigo
imprimir endp ;fin de la funcion imprimir

recibirDato proc near;funcion para recibe dato de consola y lo guarda en al
    mov ah, 01 ; asigna el 1 a ah para la interrupcion 21h
    int 21h ; captura un caracter de consola
    ret 
recibirDato endp ;fin de la funcion para recibir un dato en consola

inicio: ;Etiqueta de inicio para mostrar el menu
    lea dx, msj1 ;carga en el dx el mensaje 1 "Calculadora binaria"
    call imprimir ;llamado de la etique para imprimir datos del dx en consola
    lea dx, msj2 ;carga en el dx el mensaje 1 "Digite 1 para realizar sumas"
    call imprimir ;llamado de la etique para imprimir datos del dx en consola
    lea dx, msj3 ;Como en los casos anteriores con cada mensaje
    call imprimir ;como los casos anteriores para imprimir en consola
    lea dx, msj4
    call imprimir
    lea dx, msj5
    call imprimir
    lea dx, msj6
    call imprimir
    lea dx, msj7
    call imprimir
    call recibirDato
    cmp al, "1" ;comparacion del dato ingresa por consola con lo que se encuentra en al
    je sum ;En caso de coincidencia, brinca a la etiqueta que realiza la operación suma
    cmp al, "2" ;comparacion del dato ingresa por consola con lo que se encuentra en al
    je res ;En caso de coincidencia, brinca a la etiqueta que realiza la operación resta
    cmp al, "3" ;comparacion del dato ingresa por consola con lo que se encuentra en al
    je multi ;En caso de coincidencia, brinca a la etiqueta que realiza la operación multiplicación
    cmp al, "4" ;comparacion del dato ingresa por consola con lo que se encuentra en al
    je divi ;En caso de coincidencia, brinca a la etiqueta que realiza la operación division
    cmp al, "5"
    je ayuda ;En caso de coincidencia, brinca a la etiqueta que realiza la opción de ayuda para el usuario
    cmp al, "6"
    je salir ;En caso de coincidencia, brinca a la etiqueta que realiza la conclusion del programa

parsearDato1 proc near;Parsea el numero recibido, guarda en la variable la cantidad
    xor cl, cl ;Encargado de establecer los valores de los registros del cl en 0

cicloParseo: ;Etiqueta para realizar las conversiones del nuemro 1 ingresados a binario
    call recibirDato ;Relaiza el llamdo de la funcion para recibir un dato por consola
    cmp al, 0dh ;compara si lo que entro en al es un enter
    je continuar ;Brinco a la etiqueta continuar 
    inc cl ;incremento del registro bajo contador
    sub al, 30h ;convierte el caracter en numero
    cmp cl, 1 ;comparación del registro contador con el numero 1
    je primerDigito ;brinco a la etiqueta del primer digito, para proceder a la conversion
    mov bl, al ;mueve lo que se almaceno en al al bloque de registro base bl
    mov al, numero1 ;mueve lo contenido en la variable "numero1" a el registro al
    mul dos ;multiplica por el valor de la variable 2, lo que se encuentra en al
    add al, bl ;suma o concatena lo almacenado en bl con lo que se encuentra en al
    mov numero1, al ;mueve lo que se encuentra en al, a la variable ""numero1
    jmp cicloParseo ;brinco a la etiqueta cicloparseo para continuar la conversion

primerDigito: ;Etiqueta para control de la conversion del primer digito
    mov numero1, al 
    jmp cicloParseo ;brinco a la etiqueta cicloParseo para continuar la conversion

continuar: ;Etiqueta de control para continuar con la ejecución
    ret 

parsearDato1 endp ;fin de la conversion del ato 2

parsearDato2 proc near;Parsea el numero 2 recibido, guarda en la variable la cantidad
    xor cl, cl ;Encargado de establecer los valores de los registros del cl en 0

cicloParseo1: ;Etiqueta para realizar las conversiones del numero 2 ingresados a binario
    call recibirDato
    cmp al, 0dh
    je continuar1
    inc cl
    sub al, 30h
    cmp cl, 1
    je primerDigito1
    mov bl, al
    mov al, numero2
    mul dos
    add al, bl
    mov numero2, al
    jmp cicloParseo1

primerDigito1:
    mov numero2, al
    jmp cicloParseo1

continuar1:
    ret 
parsearDato2 endp ;fin de la conversion del numero 2

numeroACaracter proc near ;Funcion para mostrar los números de los registros como caracter
    mov cl, "$" ;mueve o asigna el control de freno a el registro contador bajo
    xor ch, ch ;Encargado de establecer los valores de los registros del ch en 0
    push cx ;ingresa lo del registro cx a la pila

cicloFinal: ;Etiqueta para la previa culminación del programa
    mov ah, 0 ;asigna cero al registro ah
    div dos ;divide por 2 lo que esta en el registro ah
    mov cl, ah ;pasa lo que esta en ah a el registro cl

    xor ch, ch ;Encargado de establecer los valores de los registros del ch en 0
    push cx ;ingresa lo que esta en cx a la pila
   
    cmp al, 0 ; compara si lo que esta en al es "0"
    jne cicloFinal ;brinca a la etiqueta cicloFinal para continuar si es diferente de 0
    
cicloFinal2:
    xor cx, cx; coloca el valor de cx en 0
    pop cx ; guarda en cx el top de la pila
    cmp cl, "$" ;compara el cl con "$" para determinar si el numero se acabo
    je regresar ;va a la instruccion ret para volver a donde se llamo la rutina
    mov dl, cl ;coloca el valor del numero en dl
    add dl, 30h ; convierte el numero en caracter
    mov ah, 02 ; asigna a ah un 2 para la interrupcion 21h
    int 21h ; imprime el numero en consola
    jmp cicloFinal2 ;pasa al siguiente numero

regresar:
    ret
numeroACaracter endp

sum: ;Realizacion de la operacion suma
    lea dx, msj8 ;lee el mensaje de ingresar el primer numero
    call imprimir ; llamado de la función para imprimir por en consola
    call parsearDato1 ;conversion del primer numero que se ingresa
    lea dx, msj9 ;lee el mensaje de ingresar el segundo numero
    call imprimir ; llamado de la función para imprimir por en consola
    call parsearDato2 ;conversion del segundo numero que se ingresa
    mov al, numero1 ;mueve el valor hecha la conversion al registro al del numero 1
    add al, numero2 ;suma lo que está en al con lo de la variable "numero2"
    call numeroACaracter ;llamado de la funcio para pasar de numero a caracter
    jmp inicio ;brinco a la etiqueta inicio para seguir mostrano el menu

res: ;Realizacion de la operacion resta
    lea dx, msj8
    call imprimir
    call parsearDato1
    lea dx, msj9
    call imprimir
    call parsearDato2
    mov al, numero1 ;mueve el valor hecha la conversion al registro al del numero 1
    sub al, numero2 ;resta lo que está en al con lo de la variable "numero2"
    call numeroACaracter ;llamado de la funcio para pasar de numero a caracter
    jmp inicio ;brinco a la etiqueta inicio para seguir mostrano el menu

multi: ;Realizacion de la operacion multiplicacion
    lea dx, msj8
    call imprimir
    call parsearDato1
    lea dx, msj9
    call imprimir
    call parsearDato2
    mov al, numero1 ;mueve el valor hecha la conversion al registro al del numero 1
    mul numero2 ;multiplica lo que está en al con lo de la variable "numero2"
    call numeroACaracter ;llamado de la funcio para pasar de numero a caracter
    jmp inicio ;brinco a la etiqueta inicio para seguir mostrano el menu

divi: ;Realizacion de la operacion division
    lea dx, msj8
    call imprimir
    call parsearDato1
    lea dx, msj9
    call imprimir
    call parsearDato2  
    xor ah, ah ;Encargado de establecer los valores de los registros del ah en 0, esto para evitar errores de calculo posibles
    mov al, numero1 ;mueve el valor hecha la conversion al registro al del numero 1
    div numero2 ;divide lo que está en al con lo de la variable "numero2"
    call numeroACaracter ;llamado de la funcio para pasar de numero a caracter
    jmp inicio ;brinco a la etiqueta inicio para seguir mostrano el menu

ayuda: ;Muestra la ayuda para el usuario
    lea dx, help ;lee lo de la variable help
    call imprimir ;llamado de la funcion para escritura por consola
    lea dx, help2 ;lee lo de la variable help2
    call imprimir
    lea dx, help3 ;lee lo de la variable help2
    call imprimir
    jmp inicio ;brinco al inicio del menu

salir: ;Etiquete para finalizar programa
    mov ah,4ch ;4ch Cierra el programa
    int 21h

end ;fin del codigo