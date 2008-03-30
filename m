From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <fed120860803301213r6f1e1aadwf26d269a4224b768@mail.gmail.com>
References: <8571495929364495836@unknownmsgid>
	<fed120860803300232v678efc1dr862e5d3ba5fbf16d@mail.gmail.com>
	<7423344835968003573@unknownmsgid>
	<fed120860803301213r6f1e1aadwf26d269a4224b768@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Mar 2008 23:18:53 +0200
Message-Id: <1206911933.7589.426.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Subject: Re: [Bridge] RSTP
	in	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
	a=summary	problems
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Srinivas M.A." <srinivas.aji@gmail.com>
Cc: Bridge@lists.linux-foundation.org


On Mon, 2008-03-31 at 00:43 +0530, Srinivas M.A. wrote:
> >  > One limitation
> >  > is that there is no mechanism to automatically restart or fall back to
> >  > kernel STP if the RSTP
> >  > daemon crashes. But it hasn't crashed lately in our testing.
> >
> >  Should be fixable, just vfork and wait for an abnormal exit status,
> >  reset state and vfork again.
> 
> Yes, doable, not yet done though.
> 
> >  hmm, how does stp_state become 2? Do I need a new kernel(on 2.6.23 now)?
> 
> >  Don't follow, why do I need a bridge-stp at all? Seem like I should
> >  just start rstpd and config my bridge normally?
> 
> 2.6.23 has all the kernel stuff needed.
> 
> The way things happen is this:
> 
> When you do "brctl stp <bridge_name> on", the kernel runs
> "/sbin/bridge-stp <bridge_name> start" and waits for the exit code. If
> the exit code is 0, the kernel sets stp_state to 2, and assumes that
> userspace will take care of STP and does not do any STP actions. (This
> state is different from STP disabled, since during STP disabled, the
> kernel still brings up ports from learning to forwarding using a
> timeout, and also, the bridge forwards BPDUs too in that state.) If
> the exit code is non-zero, stp_state is set to 1 and kernel STP is
> activated.
> 
> So you need to:
> 1. Start rstpd
> 2. Have a bridge-stp script that returns success
> 3. Configure your bridge. (Here, because of the event mechanism
> currently available, it is best to do "brctl stp <bridge_name> on"
> before doing "ifconfig <bridge_name> up")
> 
> > I do this
> > ./rstpd
> > brctl addbr br0
> > brctl addif br0 eth0
> > brctl stp br0 on
> > ifconfig eth0 0.0.0.0 up
> > ifconfig br0  0.0.0.0 up
> > ./rstpctl showbridge
> 
> > It does not get enabled and
> > #> cat /sys/class/net/br0/bridge/stp_state
> > 1
> 
> This should have worked. Could you check that /sbin/bridge-stp has
> execute bit set and is getting run? It doesn't have stdout, etc, so
> you need to log messages to a file to see what is happening. e.g.
> (date; echo $0 "$@") >>/tmp/bridge-stp.log

Ahh, I didn't copy bridge-stp to /sbin because I didn't think it was
needed. Just to test I blindly copied it to /sbin and did:
 brclt addbr br0
 brctl addif br0 eth0
 brctl stp br0
