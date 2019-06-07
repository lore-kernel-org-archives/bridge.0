Return-Path: <christian@brauner.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brauner.io; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=lWF7Zmdzma5qVPiqq9W2CiXxJttkoC05tRBABgFXJ/M=;
	b=PCqTuNeZTb7yegrj934+38ehLd680JhdGBUMG3lzhHUpULWtsuAwvF6bT3SQJIzU60
	t4zlFyt0krRu56LktDzV90YaK3Hu3kxXhPZry3+YK67pYb6li8Gc1Dag7A32sDDBhOpi
	dSx579Jz6HSqhhIDYFXnu1hT+6//hQbtrb9alPKyjcgOegWjdYd5QoOi0cCzv7cTH8fR
	qIpqoUvTU4b74w/fBdcdj3NSV+9Beu4wHl2VcVyrxdBbehCvH5HP1MUcIElB/q36HTYx
	3Ub8fQG5OD1v1xEwbBa8CFE5twm6l2zzF9RaoYQgdZUNV6x4kqvTDJ8swChV0yIN5zEK
	MPeA==
Date: Fri, 7 Jun 2019 15:25:16 +0200
From: Christian Brauner <christian@brauner.io>
Message-ID: <20190607132516.q3zwmzrynvqo7mzn@brauner.io>
References: <20190606114142.15972-1-christian@brauner.io>
	<20190606114142.15972-2-christian@brauner.io>
	<20190606081440.61ea1c62@hermes.lan>
	<20190606151937.mdpalfk7urvv74ub@brauner.io>
	<20190606163035.x7rvqdwubxiai5t6@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190606163035.x7rvqdwubxiai5t6@salvia>
Subject: Re: [Bridge] [PATCH RESEND net-next 1/2] br_netfilter: add struct
	netns_brnf
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: ueberall@themenzentrisch.de, vapier@chromium.org, richardrose@google.com, bhthompson@google.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, joelhockey@chromium.org, tyhicks@canonical.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, smbarber@chromium.org, davem@davemloft.net

On Thu, Jun 06, 2019 at 06:30:35PM +0200, Pablo Neira Ayuso wrote:
> On Thu, Jun 06, 2019 at 05:19:39PM +0200, Christian Brauner wrote:
> > On Thu, Jun 06, 2019 at 08:14:40AM -0700, Stephen Hemminger wrote:
> > > On Thu,  6 Jun 2019 13:41:41 +0200
> > > Christian Brauner <christian@brauner.io> wrote:
> > > 
> > > > +struct netns_brnf {
> > > > +#ifdef CONFIG_SYSCTL
> > > > +	struct ctl_table_header *ctl_hdr;
> > > > +#endif
> > > > +
> > > > +	/* default value is 1 */
> > > > +	int call_iptables;
> > > > +	int call_ip6tables;
> > > > +	int call_arptables;
> > > > +
> > > > +	/* default value is 0 */
> > > > +	int filter_vlan_tagged;
> > > > +	int filter_pppoe_tagged;
> > > > +	int pass_vlan_indev;
> > > > +};
> > > 
> > > Do you really need to waste four bytes for each
> > > flag value. If you use a u8 that would work just as well.
> > 
> > I think we had discussed something like this but the problem why we
> > can't do this stems from how the sysctl-table stuff is implemented.
> > I distinctly remember that it couldn't be done with a flag due to that.
> 
> Could you define a pernet_operations object? I mean, define the id and size
> fields, then pass it to register_pernet_subsys() for registration.
> Similar to what we do in net/ipv4/netfilter/ipt_CLUSTER.c, see
> clusterip_net_ops and clusterip_pernet() for instance.

Hm, I don't think that would work. The sysctls for br_netfilter are
located in /proc/sys/net/bridge under /proc/sys/net which is tightly
integrated with the sysctls infrastructure for all of net/ and all the
folder underneath it including "core", "ipv4" and "ipv6".
I don't think creating and managing files manually in /proc/sys/net is
going to fly. It also doesn't seem very wise from a consistency and
complexity pov. I'm also not sure if this would work at all wrt to file
creation and reference counting if there are two different ways of
managing them in the same subfolder...
(clusterip creates files manually underneath /proc/net which probably is
the reason why it gets away with it.)

Christian
