Date: Tue, 3 Aug 2004 20:02:30 -0500
From: Micah Anderson <micah@riseup.net>
Message-ID: <20040804010230.GH21309@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] Sparc64 bug in 1.0.4
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org


Under sparc64, with the bridge module loaded, running brctl addbr br0
results in:

add bridge failed: Operation not supported
sys32_ioctl(brctl:6667): Unknown cmd fd(3) cmd(000089a0) arg(effffbf9) 

This was a known problem to the debian sparc list, and someone offered
a work-around back in April to an older version of bridge-utils (0.9.6), you
can see that thread here:

http://lists.debian.org/debian-sparc/2004/04/msg00077.html

Looking at the changelog for the bridgeutils upstream, it appears as 
if there have been some attempts to fix this, but it doesn't seem to
work.

I tried to do the "hack" that is suggested in that thread, which is
impossible in the newest source, so I used the 0.9.6 source. That did
indeed allow me to brctl addbr br0, but if I tried to do anything
else, brctl did not know of any bridges (brctl show showed nothing,
although the interface existed).

ugh... thanks for any help (please cc me on any replies),
micah

