Date: Thu, 27 May 2004 17:45:39 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
Subject: Re: [Bridge] [announce] bridge-utilities 1.0
Message-ID: <20040527154539.GA17201@man.manty.net>
References: <20040526105147.650ddfa9@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526105147.650ddfa9@dell_ss3.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

Hi!

> I've released a new version of the bridge-utilities to go with the recent
> kernel changes.  The utilities have certainly matured enough to earn the
> 1.0 moniker. This release is fixes the internal issues that broke running 
> 32 bit utilities on 64bit systems, and fixes scaling issues.

I'm trying to compile this new version for Debian, I have compiled it using
the headers from 2.6.7-rc1 and also using libsysfs 1.1.0.

After getting it compiled I tested it in a machine with a 2.6.6 kernel, and
thus without latest kernel changes, I have found a lot of things that in
this kind of configuration didn't work and some others that looked a bit
ugly to me...

Cosmetic problems:

# brctl show
bridge name     bridge id               STP enabled     interfaces
br0             Can't open directory: /sys/class/net/br0/bridge
8000.00010224a704       yes             eth1
br1             Can't open directory: /sys/class/net/br1/bridge
8000.000000000000       no
# brctl setageing br1 20
Can't open directory: /sys/class/net/br1/bridge
# brctl setbridgeprio br1 2 
Can't open directory: /sys/class/net/br1/bridge
# brctl setfd br1 2
Can't open directory: /sys/class/net/br1/bridge
# brctl sethello br1 2
Can't open directory: /sys/class/net/br1/bridge
# brctl setmaxage br1 2
Can't open directory: /sys/class/net/br1/bridge
# brctl setpathcost br0 eth0 2
Can't open directory: /sys/class/net/eth0/brport
# brctl setportprio br0 eth0 2
Can't open directory: /sys/class/net/eth0/brport
# brctl stp br1 on
Can't open directory: /sys/class/net/br1/bridge


Commands that don't seem to work:

# brctl addbr br2
add bridge failed: Invalid argument
# brctl delbr br1
can't delete bridge br1: Invalid argument
# brctl addif br0 eth0
can't add eth0 to bridge br0: Invalid argument
# brctl delif br0 eth1
device eth1 is not a slave of br0
# brctl showstp br0 
Can't open directory: /sys/class/net/br0/bridge
br0
 bridge id              8000.00010224a704
 designated root        7fff.000021002dc0
 root port                 2                    path cost                  2
 max age                  20.00                 bridge max age           200.00
 hello time                2.00                 bridge hello time         20.00
 forward delay            50.00                 bridge forward delay       5.00
 ageing time             300.00
 hello timer               0.00                 tcn timer                  0.00
 topology change timer     0.00                 gc timer                 213.70
 flags                  


eth1 (3)
Can't open directory: /sys/class/net/eth1/brport
can't get port eth1(3) info Operation not supported
 can't get port info


I don't have time to look at this problems and send a patch right now, sorry
:-(

I'd like to let you know a couple of things about the build, it went ok, but
on cleaning you forgot to remove libbridge/config.h and libbridge/stamp-h1,
also, not everybody has rcsclean, so maybe you could apply this patch:

--- bridge-utils-1.0.orig/libbridge/Makefile.in
+++ bridge-utils-1.0/libbridge/Makefile.in
@@ -30,7 +30,7 @@
 
 
 clean:
-	rcsclean *
+	-rcsclean *
 	rm -f *~
 	rm -f *.o
 	rm -f libbridge.a


Regards...
-- 
Manty/BestiaTester -> http://manty.net
