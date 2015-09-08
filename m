Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 8 Sep 2015 04:24:17 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150908022303.GA1562@odroid>
References: <55ED8723.9070501@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55ED8723.9070501@googlemail.com>
Subject: Re: [Bridge] net: Export IGMP/MLD message validation code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Powalowski <tobias.powalowski@googlemail.com>
Cc: bridge@lists.linux-foundation.org, davem@davemloft.net

Hi tpowa,

Thanks for your feedback.


On Mon, Sep 07, 2015 at 02:46:27PM +0200, Tobias Powalowski wrote:
> Hi,
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=9afd85c9e4552b276e2f4cfefd622bdeeffbbf26
> 
> This commit introduces a weird behaviour on my dlna server.

Did you experience this on the released 4.2 kernel or on a 4.2 release
candidate?

> This commit was merged into 4.2 series, which makes my dlna services
> disappear real soon after starting from discovering from other clients.
> Localhost seems not to be affected but every external discovery is broken.
> The dlna services run on a bridge device. Mythtv and Minidlna both
> disappear after some minutes of running.
> Git bisect shows first commit as reason, trying now a 4.2 with those 3
> patches reverted:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a516993f0ac1694673412eb2d16a091eafa77d2a
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=fcba67c94abe83e0e69a65737000ccbb16a4fa03
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=9afd85c9e4552b276e2f4cfefd622bdeeffbbf26
> 
> Do you need any more information to get this really weird bug fixed?

If you have this issue with the vanilla, released 4.2 kernel, then
a "tcpdump -i br0 'icmp6 or ip6 proto 0'" for about five minutes and
a "bridge mdb show" would be helpful.

Also which distros are the dlna server and dlna client running,
how are they connected?

> 
> Thanks in advance.
> 
> greetings
> tpowa

Cheers, Linus

> 
> -- 
> Tobias Powalowski
> Archlinux Developer & Package Maintainer (tpowa)
> http://www.archlinux.org
> tpowa@archlinux.org
> 
> 


