# -*- makefile -*-

jobs-args += --help

$(if $(findstring create,$(MAKECMDGOALS)),\
  $(eval topic ?= $$(error topic= is required))\
)

job-topic = jobs/$(topic)


all:
	./jobs.sh $(jobs-args)

create: $(job-topic)

$(job-topic):
	~/etc/cleanup
	mkdir -p $@
	rsync -rv --checksum tmpl/. $@/.
	sed -i 's/{tmpl}/$(topic)/g' $@/*.sh
#	-@emacs $@/*.sh
	-@emacs jobs.sh

clean:
	~/etc/cleanup

# [EOF]
