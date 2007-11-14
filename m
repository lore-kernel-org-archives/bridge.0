Date: Wed, 14 Nov 2007 12:39:42 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] NFS over bridged interface
Message-ID: <20071114123942.00c7278c@freepuppy.rosehill>
In-Reply-To: <473B180D.9000600@cs.wisc.edu>
References: <473B180D.9000600@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivek Shrivastava <viveks@cs.wisc.edu>
Cc: bridge@lists.linux-foundation.org

On Wed, 14 Nov 2007 09:45:17 -0600
Vivek Shrivastava <viveks@cs.wisc.edu> wrote:

> Hi,
>      I am running NFS over my soekris boxes, with eth0 as the primary 
> wired interface (that gets dhcp ip address from the server and loads the 
> entire NFS filesystem). Now I want to bridge traffic from (some traffic) 
> eth0 to eth1 (another interface). But as soon as I add eth0 to the 
> bridge, the box stops responding.  I have waited more than 30 sec (the 
> default bridging fwd delay), but still see no response. I am a new to 
> this community so I am not sure if this has been already discussed. Any 
> help will be greatly appreciated.
> 
> Thanks
> Vivek

You need to use dhcp on the bridge interface.

# brctl addbr br0
# ifconfig eth0 0.0.0.0    # mark up with no address
# ifconfig eth1 0.0.0.0
# brctl setfd br0 0        # turn off forwarding delay
# brctl addif br0 eth0 eth1
# dhclient br0


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
