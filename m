Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0427A40192
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1766B41836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685423890;
 bh=TmcAKLb36S0mfPW5+98IjKrwm1yuWF74UnQr6qihhNo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SJAsnH5MKs8ERiYQlGGkUvq1av793AuCSQfI6cfI+K9+mffGwid+rQgxebgHnIz44
 fKnXg606WNs0yP064eYDHqRb40sBk3iZYgXgWXOXAg/GS7pGUC21rJtTTzGPaFolmr
 fC0Kf90kQvhzanjHAyd5Ar5HvUOBssX9ZB0JXf8Z4VfO8NH9d+TWSL27LA+49keLUE
 Q/4XOkKtI5nUacEXlA4Tpxg1i2bAziTtaamdORCy/jY6LKF4FCdoWmoEZZkifitVGd
 uBsXXlzdTIZ6hY2aSMXka1FG2U9RdSuMvlnIN5y/RQ4CZq7hXq28dqxRpbMXe1HG53
 gL1kn2u/8ntMA==
Date: Mon, 29 May 2023 22:18:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230529221808.360b04c6@kernel.org>
In-Reply-To: <20230529114835.372140-2-idosch@nvidia.com>
References: <20230529114835.372140-1-idosch@nvidia.com>
 <20230529114835.372140-2-idosch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 1/8] skbuff: bridge: Add layer 2
 miss indication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, leon@kernel.org, roopa@nvidia.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, vladimir.oltean@nxp.com, simon.horman@corigine.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On Mon, 29 May 2023 14:48:28 +0300 Ido Schimmel wrote:
> For EVPN non-DF (Designated Forwarder) filtering we need to be able to
> prevent decapsulated traffic from being flooded to a multi-homed host.
> Filtering of multicast and broadcast traffic can be achieved using the
> following flower filter:
> 
>  # tc filter add dev bond0 egress pref 1 proto all flower indev vxlan0 dst_mac 01:00:00:00:00:00/01:00:00:00:00:00 action drop
> 
> Unlike broadcast and multicast traffic, it is not currently possible to
> filter unknown unicast traffic. The classification into unknown unicast
> is performed by the bridge driver, but is not visible to other layers
> such as tc.
> 
> Solve this by adding a new 'l2_miss' bit to the tc skb extension. Clear
> the bit whenever a packet enters the bridge (received from a bridge port
> or transmitted via the bridge) and set it if the packet did not match an
> FDB or MDB entry. If there is no skb extension and the bit needs to be
> cleared, then do not allocate one as no extension is equivalent to the
> bit being cleared. The bit is not set for broadcast packets as they
> never perform a lookup and therefore never incur a miss.

Acked-by: Jakub Kicinski <kuba@kernel.org>
