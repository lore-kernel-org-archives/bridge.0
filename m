Return-Path: <Horatiu.Vultur@microchip.com>
Date: Fri, 10 Jan 2020 21:24:55 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200110202455.vku455ioa7vaj4dn@soft-dev3.microsemi.net>
References: <20200109150640.532-1-horatiu.vultur@microchip.com>
 <6f1936e9-97e5-9502-f062-f2925c9652c9@cumulusnetworks.com>
 <20200110.112736.1849382588448237535.davem@davemloft.net>
 <3CD4F75F-C462-4CF2-B31A-C2E023D3F065@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <3CD4F75F-C462-4CF2-B31A-C2E023D3F065@cumulusnetworks.com>
Subject: Re: [Bridge] [RFC net-next Patch 0/3] net: bridge: mrp: Add support
 for Media Redundancy Protocol(MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: andrew@lunn.ch, jakub.kicinski@netronome.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vivien.didelot@gmail.com, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jiri@mellanox.com, jeffrey.t.kirsher@intel.com, dsahern@gmail.com, olteanv@gmail.com, David Miller <davem@davemloft.net>

> >With a userland implementation, what approach do you suggest for
> >DSA/switchdev offload
> >of this stuff?
> 
> Good question, there was no mention of that initially, or I missed it at least.
> There aren't many details about what/how will be offloaded right now.
> We need more information about what will be offloaded and how it will fit.
I think we should do a new version of the RFC-Patch with the hooks to
offload included. Just the signatures and the invocations should give
the context we are missing in the discussion.

Depending on how the discussion goes from there, we can then either work
on putting this in user-space or fix the issues pointed out in the
original attempt.

/Horatiu
