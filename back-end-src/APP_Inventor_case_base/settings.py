# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

CONFIG_ENV = 'local'

import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from setting_split.common import *
if CONFIG_ENV == 'local':
    from setting_split.local import *
elif CONFIG_ENV == 'remote':
    from setting_split.remote import *
elif CONFIG_ENV == 'initial':
    from setting_split.initial import *

import os