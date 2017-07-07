include /home/gjyang/sys-bin/one_time_build_env_include
CC=arm-linux-gnueabihf-gcc
LDFLAGS+=-L$(OUTDIR)/popt/usr/lib
CFLAGS+=$(RPM_OPT_FLAGS) -Wall -D_GNU_SOURCE
CFLAGS+=-I$(OUTDIR)/popt/usr/include
ROOT=$(OUTDIR)/initscripts
PROGS=usernetctl netreport testd usleep ipcalc initlog \
	fstab-decode getkey consoletype genhostid 

INITLOG_OBJS=initlog.o process.o
USLEEP_OBJS=usleep.o

all:	$(PROGS)

clean:
	rm -f $(PROGS) *.o

install:
	mkdir -p $(ROOT)/bin $(ROOT)/usr/sbin $(ROOT)/etc $(ROOT)/lib/udev
	install -m 755 usleep $(ROOT)/bin/usleep
	install -m 4755 usernetctl $(ROOT)/usr/sbin/usernetctl
	install -m 2755 netreport $(ROOT)/sbin/netreport
	install -m 755 ipcalc $(ROOT)/bin/ipcalc
	install -m 755 fstab-decode $(ROOT)/sbin/fstab-decode
	install -m 755 genhostid $(ROOT)/sbin/genhostid
	install -m 755 initlog $(ROOT)/sbin/initlog
	install -m 755 getkey $(ROOT)/sbin/getkey
	install -m 755 consoletype $(ROOT)/sbin/consoletype
	install -m 644 initlog.conf $(ROOT)/etc

# this daemon and initscript are useful for testing the up/down/status stuff
# not installed by default, only comes from sources.
install-test:
	install -m 755 testd $(ROOT)/usr/sbin/testd
	install -m 755 testdinit $(ROOT)/etc/init.d/testd

getkey: getkey.o
	$(CC) $(LDFLAGS) -o $@ $< -Wl,-Bstatic -lpopt -Wl,-Bdynamic

ipcalc: ipcalc.o
	$(CC) -D_GNU_SOURCE $(LDFLAGS) -o $@ $< -Wl,-Bstatic -lpopt -Wl,-Bdynamic

initlog: $(INITLOG_OBJS)
	$(CC) $(LDFLAGS) -o $@ $(INITLOG_OBJS) -Wl,-Bstatic -lpopt -Wl,-Bdynamic

usleep: $(USLEEP_OBJS)
	$(CC) $(LDFLAGS) -o $@ $(USLEEP_OBJS) -Wl,-Bstatic -lpopt -Wl,-Bdynamic

usernetctl.o: usernetctl.c
	$(CC) $(CFLAGS) -fPIE -c usernetctl.c -o usernetctl.o

usernetctl: usernetctl.c usernetctl.o
	$(CC) $(LDFLAGS) -pie -o $@ $@.o

kmodule: kmodule.o
	$(CC) $(LDFLAGS) -o $@ $< -Wl,-Bstatic -lpopt -Wl,-Bdynamic -lkudzu -lpci
