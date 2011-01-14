Message-ID: <4D2F958D.2010203@navigue.com>
Date: Thu, 13 Jan 2011 19:15:09 -0500
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Tagged/untagged and gretap bridging question.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Greetings list,

Assuming the following network setup of three locations linked by two
ethernet over gre (gretap) tunnels.

I am assuming that a broadcast on the local network, if it comes
untagged to eth0 will reach both network1 and network2 untagged.

My main question is about a broadcast happening in the tagged portion of
(local network).  Is there a chance for an ethernet broadcast in vlan 1
on the local network to reach remote network 2?  I'm thinking not, but
if I tcpdump an interface that has vlans enabled, I will see the tagged
packets on eth0.  As such I wonder if they will travel through br0 to
the remote locations as well, something I would rather avoid.

(local network)
|                                              (remote network 1)
| eth0.1 <--br1--> gre1.1                                       |
+-eth0   <--br0--> gre1-- (l3_to_host1) -- gre0 <--br0--> eth0-+
            |
            +----> gre2 -- (l3-to_host2) -- gre0 <--br0--> eth0-+
  eth0.2 <--br2--> gre2.2                                       |
                                               (remote network 2)

Of interest too is knowing if the tags will survive all the way to
remote networks or if I need to enable vlans on the remote gretap and
ethernet interfaces as well for them to work.

Alternatively, the setup would look like this:

(local network)
|                                              (remote network 1)
| eth0.1 <--br1--> gre1.1                                       |
| eth0.3 <--br0--> gre1-- (l3_to_host1) -- gre0 <--br0--> eth0-+
+-eth0
  eth0.4 <--br3-->gre2 -- (l3-to_host2) -- gre0 <--br0--> eth0-+
  eth0.2 <--br2--> gre2.2                                       |
                                               (remote network 2)

The goal being not to see any untagged frames coming out on the local
network from remote locations and instead having them appear in specific
local vlans.

So at the core of my questions really is this:  Will bridging the
untagged portion of an interface that has vlans enabled (eth0 when
eth0.x exists) let tagged frames go through to other members of the bridge?

Thanks for your collective wisdom,

Jonathan
