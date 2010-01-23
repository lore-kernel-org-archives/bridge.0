MIME-Version: 1.0
Date: Sat, 23 Jan 2010 16:38:48 +0200
Message-ID: <549992e51001230638t1e8389c9l2ba5864932a3872b@mail.gmail.com>
From: Metuki Sabhe <sabhe.metuki@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

When I add interfaces to the bridge *after* I have "tcpdump -n -i br0"
running on the bridge,
my tcpdump don't see any communication. If I kill tcpdump and
re-execute it *after* I added
the interface to the bridge, it works just fine.

The same behavior happens with my DHCP server (which listens only on
my bridge interface);
I need to re-execute (reset) it after I add the interface to the bridge.

Is that normal ?

Why does it happen ?

What should I do ?

It's a little awkward to reset my DHCP server every time I add a new
interface to the bridge..

Thanks,
Sabhe
