===============================================================================
ime-braille.vim
===============================================================================
A braille character input plugin for `pi314/ime.vim <https://github.com/pi314/ime.vim>`_

This plugin is a standalone plugin with icon ``[⢝]``.


Installation
-------------------------------------------------------------------------------
After installation, please add ``'braille'`` to ``g:ime_plugins`` ::

  let g:ime_plugins = ['braille']

Usage
-------------------------------------------------------------------------------
These keys are recognized by this plugin: ::

  let g:ime_braille_keys = '3ed4rfcv'

The sequence is mapped to ``12345678``. In visual representation:

::

  (1) (4)
  (2) (5)
  (3) (6)
  (7) (8)

For example, ``34rdv`` geneartes ``⢝`` character.

``<space>`` generates ``⣿`` character.


Referernces
-------------------------------------------------------------------------------
https://en.wikipedia.org/wiki/Braille_Patterns.
