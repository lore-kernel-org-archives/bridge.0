Date: Fri, 14 Apr 2006 09:40:42 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060414094042.2a36d377@localhost.localdomain>
In-Reply-To: <20060414134220.25554.qmail@web52903.mail.yahoo.com>
References: <20060414134220.25554.qmail@web52903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: No UDP NFS over bridges in Linux 2.6.16.x?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Chris Rankin <rankincj@yahoo.com>
Cc: nfs@lists.sourceforge.net, bridge@osdl.org

On Fri, 14 Apr 2006 14:42:20 +0100 (BST)
Chris Rankin <rankincj@yahoo.com> wrote:

> Hi,
> 
> I have 2 servers which are connected to a gateway machine. The gateway and one server are running
> Linux 2.6.16.2, while the third machine is running 2.6.16.5. The two ethernet ports on the gateway
> which are connected to the servers are combined into a single ethernet bridge device.
> 
> Ever since 2.6.16, I have noticed that I can no longer cross-mount the two servers' /home
> directories via UDP NFS. Which is to say that the mount command succeeds, but that trying to
> access the filesystem makes the process hang and the "NFS server not responding" message to appear
> in the console log. This is true regardless of which machine is the NFS server and which is the
> NFS client.
> 
> It all works fine if I use TCP NFS instead.
> 
> Also, UDP NFS works OK between any server and the gateway itself, so it only goes wrong when UDP
> NFS traffic is forwarded across the bridge. (I have not changed my firewall rules, which just tell
> the gateway to forward all traffic coming in from the bridge device anyway.)
> 
> Can anyone reproduce this, please? I obviously have a workaround (using TCP instead of UDP) but it
> sounds like there's a bug somewhere.
> 
> Cheers,
> Chris

Most likely the problem is that the MTU on the two devices in the bridge is different.
The bridge will silently drop packets if they are too large for the destination port (it's in the 802.1d
standard). TCP has path mtu discovery and is smart enough to recover.  UDP doesn't do
that.

Anyway don't run NFS over UDP unless you want data corruption.  There are sequence number wraparound
issues that are unsolvable when running NFS over UDP/IP and faster links.
