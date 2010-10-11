From: Aijaz Baig <aijazbaig1@gmail.com>
Date: Mon, 11 Oct 2010 13:29:13 +0000 (UTC)
Message-ID: <loom.20101011T131053-288@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] About local delivery of bridged packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

Hello,

I am trying to understand how does the bridging code determine if the packet is 
to be delivered locally or is it to be forwarded. Before being delivered 
locally, I mean the packet is to be delivered either to br0 or to a non enslaved 
interface. If I am wrong here, please do correct me.

The decision whether to pass the frame up or to forward the frame (or flood it 
if the bridge doesnt know where a given dest address resides) seems to be 
dependent on whether the entry corresponding to the frame is a local entry or if 
the destination address is a multicast address. fdb insert, if it finds an 
existing entry, which is not local, deletes it and creates an entry such that 
the 'is_local' flag is set. I do not understand this logic.

But on investigating it looks like the 'is_local' flag in the 
net_bridge_fdb_entry is set by fdb_insert() indirectly via fdb_create(). 
fdb_insert() is called from br_fdb_insert()  which is inturn called from 
br_add_if when an interface is being added to the bridge. br_add_if() is called 
from add_del_if() which is in turn called from br_dev_ioctl() in case of the new 
brctl interface. Now the signature of this function is like so:

int br_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);

It looks like the 'dev' above is the net_device structure corresponding to the 
bridge br0, the cmd in case of adding or removing an interface is SIOCBRADDIF or 
SIOCBRDELIF and when add_del_if is called from br_dev_ioctl() , it is done like 
so:

add_del_if(br, rq->ifr_ifindex, cmd == SIOCBRADDIF);

Thus the second argument I suppose is the interface index for the bridge. Now 
from within add_del_if(), we obtain the dev, of type net_device again, using:

dev = dev_get_by_index(&init_net, ifindex);

br_add_if is finally called as in:

br_add_if(br,dev);

we are passing the net_bridge structure along with the net_device structure 
corresponding to the interface which we want to be enslaved. Now br_fdb_insert() 
is called from within like so:

err = br_fdb_insert(br, p, dev->dev_addr); where p is the newly allocated net 
bridge port. Thus it looks like the address that we are adding here, i.e. the 
third argument of this function is the address of the interface being enslaved. 
However, we usually do not assign any address to the enslaved interface as a 
standard practice isnt it? We usually assign br0 an address which is usually 
used for administrative purposes. So If I assign an address to br0, how does 
that get added to the fdb? And secondly how does it know that its a local 
address?

Im a little confused by the code here. Please enlighten me about it


