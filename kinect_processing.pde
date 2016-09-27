import org.openkinect.freenect.*;     // Importar la librería que instalamos.
import org.openkinect.processing.*;

Kinect kinect;     // Variable que nos va a permitir usar todas las funciones del Kinect.

PImage prof;     // Variable que nos permite ver la imágen que genera el sensor.

int profMin= 100;     // Variables que delimitan el rango de profundidad
int profMax= 700;

void setup() {

  size(640, 480);
  kinect = new Kinect(this);     // Decirle a Processing que empiece a utilizarr el kinect
  kinect.initDepth();            // Específicar que funcion del kinect queremos utilizar

  prof = new PImage(kinect.width, kinect.height);     // Variable que muestra la imágen proveniente del kinect
}

void draw() {

  prof.loadPixels();     // Carga los pixeles de la imágen de kinect

  int[] profundidad = kinect.getRawDepth();     // arreglo que organiza los datos de
                                                // profundidad provenientes del sensor 

  float sumX=0;     // Variables que permiten sumar los valores de los pixeles
  float sumY=0;
  float total=0;

  for (int x=0; x<kinect.width; x++) {     
    for (int y=0; y<kinect.height; y++) {
      int offset = x+y*kinect.width;        // variable que permite coincidir los pixeles con
                                            // los valores del arreglo
      
  int p = profundidad[offset];    // variable que relaciona el offset con el arreglo

      if (p>= profMin && p<= profMax) {       // condicional que permite dibujar los pixeles                   
                                              // dependiendo de la profundidad
        prof.pixels[offset] = color(255);
        
        sumX+=x;    // suma de los pixeles en eje X y Y el total que se dibuja.
        sumY+=y;
        total++;
        
      } else {
        prof.pixels[offset] = color(0);
      }
    }
  }

  prof.updatePixels();    // Actualiza los pixeles de la imágen del kinect
  image(prof, 0, 0);      // Dibuja la imágen en el canvas
  
  float promX= sumX/total;  // Variables que permiten encontrar el punto medio de los pixeles
  float promY= sumY/total;
  
  noFill();        // Elipse para indicar el punto medio utilizando las variables de promedio
  stroke(255,0,0);
  ellipse(promX, promY, 30, 30);
  
}