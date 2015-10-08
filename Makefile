#
# RPM Builder Makefile
#
#PWD	 :sh = pwd
TOUCH=touch
MKDIR=mkdir
RM=rm
LN=ln
ECHO=echo
TOPDIR=$(PWD)
RPMDIR?=$(TOPDIR)/RPMS
SRPMDIR?=$(TOPDIR)/SRPMS

QUIET=@
Q:=$(QUIET)
E=$(ECHO) 
V=$(ENV)
QE=$(Q)$(E)
QV=$(Q)$(V)

MAKEARGS=QUIET=$(QUIET) --no-print-directory 
M=$(MAKE) $(MAKEARGS)
QVM=$(QV) $(M)
QM=$(Q)$(M)

SPECSDIR=SPECS
SPECTOOL:=$(TOPDIR)/spectool
RPMBUILD=rpmbuild
RPMBUILD_MODE=-ba
RPMBUILD_OPTS=$(RPMBUILD_QUIET) $(RPMBUILD_MODE)

SPECFILES:=$(foreach dir,$(SPECSDIR),$(wildcard $(dir)/*.spec))

all: build-rpms 

build-rpm/%:
	@$(E) " ==> Running $(RPMBUILD) on $(notdir $*)"
	$(Q)$(RPMBUILD) $(RPMBUILD_OPTS) \
		--define "_topdir $(TOPDIR)" \
		--define "_rpmdir $(RPMDIR)" \
		--define "_srcrpmdir $(SRPMDIR)" \
		$(SPECSDIR)/$(notdir $*) || exit 1

build-rpms:
	$(Q)sh -c ' \
		for s in skipme $(SPECFILES); \
		do \
			case "$$s" in skipme*) continue;; *);; esac; \
			$(E) " ==> Building $$s"; \
			$(M) build-rpm/$$s; \
		done; \
	'

fetch/%:
	@$(E) " ==> Running $(SPECTOOL) on $(notdir $*)"
	$(Q)$(SPECTOOL) -S -R -g \
		$(SPECSDIR)/$(notdir $*) || exit 1

sources:
	 $(Q)sh -c ' \
		for s in skipme $(SPECFILES); \
		do \
			case "$$s" in skipme*) continue;; *);; esac; \
			$(E) " ==> Fetching Sources for $$s"; \
			$(M) fetch/$$s; \
		done; \
	'

clean:
	@$(E) " ==> Running $@"
	$(RM) -rf BUILD BUILDROOT RPMS SRPMS
