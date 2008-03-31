Message-ID: <fed120860803310959g7d70a5e6s6f40c4275d14592a@mail.gmail.com>
Date: Mon, 31 Mar 2008 22:29:55 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <1206949458.7589.447.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8571495929364495836@unknownmsgid>
	<fed120860803300232v678efc1dr862e5d3ba5fbf16d@mail.gmail.com>
	<7423344835968003573@unknownmsgid>
	<fed120860803301213r6f1e1aadwf26d269a4224b768@mail.gmail.com>
	<1206911933.7589.426.camel@gentoo-jocke.transmode.se>
	<fed120860803310025p33efd12ds6cbba5d0f978caf5@mail.gmail.com>
	<1206949458.7589.447.camel@gentoo-jocke.transmode.se>
Subject: Re: [Bridge] RSTP in
	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
	a=summary problems
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: joakim.tjernlund@transmode.se
Cc: Bridge@lists.linux-foundation.org

>
>  So I both get a SEGV and the kernel thinks userspace is running STP, not
>  ideal.

Segfault is fixed by this:

diff --git a/log.h b/log.h
index ce0d94e..2fcdcfb 100644
--- a/log.h
+++ b/log.h
@@ -63,7 +63,7 @@ extern int log_level;
 #ifdef NO_DAEMON

 #define ERROR(_fmt, _args...) \
-       PRINT(LOG_LEVEL_ERROR, "%s: " _fmt, ##_args)
+       PRINT(LOG_LEVEL_ERROR, "%s: " _fmt, __PRETTY_FUNCTION__, ##_args)

 #else
 #define ERROR(_fmt, _args...) \


>
>  I really think one should be able to start RSTP with rtspctl too so
>  one doesn't need /sbin/bridge-stp

bridge-stp is a way to tell the kernel whether it should run its STP
or not. This was set up to make it possible for users to run "brctl
stp <bridge_name> on" without directly being concerned with whether
kernel STP or userspace STP will be run.
But that doesn't really happen in practice I guess.

Unfortunately, bridge-stp is run with the kernel holding the RTNL
lock, so the set of things it can do without causing a hang is
limited. With the current kernel infrastructure, my preference would
be to start rstpd from the network init scripts in the system and use
bridge-stp just to decide whether to enable RSTP or kernel STP for the
given bridge, perhaps based on a setting in ifcfg-<bridge_name> (in
Redhat network config).

For more robustness, maybe we need additional kernel infrastructure
where the daemon can tell the kernel it will handle STP (this can be
done now by setting stp off and then on when bridge-stp will return
0), but where the kernel can also tell (maybe by polling) if the
daemon quits and fall back to kernel STP in that case.
