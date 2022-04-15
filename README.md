# Actualización automática con APT

Este es un pequeño script para automatizar las actualizaciones a través del gestor de paquetes APT con el objetivo de facilitar la tarea a usuarios poco experimentados o que no quieran preocuparse por tener que pasar manualmente las actualizaciones del sistema.

\* Debería funcionar sin problemas con cualquier derivado de Debian / Ubuntu o simplemente cualquier distribución GNU/Linux con _APT_ y _Anacron_ instalados.

![img-autoupdate](assets/img-autoupdate.png)

<br />

## INSTALACIÓN

Para instalarlo descargue el [fichero zip](https://github.com/FenrirWolfwood/apt-autoupdate/archive/refs/tags/test.zip), descomprimalo y, desde una terminal o simplemente haciendo doble clic sobre el, ejecute el fichero **install.sh**.

A continuación se le abrirá una nueva ventana de terminal pidiéndole confirmación. Para continuar seleccione <span style="color:lightgreen">Si</span> y pulse Enter, o use los cursores ⇧ y ⇩ para cambiar la selección a <span style="color:red">No</span> si desea salir. Seguidamente le pedirá que escriba la contraseña de **su usuario** para autorizar el proceso de instalación.

![img-confirmation](assets/img-confirmation.png)

Tras escribir su contraseña, se creará una carpeta en su sistema en _/opt/apt-autoupdate_, se copiarán todos los ficheros en ella y se programará en _Anacron_ que se pasen las actualizaciones del sistema diariamente. Si todo ha ido bien le mostrará un mensaje informándole de ello y se cerrará la ventana pasado un tiempo si no la ha cerrado usted antes.

![img-success](assets/img-success.png)

En el caso de que hubiera algún problema con la instalación, se borrarán los cambios que se hayan hecho y le saldrá un mensaje informándole de cual ha sido el problema. En este caso la ventana permanecerá abierta hasta que usted pueda ver el mensaje y la cierre.

![img-fail](assets/img-fail.png)

<br />

### INSTALACIÓN MANUAL

En el caso de que el script de instalación no le funcione o simplemente prefiera hacer las cosas algo distintas, la instalación manual es bien sencilla.

1. Descargue el [fichero zip](https://github.com/FenrirWolfwood/apt-autoupdate/archive/refs/tags/test.zip) y descomprimalo.

2. Cree usted mismo la carpeta **/opt/apt-autoupdate** u otra carpeta donde usted prefiera.

3. Copie todos los ficheros en dicha carpeta y asegúrese de que el fichero **apt-autoupdate.sh** sea ejecutable.

4. Edite el fichero **/etc/anacrontab** y añada al final la siguiente linea:
   
   ```
   1    3    apt-autoupdate    export DISPLAY=$DISPLAY && export XAUTHORITY=$HOME/.Xauthority && /opt/apt-autoupdate/apt-autoupdate.sh
   ```
   
   **IMPORTANTE:** Si ha decidido utilizar una carpeta distinta de _/opt/apt-autoupdate_ tendrá que cambiar la ruta de la carpeta al final de este comando.

5. OPCIONAL: Si lo desea, puede crear un enlace al fichero _apt-autoupdate.sh_ en la carpeta _/usr/bin_ para poder ejecutar el script de forma manual cuando lo desee simplemente escribiendo el comando `apt-autoupdate` en su teminal.
   
   ```
   sudo ln -s /opt/apt-autoupdate/apt-autoupdate.sh /usr/bin/apt-autoupdate   
   ```

Con estos pasos la instalación estaría terminada y ya puede borrar los ficheros descargados ya que en caso de necesitar alguno de ellos los encontrará en la carpeta donde los ha copiado usted mismo, incluido este manual.

<br />

## DESINSTALACIÓN

Si decide utilizar los servicios de actualización automática que le ofrezca su distribución GNU/Linux o tal vez encargarse usted mismo de ello, puede desinstalar este mini-programa simplemente ejecutando el script **uninstall.sh** y siguiendo los pasos al igual que con el de instalación.

Este script eliminará la carpeta en _/opt/apt-autoupdate_ junto con su contenido y borrará la tarea programada creada en _Anacron_. Igual que en la instalación, si todo ha ido bien le mostrará un mensaje informándole de ello y se cerrará la ventana pasado un tiempo si no la ha cerrado usted antes.

En el caso de que hubiera algún problema con la desinstalación, le saldrá un mensaje informándole de cual ha sido el problema y la ventana permanecerá abierta hasta que usted pueda ver el mensaje y la cierre.

<br />

### DESINSTALACIÓN MANUAL

En el caso de que el script de desinstalación no le funcione o haya realizado una instalación manual personalizada, la desinstalación es simplemente invertir los pasos de la instalación:

1. Borre la carpeta creada en **/opt/apt-autoupdate** o la correspondiente en caso de que la haya creado manualmente en otro sitio.

2. Edite el fichero **/etc/anacrontab** y borre la linea correspondiente a **apt-autoupdate**.

3. En el caso de que llevara a cabo la instalación mediante el script o bien decidiera hacerlo al realizar la instalación manual, no se olvide también de borrar el enlace creado en el directorio **/usr/bin** llamado **apt-autoupdate**.

Con estos pasos habrá borrado correctamente los ficheros y configuraciones relacionados con este mini-programa.
