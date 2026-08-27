#!/bin/sh
# Installs the herdr plugins this config.toml's [[keys.command]] bindings
# depend on. config.toml has no declarative [plugins] block — herdr only
# tracks installs imperatively, in machine-local plugins.json — so this
# script is the reproducible record of what to install on a new machine.
set -eu

herdr plugin install andrewchng/herdr-sessionizer -y
herdr plugin install lmilojevicc/herdr-splits.nvim -y
herdr plugin install ezcorp-org/herdr-pc-ram-and-cpu-usage-overlay -y
herdr plugin install qu8n/herdr-automatic-rename -y
