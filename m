Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
 bh=z4leNzWR0o9Do22EpCpfCpRtm41HhzuAfaYRCquNCR0=;
 b=MCsW6wEKTxnKAuSRQO8c9OUoSTbZEBU5HojfvG84uvdpK1ANEYTa542H6s1mjmnJHn
 q9ervHHEO0uI6GLw8vV2XJq40dLAaPQO37MRMXJ5fYhoVQlZ9ZRM2O2lLj+wYeUaCNzz
 +QgiJ7DiPKuqFUOkkPNyPdKncBRC4gNPpxDqsEYT+hTS+h97HF/HNWZS8eq4nsaXk3DQ
 VzJlHjCOA2g9zalXA8yuqZRfqPndj7f9lMg1obaho6juf4TjgkbSt57qTSycTQFJjQf8
 yfAD3zCXL3vKLBPpxttr1ENT46a/sX4ObuMlXolAvBzTIEOZRqmt+Y4llaicDp+2k2fi
 DTcQ==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <32bf6a72-6aff-5e36-fb02-333f3c450f49@nvidia.com>
References: <20210112135903.3730765-1-horatiu.vultur@microchip.com>
 <32bf6a72-6aff-5e36-fb02-333f3c450f49@nvidia.com>
Date: Sat, 16 Jan 2021 16:39:24 +0100
Message-ID: <8735z0zyab.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [RFC PATCH v2] net: bridge: igmp: Extend IGMP query to
	be per vlan
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, allan.nielsen@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org

On Wed, Jan 13, 2021 at 14:15, Nikolay Aleksandrov <nikolay@nvidia.com> wrote:
> On 12/01/2021 15:59, Horatiu Vultur wrote:
>> Based on the comments of the previous version, we started to work on a
>> new version, so it would be possible to enable/disable queries per vlan.
>> [snip]
>> We were wondering if this what you had in mind when you proposed to have
>> this per vlan? Or we are completely off? Or we should fix some of the
>> issues that I mentioned, before you can see more clearly the direction?
> No, unfortunately not even close. We already have per-port per-vlan and global per-vlan
> contexts which are also linked together for each vlan, those must be used for any vlan
> configuration and state. The problem is that you'd have to mix igmp and vlan code and
> those two live under two different kconfig options, and worse rely on different locks, so
> extra care must be taken.
> [snip]
> If you don't need this asap, I'll probably get to it in two months
> after EHT and the new bridge flush api, even we are still carrying an out-of-tree patch
> for this which someone (not from cumulus) tried to upstream a few years back, but it also has
> wrong design in general. :)

Hi,

very interesting thread this!  I believe I may be the one who posted the
patch[1] a few years ago, and I fully agree with Nik here.  We developed
the basic concepts further at Westermo, but it's been really difficult
to get it stable.

We have discussed at length at work if an IGMP snooping implementation
really belongs in the bridge, or if it's better suited as a user space
daemon?  Similar to what was decided for RSTP/MSTP support, i.e., the
bridge only has STP and RSTP/MSTP is handled by mstpd[2].

Most of what's required for a user space implementation is available,
but it would've been nice if a single AF_PACKET socket on br0 could be
used to catch what brport (ifindex) a query or report comes in on.  As
it is now that information is lost/replaced with the ifindex of br0.
And then there's the issue of detecting and forwarding to a multicast
routing daemon on top of br0.  That br0 is not a brport in the MDB, or
that host_joined cannot be set/seen with iproute2 is quite limiting.
These issues can of course be addressed, but are they of interest to
the community at large?


Best regards
 /Joachim

[1]: https://lore.kernel.org/netdev/20180418120713.GA10742@troglobit/
[2]: https://github.com/mstpd/mstpd