and it hung my board :(
So now I got to wait until I get to work. 
Not sure I like the dependancy on /sbin/bridge-stp hardcoded like that, but
for now it will do.

Meanwhile I got 2 patches for you:

From 152373da339f7ef2e71c696af1813e7425d83e79 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Sun, 30 Mar 2008 22:45:40 +0200
Subject: [PATCH] offsetof is defined in stddef.h, use that.


Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 rstp.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/rstp.c b/rstp.c
index 7191778..b506373 100644
--- a/rstp.c
+++ b/rstp.c
@@ -29,6 +29,7 @@
 *********************************************************************/
 
 #include "rstp.h"
+#include <stddef.h>
 #include <string.h>
 
 /* Macros to be used in the later parts */
@@ -1144,9 +1145,9 @@ static void setTcPropTree(PORT_ARGS_PROTO)
 /***** txConfig(), txRstp() and txTcn() *****/
 
 /* To decide how much of the RawBPDU to actually transmit */
-#define offsetof(_TYPE, _MEMBER)  __builtin_offsetof (_TYPE, _MEMBER)
-//#define offsetof(_TYPE, _MEMBER) ((int)&((_TYPE *)0)->_MEMBER)
-
+#ifndef offsetof
+#define offsetof(_TYPE, _MEMBER) ((int)&((_TYPE *)0)->_MEMBER)
+#endif
 /* To fill the times values in the BPDU in txConfig() and txRstp() */
 
 static void set_bpdu_time(uchar time[2], int t)
-- 
1.5.4.3

From 14fc4be633e28e4ec7c1be7635e52f5ca44abc1b Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Sun, 30 Mar 2008 22:59:07 +0200
Subject: [PATCH] Replace gcc extension with C.


Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 rstp.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/rstp.c b/rstp.c
index b506373..4db6074 100644
--- a/rstp.c
+++ b/rstp.c
@@ -43,22 +43,17 @@
 
 
 /* memcmp wrapper, validating size equality of _a and _b */
-#define CMP(_a, _op, _b)                                           \
-(memcmp(&(_a), &(_b),                                              \
-  __builtin_choose_expr(sizeof(_a) == sizeof(_b),                  \
-                        sizeof(_a),                                \
-                        (void)0)                                   \
-) _op 0)
+#define CMP(_a, _op, _b)					   \
+  (memcmp(&(_a), &(_b),						   \
+	  (sizeof(_a) == sizeof(_b) ?  sizeof(_a) : 0)		   \
+	  ) _op 0)
 
 #define ZERO(_a) memset(&(_a), 0, sizeof(_a))
 
 /* memcmp wrapper, validating size equality of _a and _b */
-#define CPY(_a, _b)                                           \
-(memcpy(&(_a), &(_b),                                              \
-  __builtin_choose_expr(sizeof(_a) == sizeof(_b),                  \
-                        sizeof(_a),                                \
-                        (void)0)                                   \
-))
+#define CPY(_a, _b)					      \
+  (memcpy(&(_a), &(_b),					      \
+	  (sizeof(_a) == sizeof(_b) ? sizeof(_a) : 0)))	      \
 
 #define BRIDGE_ARGS_PROTO        Bridge *BRIDGE
 #define PORT_ARGS_PROTO          Bridge *BRIDGE, Port *PORT
-- 
1.5.4.3

These are not tested as I manged to hang my board, stupid me beeing to impatient.

 Jocke

> 
> Also, rstp will log to syslog. To see lots more messages, you can do
> "rstpctl debuglevel 4", but since we are doing
> (main.c) vsyslog((level <= LOG_LEVEL_INFO) ? LOG_INFO : LOG_DEBUG, ....
> you need to configure your syslog to log the LOG_DEBUG messages as
> well to see them, or just fix the code to get all the messages at
> LOG_INFO.
> 
> > Have this code been tested on a big endian CPU?
> 
> No, only ix86 and x86_64 at the moment. At least in the RSTP logic
> itself (rstp.[ch]), I seem to have taken some care to use bytes
> directly for the on-the-wire structures and convert to and from
> numbers using arithmetic, which should be endian independent. I don't
> see any obviously little endian specific code in the other parts
> either. The rstpctl program relies on structures having the same
> binary layout in it as well as in rstpd, but that should not be
> affected by endianness.
> 
> In any case, see if you can get the bridge-stp thing working to the
> point where you see stp_state as 2. If you see issues past that, like
> received BPDU's not being recognized, or anything else seeming
> endianness related, I will set up a qemu powerpc image and test.
> 
> Thanks.
> 
