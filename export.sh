#/c/Users/Gebruiker/Documents/processing-3.5.4-windows64/processing-3.5.4/processing-java.exe --force --sketch=/c/Users/Gebruiker/Documents/software/NxGUI --build
/c/Users/Gebruiker/Documents/processing-3.5.4-windows64/processing-3.5.4/processing-java.exe --sketch=/c/Users/Gebruiker/Documents/software/NxGUI --export
scp railItems.txt pi@192.168.1.84:/home/pi/Documents/application.linux-armv6hf
scp -r application.linux-armv6hf/* pi@192.168.1.84:/home/pi/Documents/application.linux-armv6hf/
ssh pi@192.168.1.84 <<'ENDSSH'
/home/pi/boot.sh
ENDSSH