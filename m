Message-ID: <fed120860807022323u5147beedn33960694ab4e05a5@mail.gmail.com>
Date: Thu, 3 Jul 2008 11:53:06 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <20080702230917.GD21344@linux-wlan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080702230917.GD21344@linux-wlan.com>
Subject: Re: [Bridge] [patch] rstpd crashes with GARP/GMRP packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Solomon Peachy <solomon@linux-wlan.com>
Cc: bridge@lists.linux-foundation.org

This looks like the earlier patch, for NETLINK size fixes. Could you
resend the intended patch. Thanks.

On Thu, Jul 3, 2008 at 4:39 AM, Solomon Peachy <solomon@linux-wlan.com> wrote:
> The attached patch, against Shrinivas's May 7, 2008 snapshot, fixes a
> null pointer dereference that occurs when we receive a packet from the
> brige interface that bears the STP MACADDR, but is *not* a STP packet.
>
> Specifically, I was receiving GMRP packets (see 802.1D-2004 10.1) from a
> 3Com switch.
>
> I don't know what we should do with these -- but crashing isn't it.  I
> can send over a packet dump and more debugging info if desired.

Looks like we aren't validating the BPDU as we should be. Please send
any debugging information you have.
