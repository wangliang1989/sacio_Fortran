FC = gfortran -Wall

all: sacio.mod module_crosscor.mod module_crossnorm.mod crosscor crossnorm getmean getmin clean

BIN = ${HOME}/bin

sacio.mod: sacio.f90
	$(FC) -c $^

module_crosscor.mod: module_crosscor.f90
	$(FC) -c $^

module_crossnorm.mod: module_crossnorm.f90
	$(FC) -c $^

%.o: %.f90
	$(FC) -c $^

crossnorm: %: %.o sacio.o module_crossnorm.o
	$(FC) $^ -o $(BIN)/$@

crosscor: %: %.o sacio.o module_crosscor.o
	$(FC) $^ -o $(BIN)/$@

getmean:  %: %.o sacio.o
	$(FC) $^ -o $(BIN)/$@

getmin:  %: %.o sacio.o
	$(FC) $^ -o $(BIN)/$@

clean:
	-rm *.o *.mod
