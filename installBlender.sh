#!/bin/bash
# Autor: Ivan del Valle ivan.delvalle http://foros.educa.madrid.org/viewtopic.php?p=16547&sid=4259722199c63c2e31c04f0a2a994654#p16547
# Muchas gracias

DESTINOPATH="/opt"
DESTINOLANZADOR="/etc/skel/Escritorio"
DESTINOLANZADORINICIO="/usr/share/applications"
ORIGENPATH32="$( pwd )/blender-2.80-linux-glibc224-i686"
ORIGENPATH64="$( pwd )/blender-2.83.12-linux64"
LANZADORPATH="Blender.desktop"
IDENTIFICADOR=$( id -u )
ICON="blender.png"
COMPROBAR="$( dpkg -l | grep blender | head -n 1 | awk '{ print $1 }' )"
C=1


if [ $IDENTIFICADOR == 0 ]; then
    

    while [ $C -eq 1 ]; do

        COMPROBAR="$( dpkg -l | grep blender | head -n 1 | awk '{ print $1 }' )"
        
        
        if ! [ "$COMPROBAR" == "ii" ]; then
            (( C=0 ))

            if [ $( uname -m ) == "x86_64" ]; then


                if ! [ -f $( echo $ORIGENPATH64 ) ]; then  
                
                        wget https://download.blender.org/release/Blender2.83/blender-2.83.12-linux64.tar.xz
                        tar -xJvf blender-2.83.12-linux64.tar.xz
                        mv blender-2.83.12-linux64 blender-2
                        
                fi   
                ORIGENPATH64="$( pwd )/blender-2"

                if ! [ -d  $( echo $DESTINOPATH/blender-2.83 ) ]; then
                    mv $ORIGENPATH64 $DESTINOPATH
                
                fi

                

                if [ -f $( echo $LANZADORPATH )  ]; then
                    chmod +x $LANZADORPATH
                    cp $LANZADORPATH $DESTINOLANZADOR
                    cp $LANZADORPATH $DESTINOLANZADORINICIO
                    sudo update-desktop-database

                fi

                if [ -f $ICON ]; then
                    cp $ICON $DESTINOPATH/blender-2

                fi
            
            else 
		if [ $( uname -m ) == "i686" ]; then

			if ! [ -f $( echo $ORIGENPATH32 ) ]; then  
			
				wget https://download.blender.org/release/Blender2.80/blender-2.80-linux-glibc224-i686.tar.bz2
				tar -xjvf blender-2.80-linux-glibc224-i686.tar.bz2
				mv blender-2.80-linux-glibc224-i686 blender-2
				
			fi   
			ORIGENPATH32="$( pwd )/blender-2"

			if ! [ -d  $( echo $DESTINOPATH/blender-2.80 ) ]; then
			    mv $ORIGENPATH32 $DESTINOPATH
			
			fi

			

			if [ -f $( echo $LANZADORPATH )  ]; then
			    chmod +x $LANZADORPATH
			    cp $LANZADORPATH $DESTINOLANZADOR
			    cp $LANZADORPATH $DESTINOLANZADORINICIO
			    sudo update-desktop-database

			fi

			if [ -f $ICON ]; then
			    cp $ICON $DESTINOPATH/blender-2

			fi
		fi

            fi

        else
            apt remove --purge blender blender-data -y
            echo "blender desinstalado"
            
            
                
        fi

    done

Blender
else
echo "Necesita permisos de administrador"
fi
