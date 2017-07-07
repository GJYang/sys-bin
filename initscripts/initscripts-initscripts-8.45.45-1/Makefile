ROOT=/
SUPERUSER=root
SUPERGROUP=root

VERSION := $(shell awk '/Version:/ { print $$2 }' initscripts.spec)
RELEASE := $(subst %{?dist},,$(shell awk '/Release:/ { print $$2 }' initscripts.spec))
TAG=initscripts-$(VERSION)-$(RELEASE)
ARCH = $(shell uname -m)

mandir=/usr/share/man

all:
	make -C src
	make -C po

install:
	mkdir -p $(ROOT)/etc/profile.d $(ROOT)/sbin $(ROOT)/usr/sbin
	mkdir -p $(ROOT)$(mandir)/man{5,8}
	mkdir -p $(ROOT)/etc/rwtab.d $(ROOT)/var/lib/stateless/writable

	install -m644  inittab adjtime $(ROOT)/etc
	if uname -m | grep -q s390 ; then \
	  install -m644 inittab.s390 $(ROOT)/etc/inittab ; \
	fi
	install -m644  rwtab $(ROOT)/etc
	install -m755  service setsysfont $(ROOT)/sbin
	install -m755  lang.csh lang.sh $(ROOT)/etc/profile.d
	install -m755  sys-unconfig $(ROOT)/usr/sbin
	install -m644  crypttab.5 sysctl.d.5 $(ROOT)$(mandir)/man5
	install -m644  service.8 sys-unconfig.8 $(ROOT)$(mandir)/man8
	install -m644 sysctl.conf $(ROOT)/etc/sysctl.conf
	if [ -f sysctl.conf.$(ARCH) ]; then \
	  install -m644 sysctl.conf.$(ARCH) $(ROOT)/etc/sysctl.conf ; fi

	mkdir -p $(ROOT)/etc/X11
	install -m755 prefdm $(ROOT)/etc/X11/prefdm

	cp -af rc.d sysconfig ppp udev $(ROOT)/etc
	mkdir -p $(ROOT)/etc/ppp/peers
	chmod 755 $(ROOT)/etc/rc.d/* $(ROOT)/etc/rc.d/init.d/*
	chmod 755 $(ROOT)/etc/ppp/peers
	chmod 755 $(ROOT)/etc/ppp/ip*
	chmod 755 $(ROOT)/etc/sysconfig/network-scripts/ifup-*
	chmod 755 $(ROOT)/etc/sysconfig/network-scripts/ifdown-*
	chmod 755 $(ROOT)/etc/sysconfig/network-scripts/init*
	chmod 755 $(ROOT)/etc/sysconfig/network-scripts/net.hotplug
	mkdir -p $(ROOT)/etc/sysconfig/modules
	mkdir -p $(ROOT)/etc/sysconfig/networking/devices
	mkdir -p $(ROOT)/etc/sysconfig/networking/profiles/default
	#mv  $(ROOT)/etc/sysconfig/network-scripts/ifcfg-lo \
	#	$(ROOT)/etc/sysconfig/networking/devices
	#ln -s ../networking/devices/ifcfg-lo \
	#   	$(ROOT)/etc/sysconfig/network-scripts/ifcfg-lo
	#ln -s ../networking/devices/ifcfg-lo \
	#	$(ROOT)/etc/sysconfig/networking/profiles/default/ifcfg-lo
	mkdir -p $(ROOT)/etc/sysconfig/console
	if uname -m | grep -q s390 ; then \
	  install -m644 sysconfig/init.s390 $(ROOT)/etc/sysconfig/init ; \
	else \
	  rm -f $(ROOT)/etc/sysconfig/init.s390 ; \
	fi

	mv $(ROOT)/etc/sysconfig/network-scripts/ifup $(ROOT)/sbin
	mv $(ROOT)/etc/sysconfig/network-scripts/ifdown $(ROOT)/sbin
	(cd $(ROOT)/etc/sysconfig/network-scripts; \
	  ln -sf ifup-ippp ifup-isdn ; \
	  ln -sf ifdown-ippp ifdown-isdn ; \
	  ln -sf ../../../sbin/ifup . ; \
	  ln -sf ../../../sbin/ifdown . )
	make install ROOT=$(ROOT) mandir=$(mandir) -C src
	make install PREFIX=$(ROOT) -C po

	mkdir -p $(ROOT)/var/run/netreport $(ROOT)/var/log
	chown $(SUPERUSER):$(SUPERGROUP) $(ROOT)/var/run/netreport
	chmod u=rwx,g=rwx,o=rx $(ROOT)/var/run/netreport
	touch $(ROOT)/var/run/utmp
	touch $(ROOT)/var/log/wtmp
	touch $(ROOT)/var/log/btmp

	for i in 0 1 2 3 4 5 6 ; do \
		dir=$(ROOT)/etc/rc.d/rc$$i.d; \
	  	mkdir $$dir; \
		chmod u=rwx,g=rx,o=rx $$dir; \
	done

# Can't store symlinks in a CVS archive
	ln -s ../init.d/killall $(ROOT)/etc/rc.d/rc0.d/S00killall
	ln -s ../init.d/killall $(ROOT)/etc/rc.d/rc6.d/S00killall

	ln -s ../init.d/halt $(ROOT)/etc/rc.d/rc0.d/S01halt
	ln -s ../init.d/halt $(ROOT)/etc/rc.d/rc6.d/S01reboot

	ln -s ../init.d/single $(ROOT)/etc/rc.d/rc1.d/S99single

	ln -s ../rc.local $(ROOT)/etc/rc.d/rc2.d/S99local
	ln -s ../rc.local $(ROOT)/etc/rc.d/rc3.d/S99local
	ln -s ../rc.local $(ROOT)/etc/rc.d/rc4.d/S99local
	ln -s ../rc.local $(ROOT)/etc/rc.d/rc5.d/S99local

# These are LSB compatibility symlinks.  At some point in the future
# the actual files will be here instead of symlinks
	for i in 0 1 2 3 4 5 6 ; do \
		ln -s rc.d/rc$$i.d $(ROOT)/etc/rc$$i.d; \
	done
	for i in rc rc.sysinit rc.local ; do \
		ln -s rc.d/$$i $(ROOT)/etc/$$i; \
	done



check:
	for afile in `find . -type f -perm +111|grep -v \.csh | grep -v po/ |grep -v .git/` ; do \
		if ! file $$afile | grep -s ELF  >/dev/null; then \
		    bash -n $$afile || { echo $$afile ; exit 1 ; } ; \
		fi  ;\
	done

changelog:
	@rm -f ChangeLog
	git log --stat --no-merges -B > ChangeLog

clean:
	make clean -C src
	make clean -C po
	@rm -fv *~ changenew ChangeLog.old *gz

tag:
	@git tag -a -m "Tag as $(TAG)" -f $(TAG)
	@echo "Tagged as $(TAG)"

archive: clean check tag changelog
	@git archive --format=tar --prefix=initscripts-$(VERSION)/ HEAD > initscripts-$(VERSION).tar
	@mkdir -p initscripts-$(VERSION)/
	@cp ChangeLog initscripts-$(VERSION)/
	@tar --append -f initscripts-$(VERSION).tar initscripts-$(VERSION)
	@bzip2 -f initscripts-$(VERSION).tar
	@rm -rf initscripts-$(VERSION)
	@echo "The archive is at initscripts-$(VERSION).tar.bz2"
