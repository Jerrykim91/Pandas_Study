#!/usr/bin/env python
# coding: utf-8

# In[4]:


import platform
from matplotlib import font_manager, rc, pyplot as plt
import matplotlib
get_ipython().run_line_magic('matplotlib', 'inline')

def initKoreaFontLoad():
    plt.rcParams['axes.unicode_minus'] = False
    os_name = platform.system()

    if os_name == 'Darwin':   # MacOS, Linux
        rc( 'font', family='AppleGothic' ) # 통상 맥을 사용한다고 보고, 폰트를 지정

    elif os_name == 'Windows':# window10~,window server
        path = "c:/Windows/Fonts/malgun.ttf"
        font_name = font_manager.FontProperties(fname=path).get_name()
        print(font_name)
        rc( 'font', family=font_name)#'Malgun Gothic' )

    else:
        print('알수없는 시스템')
        pass

