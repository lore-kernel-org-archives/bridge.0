Message-ID: <406C3936.3080305@tac.ch>
Date: Thu, 01 Apr 2004 17:45:58 +0200
From: Roberto Nibali <ratz@tac.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] --with-linux-headers not working for me
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,

I'm not subscribed to this list, so please cc replies to me.

I'm working on version 0.9.6 of the bridge-utils package.

--with-linux-headers=<insert_directory> doesn't seem to cut it, since the 
implementation in configure does only honour --with-linux. I would have made a 
patch but it seems that configure was manually patched after the 
automuckup^Hautogen tools generated it. The relevant code in question is:

configure:1186:# Check whether --with-linux or --without-linux was given.
configure-1187-if test "${with_linux+set}" = set; then
configure-1188-  withval="$with_linux"
configure-1189-  KERNEL_HEADERS=$withval
configure-1190-else
configure-1191-  KERNEL_HEADERS="/usr/src/linux/include"
configure-1192-fi;

Here is a short trace for reproducability:

bridge$ grep -B1 linux Makefile
         cd ${SUBDIRS}; LDFLAGS="-s --static" ./configure \
                 --with-linux-headers=${SRCDIR}/kernel/src/include
bridge$ make config >/dev/null
bridge$ grep KERNEL src/Makefile
KERNEL_HEADERS=-I/usr/src/linux/include
bridge$ vi Makefile
bridge$ make distclean 2>/dev/null
/bin/sh: rcsclean: command not found
make[2]: *** [clean] Error 127
/bin/sh: rcsclean: command not found
make[2]: *** [clean] Error 127
bridge$ grep -B1 linux Makefile
         cd ${SUBDIRS}; LDFLAGS="-s --static" ./configure \
                 --with-linux=${SRCDIR}/kernel/src/include
bridge$ make config >/dev/null
bridge$ grep KERNEL src/Makefile
KERNEL_HEADERS=-I/<edited_for_ledgibility>/kernel/src/include
/bridge$

Please check and if my findings are correct. If so might I humble request you 
address this issue. If not they are not, my sincere apologies for the waste of 
electrons on this list.

Also in my opinion it is not neccessary to include the rcsclean into the clean 
target because firstly no shipped package should ever contain rcs remains and 
secondly not everyone has rcsclean installed on every machine as you can see.

Thank you and best regards,
Roberto Nibali, ratz
-- 
-------------------------------------------------------------
addr://Rathausgasse 31, CH-5001 Aarau  fon://++41 62 823 9355
http://www.terreactive.com             fax://++41 62 823 9356
-------------------------------------------------------------
terreActive AG                       Wir sichern Ihren Erfolg
-------------------------------------------------------------

