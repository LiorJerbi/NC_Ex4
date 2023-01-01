CC = gcc
FLAGS = -Wall -g -fPIC
EXECUTABLE_FILE = myping

all: $(EXECUTABLE_FILE) link setcap

setcap: $(EXECUTABLE_FILE)
	sudo setcap 'CAP_NET_RAW+ep' $(EXECUTABLE_FILE)

link: $(EXECUTABLE_FILE)
	test -L /usr/local/bin/myping || sudo ln -s $(CURDIR)/$(EXECUTABLE_FILE) /usr/local/bin/$(EXECUTABLE_FILE)

$(EXECUTABLE_FILE): myping.o
	$(CC) $(FLAGS) -o $(EXECUTABLE_FILE) myping.o

myping.o: myping.c
	$(CC) $(FLAGS) -c myping.c

.PHONY: clean all

clean:
	rm -f *.o $(EXECUTABLE_FILE)