Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2131E60F3A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49C6860E84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=diC8NAGcMEsNdERayclB3yX1bYh/brVTx+qg6EEm8xY=;
 b=QuCjTmmNppPf/d2WZbw804dsVjsBi340rAtZVZBKAdL56fNNBr1wJsqU6uehAaZ4uG
 ZtNSVVp1WySs2XoXeGLLjrLOQ2/UPjvVqzt0nE48zKk/lEn51q5YwoeNTyaWjDpCr4ro
 rEEtRW/plhq9pEAd5d282djUJQcff2x5nnmiZL8ObV7Ftlxj+u9V6Wmmc+rPu+HC554S
 SQXQ+C4Di/dR0DgOjpgfOvcamTaZ4UxeBHSLnN9nSGPv+aGxbp4wL2HNetoY+mkGHl37
 SRiV4Enc2XcTkoX3a2qs0/CNN4LPYg+jxr7LHk0ksefOcZ8x4woYWzX95F6ix3YkfteB
 z52g==
Date: Fri, 21 Oct 2022 19:30:05 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221021163005.xljk2j3fkikr6uge@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221020132538.reirrskemcjwih2m@skbuf>
 <2565c09bb95d69142522c3c3bcaa599e@kapio-technology.com>
 <20221020225719.l5iw6vndmm7gvjo3@skbuf>
 <82d23b100b8d2c9e4647b8a134d5cbbf@kapio-technology.com>
 <20221021112216.6bw6sjrieh2znlti@skbuf>
 <7bfaae46b1913fe81654a4cd257d98b1@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bfaae46b1913fe81654a4cd257d98b1@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v8 net-next 10/12] net: dsa: mv88e6xxx:
 mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Fri, Oct 21, 2022 at 03:16:21PM +0200, netdev@kapio-technology.com wrote:
> As it is now in the bridge, the locked port part is handled before learning
> in the ingress data path, so with BR_LEARNING and BR_PORT_LOCKED, I think it
> will work as it does now except link local packages.

If link-local learning is enabled on a locked port, I think those
addresses should also be learned with the BR_FDB_LOCKED flag. The
creation of those locked FDB entries can be further suppressed by the
BROPT_NO_LL_LEARN flag.

> If your suggestion of BR_LEARNING causing BR_FDB_LOCKED on a locked port, I
> guess it would be implemented under br_fdb_update() and BR_LEARNING +
> BR_PORT_LOCKED would go together, forcing BR_LEARNING in this case, thus also
> for all drivers?

Yes, basically where this is placed right now (in br_handle_frame_finish):

	if (p->flags & BR_PORT_LOCKED) {
		struct net_bridge_fdb_entry *fdb_src =
			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);

		if (!fdb_src) {
			unsigned long flags = 0;

			if (p->flags & BR_PORT_MAB) {
			   ~~~~~~~~~~~~~~~~~~~~~~~~
			   except check for BR_LEARNING

				__set_bit(BR_FDB_LOCKED, &flags);
				br_fdb_update(br, p, eth_hdr(skb)->h_source,
					      vid, flags);
			}
			goto drop;
		} else if (READ_ONCE(fdb_src->dst) != p ||
			   test_bit(BR_FDB_LOCAL, &fdb_src->flags) ||
			   test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
			goto drop;
		}
	}
