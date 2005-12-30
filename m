Message-ID: <dbf855d00512300011t6c4c445w2109458b1c036083@mail.gmail.com>
Date: Fri, 30 Dec 2005 00:11:33 -0800
From: <wandering.womble@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] eth0- can't enslave to br0,
	but eth0 is down and not part of a bridge!
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi there-

perhaps I'm missing something obvious, but the subject summerizes what
I get everytime when I try the following:

eth0 is up and running, as bought up by booting.

$ ifconfig eth0 down
$ brctl show
-> empty list, no bridges
$ brctl addbr br0
$ brctl show
-> shows br0, no enslaved devices
$ brctl addif br0 eth0
-> Device eth0 is already a member of a bridge: can't enslave it to bridge br0.
$ brctl addif br0 tap0
-> ok
$ brctl show
-> lists br0, with tap0 as interface

What am I doing wrong?

Or is this not the expected behaviour- and if not, any suggestions for
how to fix it?

Note: I'm also getting kernel panics (see my previous post), but I've
found the above ordering at least doesn't take the system down.

Further note: eth0 is using the sis900 driver, loaded as a module.

Any help greatly appreciated- this is a real annoyance.

Thanks in advance-

Julian

