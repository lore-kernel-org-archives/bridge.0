Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 920B0611B2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E32C611AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypH0wU6QclFYBuhW2TN6EYBuEnG7oDhub2+5WBGfPVw=;
 b=oo3MxPnk6P/oPTtV39VB4rZcPURXbQ2HO6HFJlMcVAz0o0rjRwHXDVJhjMosVC1J0a3oEfTQyNCwed663GXWY2uCNCAwmsPG6yxqHW6PR70ksQrcE7ZZwe+YEdqzHhucdMBGfawpqS9A5CcLt0vzm5L11jVjCe/7RJ6/e9N4dtI=
Date: Fri, 19 May 2023 13:27:56 +0200
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <ZGddPLS4LM1LJYgc@corigine.com>
References: <20230518113328.1952135-1-idosch@nvidia.com>
 <20230518113328.1952135-3-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518113328.1952135-3-idosch@nvidia.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 2/5] net/sched: flower: Allow matching
 on layer 2 miss
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com, xiyou.wangcong@gmail.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On Thu, May 18, 2023 at 02:33:25PM +0300, Ido Schimmel wrote:
> Add the 'TCA_FLOWER_L2_MISS' netlink attribute that allows user space to
> match on packets that encountered a layer 2 miss. The miss indication is
> set as metadata in the skb by the bridge driver upon FDB/MDB lookup
> miss.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Hi Ido,

these changes look good to me.

If I was doing this I would split the flow_dissector and cls_flower
changes into separate patches: they are different, though related, things.
But I don't feel strongly about that.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
