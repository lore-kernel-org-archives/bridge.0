Return-Path: <mazo@telum.ru>
From: Andrey Mazo <mazo@telum.ru>
Date: Fri, 21 Feb 2014 16:58:37 +0400
Message-Id: <1392987521-2289-1-git-send-email-mazo@telum.ru>
Subject: [Bridge] [PATCH 0/4] bridge-utils: build system fixes and cleanups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This short patch series implements several enhancements to the bridge-utils
build system.
The first two patches had already been sent to the list [1,2]
but unfortunately got no response.

[1] http://lists.linuxfoundation.org/pipermail/bridge/2013-August/008535.html
[2] http://lists.linuxfoundation.org/pipermail/bridge/2013-August/008536.html

Andrey Mazo (4):
  bridge-utils: Abort compilation on error in any subdirectory
  bridge-utils: Removed unused variable in doc/Makefile.in
  bridge-utils: AC_OUTPUT should be used without arguments
  bridge-utils: Pretty print configure help

 Makefile.in     |  4 ++--
 configure.ac    | 12 ++++++++----
 doc/Makefile.in |  2 --
 3 files changed, 10 insertions(+), 8 deletions(-)

-- 
1.8.4.5

