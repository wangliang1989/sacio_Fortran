FC = gfortran -Wall

MAIN = test_sacio_readhead test_sacio_readsac test_sacio_readsac_cut \
	   test_sacio_writesac test_sacio_newhead test_sacio_nullhead

all: sacio.mod $(MAIN) clean

sacio.mod: sacio.f90
	$(FC) -c $^

%.o: %.f90
	$(FC) -c $^

$(MAIN): %: %.o sacio.o
	$(FC) $^ -o $@

clean:
	-rm *.o *.mod

cleanall: clean
	-rm $(MAIN) testout.sac test_sacio_newhead_out.sac
