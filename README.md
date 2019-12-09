# Spaceinvaders
__Verilog__

__*Liste des modules*__
Pour réaliser ce projet, vous aurez besoin des modules suivants :
• Vga : gère le balayage de l’écran et indique aux modules gérant de la couleur les coordonnées du pixel
balayés  
• __SpaceShip__ : gère le vaisseau du joueur (son positionnement et son dessin)  
• __Rgb__ : représente une combinatoire qui associe à un nombre sur 3 bits une couleur.  
• __FinalColor__ : permet de forcer à noir la couleur renvoyée si on le balayage est en dehors de l’écran  
• __AliensMotion__ : permet de gérer la force alien (gestion des morts et des mouvements possibles)  
• __AliensColor__ : permet de gérer la couleur des aliens  
• __ZigZagAlien__ : automate permettant de gérer le déplacement en zig zag des aliens  
• __Laser__ : pour gérer le rayon laser destructeur.  
Naturellement, vous aurez également besoin de modules diviseurs de fréquences afin de gérer la vitesse de
déplacement des objets à l’écran. Le diviseur de fréquence sera à ajouter au projet et plusieurs instances pourront
être réalisées dans le module d’intégration.  

![VideoCapture_20191209-210919](https://user-images.githubusercontent.com/52625036/70469358-2c2b3800-1ac9-11ea-9383-a616c7c00617.jpg)
![VideoCapture_20191209-210934](https://user-images.githubusercontent.com/52625036/70469359-2cc3ce80-1ac9-11ea-9b20-3cbc8fd4f011.jpg)
![VideoCapture_20191209-210847](https://user-images.githubusercontent.com/52625036/70469360-2cc3ce80-1ac9-11ea-95c5-38e5f650b4f3.jpg)
![VideoCapture_20191209-210912](https://user-images.githubusercontent.com/52625036/70469361-2cc3ce80-1ac9-11ea-82f2-4b593700bb9f.jpg)
