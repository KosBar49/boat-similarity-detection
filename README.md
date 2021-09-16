## Description PL

1. Wczytuje obraz, domyślny format: jpg
2. Przygotuj obraz: zmienia obraz z reprezentacji trójkolorowej RGB, na 
reprezentacje w odcieniach szarości. 
3. Rozpoznaj obiekt: zostaje wykonana operacja obliczenia progu dla analizowanego
obrazu. Są dwie możwości 
1) rozpoznaj obiekt -> próg zostaje obliczony za pomocą alg. Otsu, w przypadku naszego obrazu: 
test2.jpg, algorytm przyją za niski próg
2) rozpoznaj obiekt, uprzednio klikając na opcję okeśl własny próg, i wybierając z suwaka wartość
progu jaka nas interesuje. W naszym przypadku test2.jpg, aby ładnie "wyciąć" statek należy ustawić coś 
koło 0.53. 
4) W przypadku wystąpienia artefaktów (białych kropek rozproszonych po obrazie), klikamy usuń artefakty. 
5) Zapisz obraz, zapisuje plik w formacie jpg
6) Wyświetl - pojawiają się na ekranie 3 histogramy: poziomowej, pionowy, sumy. 
7) Obrót - wybieramy kąt o jaki chcemy przesunąć obraz i klikamy odpowiednio: w lewo => ok, w prawo => ok. 
