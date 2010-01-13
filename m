Date: Tue, 12 Jan 2010 16:40:53 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20100112164053.2447c8f2@nehalam>
In-Reply-To: <20100112220448.GF23219@kallisti.us>
References: <20100112213223.GD23219@kallisti.us>
	<001485f790a4c2633c047cfe80e0@google.com>
	<20100112220448.GF23219@kallisti.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge]
 =?utf-8?b?UmXCoDpSZTogUmXCoDpSZTogQnJpZGdpbmcgTEFDUCAo?=
 =?utf-8?q?802=2E3ad=29_frames_not=09working?=
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ross Vandegrift <ross@kallisti.us>
Cc: bridge@lists.linux-foundation.org

On Tue, 12 Jan 2010 17:04:48 -0500
Ross Vandegrift <ross@kallisti.us> wrote:

> On Tue, Jan 12, 2010 at 09:40:30PM +0000, jhautbois@gmail.com wrote:
> > This is exactly the problem.
> > But, sounds like it is not possible... ?
> 
> You could run a custom version of the bridge driver to enable bridging
> of frames sent to the bridge-management MAC addresses.  Some folks
> have talked about doing similar things to enable bridging of STP.
> 
> Doing that with STP makes a bit more sense to me (since there are
> valid networks that could be constructed that way).  But you'll be
> breaking a pretty fundamental assumption of LACP....

Recent kernels will forward link local frames as long as STP is disabled.
Older kernels will not.

The assumption is that if STP is enabled, then it will be managing
control plane.

Author: Stephen Hemminger <shemminger@vyatta.com>  2009-05-14 23:10:13
Committer: David S. Miller <davem@davemloft.net>  2009-05-17 21:12:54
Parent: 43aa1920117801fe9ae3d1fad886b62511e09bee (bridge: handle process all link-local frames)
Branches: master, remotes/origin/master
Follows: v2.6.30-rc6
Precedes: v2.6.30-rc7

    bridge: relay bridge multicast pkgs if !STP
    
    Currently the bridge catches all STP packets; even if STP is turned
    off.  This prevents other systems (which do have STP turned on)
    from being able to detect loops in the network.
    
    With this patch, if STP is off, then any packet sent to the STP
    multicast group address is forwarded to all ports.
    
    Based on earlier patch by Joakim Tjernlund with changes
    to go through forwarding (not local chain), and optimization
    that only last octet needs to be checked.
    
    Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>


-- 
