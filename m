MIME-Version: 1.0
Sender: baringforge@gmail.com
From: Thomas Taranowski <tom@baringforge.com>
Date: Mon, 18 Oct 2010 19:16:18 -0700
Message-ID: <AANLkTikRJVdCG=HD45cgjkFzK6H3i+WPyKMHz28+mXSb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] Giving enslaved interface an IP?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I have bridged eth0 and eth1, where eth0 is the world, and eth1 has
some locally administered targets with normal IPs.  On eth1, I also
have some other devices with 192.168.x.x addresses I locally assigned.
 I'd like to give my eth1 a 192.168.x.x address, and treat the
192.168.x.x network as something like a local network, where anything
else get's bridged across to eth0.  I'm running into some problems.

First, when I try to ping anything on the 192.168.x.x network, it
get's sent out the wrong interface ( eth0 ), rather than eth1.  I
expected the bridge to broadcast the arp request to both interfaces.

Second, giving eth1 an ip address, in addition to being bridged, had
no obvious effect.  Can I even do this?

Any suggestions on where to look for additional information on this,
or things to try?

Thanks,
Tom
