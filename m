Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=qkTwC9RHyJqrmoAfrbOb6ki372Psl71SqTKQZODWNrE=;
	b=OA/m/BEALPi32P33HjRo1nL/4zDzUge/tvLzC2hptQIWdnvD7uNdv92W1JfsWc/c0C
	D0ZZn8+she2edCvB99WSww7g+MlZVpMiiMuZ9wxnTcFIok/Ef5LlqH7SW8wpy720cM+X
	FP28G7AZGQCZRhWJXISpOmpYP3AQ7fnKK7lfX40eh6kGt8SvCzlmECC5fyWeQVO+9eYn
	eOpUchORHvBouLn53zUuSjSRy7xlrHMuiqaYJLYk0eusa12yWp+3qQtqe8XE8CedR16M
	N3mb6ubJ5S5a3Oc0xW3SWMHB/hSd3GShDY1cOHp43JiwrnoEmhgW1MCN+8rlNWDaXtJy
	S4WQ==
Date: Fri, 20 Jul 2018 09:02:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180720090259.751a82f4@xeon-e3>
In-Reply-To: <20180720144826.29892-3-nikolay@cumulusnetworks.com>
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
	<20180720144826.29892-3-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/2] net: bridge: add support for
	backup port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

On Fri, 20 Jul 2018 17:48:26 +0300
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> This patch adds a new port attribute - IFLA_BRPORT_BACKUP_PORT, which
> allows to set a backup port to be used for known unicast traffic if the
> port has gone carrier down. The backup pointer is rcu protected and set
> only under RTNL, a counter is maintained so when deleting a port we know
> how many other ports reference it as a backup and we remove it from all.
> Also the pointer is in the first cache line which is hot at the time of
> the check and thus in the common case we only add one more test.
> The backup port will be used only for the non-flooding case since
> it's a part of the bridge and the flooded packets will be forwarded to it
> anyway. To remove the forwarding just send a 0/non-existing backup port.
> This is used to avoid numerous scalability problems when using MLAG most
> notably if we have thousands of fdbs one would need to change all of them
> on port carrier going down which takes too long and causes a storm of fdb
> notifications (and again when the port comes back up). In a Multi-chassis
> Link Aggregation setup usually hosts are connected to two different
> switches which act as a single logical switch. Those switches usually have
> a control and backup link between them called peerlink which might be used
> for communication in case a host loses connectivity to one of them.
> We need a fast way to failover in case a host port goes down and currently
> none of the solutions (like bond) cannot fulfill the requirements because
> the participating ports are actually the "master" devices and must have the
> same peerlink as their backup interface and at the same time all of them
> must participate in the bridge device. As Roopa noted it's normal practice
> in routing called fast re-route where a precalculated backup path is used
> when the main one is down.
> Another use case of this is with EVPN, having a single vxlan device which
> is backup of every port. Due to the nature of master devices it's not
> currently possible to use one device as a backup for many and still have
> all of them participate in the bridge (which is master itself).
> More detailed information about MLAG is available at the link below.
> https://docs.cumulusnetworks.com/display/DOCS/Multi-Chassis+Link+Aggregation+-+MLAG
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Trying to understand this.

Is it the case that what you are trying to solve is the way MLAG
and bridging interact on the Linux side or more a limitation of how
switches operate?  Wouldn't this work?
                             
		br0 -- team0 -- eth1
                             +- eth2

The bridge would only have fdb entries for the team device.
Why do eth1 and eth2 have to be master devices?  Why would eth1
and eth2 need to be bridge ports.

This kind of thing in the bridge is most likely inevitable, and
I am guilty of introducing same logic into Hyper-V driver.
But still getting pushback that the multi device model is better.



