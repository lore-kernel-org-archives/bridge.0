Return-Path: <idosch@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y/lUHn2lmGilcKpcDJIAk/rbRuVKze658djjynYfv0=;
 b=dAJItVkhAb1Rp5+EgFzpS7EQIdG5AJHy9SpsJvb8OVVWOJHOhILcky0f54DKFge1N0A0EBVsRRqW5dthOXkQI5v8Vxwi3P3ls0xDZ0iua1W4cU/ebazdocvBKO0qQ1IOCFc06F6kb44w+BZ3XlradE58SMHPtFAK+thKmgus4pByU/+2HKM0F41Yjq/lN4t+QAKHdHPlxdnhJfWkWnrsAo3wm2TVhqh0l5Z2Nvq/ghuPQnO6f6mShl+Uq1zylD+PeO8MuVg8iNr/zGy81PjhT4SumQYDwG2qa1WPZGP9qW1DFmrTx5vgzTTLRFSwG4GZxxd/+cn5Okp0Neli4K4BMA==
Date: Fri, 13 May 2022 15:47:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Yn5TWIZPBVLFipVD@shredder>
References: <20220505225904.342388-1-andrew@lunn.ch>
 <20220506143644.mzfffht44t3glwci@skbuf> <Ynd213m/0uXfjArm@shredder>
 <Yn1wK78zKzcgzg15@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn1wK78zKzcgzg15@lunn.ch>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH RFC] net: bridge: Clear offload_fwd_mark when
 passing frame up bridge interface.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ido Schimmel <idosch@mellanox.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Nikolay Aleksandrov <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, netdev <netdev@vger.kernel.org>

On Thu, May 12, 2022 at 10:38:03PM +0200, Andrew Lunn wrote:
> > I like Andrew's patch because it is the Rx equivalent of
> > br_switchdev_frame_unmark() in br_dev_xmit(). However, if we go with the
> > second option, it should allow us to remove the clearing of the mark in
> > the Tx path as the control block is cleared in the Tx path since commit
> > fd65e5a95d08 ("net: bridge: clear bridge's private skb space on xmit").
> > 
> > I don't know how far back Nik's patch was backported and I don't know
> > how far back Andrew's patch will be backported, so it might be best to
> > submit Andrew's patch to net as-is and then in net-next change
> > nbp_switchdev_allowed_egress() and remove br_switchdev_frame_unmark()
> > from both the Rx and Tx paths.
> > 
> > Anyway, I have applied this patch to our tree for testing. Will report
> > tomorrow in case there are any regressions.
> 
> Hi Ido
> 
> Did your testing find any issues?

No, patch is fine. Thanks!
