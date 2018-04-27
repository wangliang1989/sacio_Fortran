FC = gfortran -Wall -fopenmp

MAIN = crossnorm

BIN = ${HOME}/bin

all: sacio.mod module_crossnorm.mod $(MAIN) clean

sacio.mod: sacio.f90
	$(FC) -c $^

module_crossnorm.mod: module_crossnorm.f90
	$(FC) -c $^

%.o: %.f90
	$(FC) -c $^

$(MAIN): %: %.o sacio.o module_crossnorm.o
	$(FC) $^ -o $(BIN)/$@

clean:
	-rm *.o *.mod
