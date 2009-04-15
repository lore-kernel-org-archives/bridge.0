Date: Wed, 15 Apr 2009 10:17:21 +0200
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090415081720.GA21342@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
Subject: [Bridge] [PATCH 0/3] bonding: allow bond in mode balance-alb to
	work	properly in bridge -try6
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, jgarzik@pobox.com, dada1@cosmosbay.com, davem@davemloft.net

(resend, rcu list locking, cometics)

Hi all.

The problem is described in following bugzilla:
https://bugzilla.redhat.com/show_bug.cgi?id=487763

Basically here's what's going on. In every mode, bonding interface uses the same
mac address for all enslaved devices (except fail_over_mac). Only balance-alb
will simultaneously use multiple MAC addresses across different slaves. When you
put this kind of bond device into a bridge it will only add one of mac adresses
into a hash list of mac addresses, say X. This mac address is marked as local.
But this bonding interface also has mac address Y. Now then packet arrives with
destination address Y, this address is not marked as local and the packed looks
like it needs to be forwarded. This packet is then lost which is wrong.

Notice that interfaces can be added and removed from bond while it is in bridge.

This patchset solves this issue in the best way it can be possibly solved. By
adding all mac addresses of all slave devices to the bridge hash list. To carry
these addresses the new list has to be introduced in struct net_device.

Jirka

