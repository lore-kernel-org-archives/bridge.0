Message-ID: <8AA870658244D4119AF600508BDF0A361D4BEEB1@usahm014.exmi01.exch.eds.com>
From: "Small, Jim" <jim.small@eds.com>
Date: Mon, 2 Feb 2004 11:37:29 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] Problems with briding on 2.4.24 Sparc64 kernel and bridge
	utils 0 .9.6
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

I am running kernel 2.4.24/Sparc64 on my Ultra 60.  I also have the latest
version of the bridge utils - 0.9.6. 

When I try to add a bridge though I get this: 
# brctl addbr bridge0 
# brctl addif bridge0 hme0 
bridge bridge0 doesn't exist! 
# brctl show 
bridge name bridge id STP enabled interfaces 
(No bridges shown) 
# brctl addbr bridge0 
device bridge0 already exists; can't create bridge with the same name 

Note that the bridge module is loaded (viewable with lsmod).

I have 5 hme ports on my Ultra 60 (builtin + qfe) and I need really
bridging.  Please let me know if there is anything I can do to supply
more/better information.


My Hardware:  Ultra 60, 360MHz UltraSPARC II, 2GB RAM, 9 and 18GB SCSI HDDs,

builtin hme port, qfe card with 4 "hme" ports, SCSI-CDROM

Note that briding works in OpenBSD (with same machine described above)
albeit 
slowly so it is not a hardware problem or limitation.

I would be happy to try things, just let me know what to do.

Also, please E-mail me replies.  I have attempted to join the list, but thus
far have not been admitted by the moderator.

Thanks--Jim

