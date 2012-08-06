all: pod2html

## ------ Setup ------

WGET = wget
GIT = git
PERL = perl
PERL_VERSION = latest
PERL_PATH = $(abspath local/perlbrew/perls/perl-$(PERL_VERSION)/bin)

PMB_PMTAR_REPO_URL =
PMB_PMPP_REPO_URL = 

Makefile-setupenv: Makefile.setupenv
	$(MAKE) --makefile Makefile.setupenv setupenv-update \
	    SETUPENV_MIN_REVISION=20120337

Makefile.setupenv:
	$(WGET) -O $@ https://raw.github.com/wakaba/perl-setupenv/master/Makefile.setupenv

lperl lplackup local-perl perl-version perl-exec \
pmb-install pmb-update cinnamon \
local-submodules generatepm: %: Makefile-setupenv
	$(MAKE) --makefile Makefile.setupenv $@ \
	    PMB_PMTAR_REPO_URL=$(PMB_PMTAR_REPO_URL) \
	    PMB_PMPP_REPO_URL=$(PMB_PMPP_REPO_URL)

git-submodules:
	$(GIT) submodule update --init

## ------ Tests ------

PROVE = prove
PERL_ENV = PATH="bin/perl-$(PERL_VERSION)/pm/bin:$(PERL_PATH):$(PATH)" PERL5LIB="$(shell cat config/perl/libs.txt)"

test: test-deps test-main

test-deps: git-submodules local-submodules pmb-install

test-main:
	$(PERL_ENV) $(PROVE) t/*.t

## ------ Documents ------

pod2html: lib/Web/Encoding.html

POD2HTML = pod2html --css "http://suika.fam.cx/www/style/html/pod.css" \
  --htmlroot "../.."
SED = sed

%.html: %.pod
	$(POD2HTML) $< | $(SED) -e 's/<link rev="made" href="mailto:[^"]\+" \/>/<link rel=author href="#author">/' > $@
