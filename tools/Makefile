FC = gfortran -Wall

all: sacio.mod module_cross.mod module_crossnorm.mod cross crossnorm clean

BIN = ${HOME}/bin

sacio.mod: sacio.f90
	$(FC) -c $^

module_cross.mod: module_cross.f90
	$(FC) -c $^

module_crossnorm.mod: module_crossnorm.f90
	$(FC) -c $^

%.o: %.f90
	$(FC) -c $^

crossnorm: %: %.o sacio.o module_crossnorm.o
	$(FC) $^ -o $(BIN)/$@

cross: %: %.o sacio.o module_cross.o
	$(FC) $^ -o $(BIN)/$@

clean:
	-rm *.o *.mod
