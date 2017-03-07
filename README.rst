================
boshiamy-braille
================
A braille character input plugin for `pi314/boshiamy.vim <https://github.com/pi314/boshiamy.vim>`_

This plugin is a standalone plugin with icon ``[⢝]``.


Installation
-------------
After installation, please add ``'braille'`` to ``g:boshiamy_plugins`` ::

  let g:boshiamy_plugins = ['braille']

Usage
------
These keys are recognized by this plugin: ::

  let g:boshiamy_braille_keys = '7uj8ikm,'

The sequence is mapped to ``12345678``, please refer to https://en.wikipedia.org/wiki/Braille_Patterns.

For example, ``78ij,`` geneartes ``⢝`` character.
