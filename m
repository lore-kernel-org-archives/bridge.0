Message-ID: <48B5D43E.9060909@gmail.com>
Date: Wed, 27 Aug 2008 23:25:02 +0100
From: Cyker <cyker.lnx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Kernel bridge not passing some traffic (VNC,
	embedded webservers)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I've recently run into some weirdness with the Linux kernel bridge.

The easiest one to test is VNC: With 3 machines:

[Left] ---- [ServerBridge] ---- [Right]

If you run a VNC Server on [Left], and try to connect to it from a VNC
Client on [Right], it won't work properly.
You get as far as entering the password, at which point the VNCViewer
window will appear, but no image will, nor will it ever (As far as I can
tell from my tests!!)

If the VNCServer is on the [ServerBridge], both systems can connect to
it okay.
If the VNCServer is on one of the bridge 'arms', then only the
[ServerBridge] can connect to it and get a usable display.



The slightly trickier one to test is on a LinkSys WAG354G and a HP
DeskJet 6940 printer.

Both of these use built in web servers for configuration, and have the
same problem as above: If they are on one arm, e.g. [Left], anything on
[Right] will NOT be able to connect to them - Opera, Firefox etc. will
just sit there 'Waiting' for the thing to reply.
Printing to the printer using jetdirect protocols also doesn't work.

However, both devices are fully usable by the [ServerBridge] machine,
and any other computers on the same 'arm' as them.

If I swap [ServerBridge] for a 5-port switch (or a hub!) then everything
works as would be expected.


I've been hunting round for help on this but it seems nobody's run into
this problem, or it's obscure enough that no search engines can find
anything on it and none of the forums or IRC channels I've tried have
seen it either.

I've run tcpdump on the bridge, and packets are swapped and cross the
bridge okay for VNC's initial handshake, but then after that (Once the
blank VNCViewer has appeared) the conversation seems very one-way.

With the web servers, again, I'm seeing traffic for the initial
connections, but nothing seems to come back apart from acks.


The instant conclusion I'm tempted to jump to is that there is a bug in
the bridge code, but I find it hard to believe that something like this
would have been missed given how old that code is, so hopefully one of
you has some ideas of new stuff I can try...!

Note that I had iptables running, but I have disabled it while testing
with no effect.


Thanks in advance!
Cyker
