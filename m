Date: Wed, 22 Apr 2009 17:18:42 +0300 (IDT)
From: Or Gerlitz <ogerlitz@voltaire.com>
In-Reply-To: <Pine.LNX.4.64.0904211307060.6460@zuben.voltaire.com>
Message-ID: <Pine.LNX.4.64.0904221715190.23152@zuben.voltaire.com>
References: <Pine.LNX.4.64.0904211307060.6460@zuben.voltaire.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Bridge] NIC unicast macs table manipulation by bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: bridge@lists.linux-foundation.org

On Tue, 21 Apr 2009, Or Gerlitz wrote:

> Using a Linux bridge I see that none of the interfaces is set to promiscuous mode

OKay, sorry for that. I was looking (2.6.29) on the output of /sbin/ifconfig
which is installed on my system through net-tools-1.60-73 - seems like it
ignores the IFF_PROMISC bit. Now, when looking on the device sysfs flags,
I see now the IFF_PROMISC (0x100) bit being set.

It turns out that this ifconfig is even more misleading, using
$ ifconfig eth1 promisc and later -promisc makes the output to show as now the
device is in the promiscuous state, and with -promisc as it doesn't - but in both
cases, the IFF_PROMISC bit setting done by the bridge remains steady
that is both interfaces connected to the bridge have the 0x1103 flags bit mask...

As for my other question - is there a method to display dev-&gt;uc_list
(e.g similar to /proc/net/dev_mcast)?

thanks,

Or.
