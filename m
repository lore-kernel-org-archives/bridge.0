Date: Thu, 3 Aug 2006 09:05:11 +1000
From: David McCullough <david_mccullough@au.securecomputing.com>
Message-ID: <20060802230511.GA3547@beast>
References: <44C77FD2.2030208@seskion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C77FD2.2030208@seskion.de>
Sender: David McCullough <davidm@snapgear.com>
Subject: Re: [Bridge] [uClinux-dev] Is bridgeing possible with kernel 2.6.10
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: uClinux development list <uclinux-dev@uclinux.org>
Cc: bridge@lists.osdl.org


Jivin Juergen Pfeiffer lays it down ...
> Hi
> 
> I didn't get bridgeing to work with Linux kernel 2.6.10 (coldfire 5485) 
> yet. When i try to configure bridgeing
> with "brctl", everything seems to be ok, but i if i try to ping through 
> my bridge, i see ARP-Request arriving on the other side, but the
> ARP-Responses do not go back through the bridge.
> Now i could read in 
> "http://www.tldp.org/HOWTO/Ethernet-Bridge-netfilter-HOWTO-2.html#ss2.1"
> that "Use of kernel 2.6 is not yet a good idea".
> So do i have a change to get it working?

One of the guys here has been testing bridging with 2.6.17 from the
uClinux-dist and it is working fine.  Probably can't offer you much more
than that though,

Cheers,
Davidm

-- 
David McCullough,  david_mccullough@securecomputing.com,   Ph:+61 734352815
Secure Computing - SnapGear  http://www.uCdot.org http://www.cyberguard.com
