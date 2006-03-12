Date: Sun, 12 Mar 2006 12:38:49 +0100
Message-Id: <1029025699@web.de>
MIME-Version: 1.0
From: devzero@web.de
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Bridge] aoe/vblade on "localhost"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

hello !

i try to use a network technology on one single host, which wasn`t designed for that. 

to give a short overview of what i`m talking about:

AoE is just like a "networked blockdevice" (just like nbd/enbd) - but without tcp/ip. 
AoE kernel driver is the "client end" (see this like an iSCSI initiator) - and an etherblade storage appliance is the "server end" (see this like an iSCSI target)
there is a software equivalent to etherblade storage which is called vblade (part of the aoetools project) - or vblade-kernel (another implementation, but done as a kernel module)

a very nice article about what AoE is can be found at http://www.linuxjournal.com/comment/reply/8149

what i want to do is nicely described in this bugreport by some other person:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=336772

i want to connect a AoE driver to vblade on _one_ host and i have tried that mentioned "clever juggling of network devices" on my system, but i didn`t succedd.

some coraid employee recommended trying linux-bridging - so i created two dummy interfaces (module dummy.ko), created a bridge "aoe-bridge" and added dummy0 and dummy1 to that bridge.

then i "connected" AoE-driver to dummy0 and vblade server process to dummy1 and would have expected that this should work.

unfortunately, it failed to work and from what it seems it wasn`t a problem with AoE or vblade but with the bridge, because i couldn`t see (tcpdump) packets going through into both directions. 

afaik, after starting, the bridge is in some "learning" state, to see what is on the "left side" and on the "right side".
i`m somewhat unsure if AoE/vblade are sending out enough (or the right?) packets to make the bridge let them go through (aoe and vblade get aware of each other via broadcast) 

can somebody give an advice on what needs to be taken into account here and what could be done to debug this?
regards

roland k. 
systems engineer
______________________________________________________________________
XXL-Speicher, PC-Virenschutz, Spartarife & mehr: Nur im WEB.DE Club!		
Jetzt gratis testen! http://freemail.web.de/home/landingpad/?mc=021130

