# IdS-projekt

pliki wykonywane są w sekwencji

## Analiza danych

- 00 - analiza zebranych danych pomiarowych
> REQUIRES RWP.dat

## Podział danych

- 01 - podział danych na dane
> REQUIRES RWP.dat  
> PRODUCES dane_identyfikacyjne.mat, dane_weryfikacyjne.mat  
> Parametry:
>  - część danych wykorzystanych do identyfikacji
>  - czy dane identyfikacyjne są z początku czy końca danych zmierzonych

## Analiza nieparametryczna

- 02 - analiza częstotliwościowa pomagająca w określeniu rzędu obiektu. Podejście BLACK-BOX
> REQUIRES RWP.dat, Covar.m

## Analiza parametryczna

### Podejście BLACK-BOX

- 03 - propozycja kilku rzędów modeli

### Podejście GREY-BOX

- 04 - dyskretyzacja zapropowanego modelu w artykule [Nonlinear analysis and control of a reaction wheel pendulum:
Lyapunov-based approach](https://www.sciencedirect.com/science/article/pii/S221509861831574X)
- 05 - model czasu ciągłego przez zastosowanie filtru SVF

## Weryfikacja modelu

- 06 - weryfikajca modelu **TBD**