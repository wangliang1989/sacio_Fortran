FC = gfortran -Wall

MAIN = cross

BIN = ${HOME}/bin

all: sacio.mod module_cross.mod $(MAIN) clean

sacio.mod: sacio.f90
	$(FC) -c $^

module_cross.mod: module_cross.f90
	$(FC) -c $^

%.o: %.f90
	$(FC) -c $^

$(MAIN): %: %.o sacio.o module_cross.o
	$(FC) $^ -o $(BIN)/$@

clean:
	-rm *.o *.mod
