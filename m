Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602176973;
 bh=l3Ku9JFIHQGNe0VmKNt0x5IrBgG8HLewr8rKBi37cFA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=us34OUj79l3vj0g6GntnxnAc/JnhYXjlKlCCHYk/D8Fd2wXCH29OoxZCm67gfIWKL
 WRiTnSbVKDZLzK2S7saP5yoTLDfb/XgpWdjQNOdNRtnFRJbyAejW6z+Byp9KkCiBLo
 KVp2ZFKKpDGKBhaxut9BgvTMpHBNQFbNDopTC8jA=
Date: Thu, 8 Oct 2020 10:09:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201008100930.1e5fca41@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <585c251204d3c09150e9fcb60f560c599567688a.camel@nvidia.com>
References: <20201007120700.2152699-1-henrik.bjoernlund@microchip.com>
 <32183f25a3d7ee8c148db42fbed9dd2a6e0a1f92.camel@nvidia.com>
 <585c251204d3c09150e9fcb60f560c599567688a.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Netlink interface fix.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: "  <linux-kernel@vger.kernel.org>, "@osuosl.org, "  <netdev@vger.kernel.org>, "@osuosl.org, netdev@vger.kernel.org, " <horatiu.vultur@microchip.com>"@osuosl.org, "bridge@lists.linux-foundation.org\" <bridge@lists.linux-foundation.org>,
 "@osuosl.org, linux-kernel@vger.kernel.org, "  <davem@davemloft.net>,
 "@osuosl.org, "  <henrik.bjoernlund@microchip.com>, "@osuosl.org, "  <UNGLinuxDriver@microchip.com>, Roopa Prabhu <roopa@nvidia.com>,
 "@osuosl.org, henrik.bjoernlund@microchip.com, UNGLinuxDriver@microchip.com, horatiu.vultur@microchip.com, davem@davemloft.net

On Thu, 8 Oct 2020 10:18:09 +0000 Nikolay Aleksandrov wrote:
> On Wed, 2020-10-07 at 14:49 +0000, Nikolay Aleksandrov wrote:
> > On Wed, 2020-10-07 at 12:07 +0000, Henrik Bjoernlund wrote:  
> > > This commit is correcting NETLINK br_fill_ifinfo() to be able to
> > > handle 'filter_mask' with multiple flags asserted.
> > > 
> > > Fixes: 36a8e8e265420 ("bridge: Extend br_fill_ifinfo to return MPR status")
> > > 
> > > Signed-off-by: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
> > > Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > > Suggested-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> > > Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > > ---
> > >  net/bridge/br_netlink.c | 26 +++++++++++---------------
> > >  1 file changed, 11 insertions(+), 15 deletions(-)
> > >   
> > 
> > The patch looks good, please don't separate the Fixes tag from the others.
> > Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> >   
> 
> TBH, this does change a user facing api (the attribute nesting), but I think
> in this case it's acceptable due to the format being wrong and MRP being new, so
> I doubt anyone is yet dumping it mixed with vlan filter_mask and checking for
> two identical attributes, i.e. in the old/broken case parsing the attributes
> into a table would hide one of them and you'd have to walk over all attributes
> to catch that.

To be clear - this changes the uAPI as far as 5.9-rcs are concerned. 
So if this change was to hit 5.9 final there would be no uAPI breakage,
right?
