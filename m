Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25B534091C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3DB6140739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1675275896; x=1675362296; bh=rdu/cSdrf95lHEkaUXGHj3bo8fqo
 VL5yH9BapQUMiuo=; b=CV7kgIE3AZZdHao+BNdk6vds8PWdGb3GcGOmZzU7IXG4
 MRbrZZesw1p98Ub/ppz8lTBdsxADyPJkU3A9oOBRlmSLnUYYEfawHosLNeGs3Vvt
 j4B92h9sAxP7TiHk+PTutosjwxnvfNEOmHLThojboAcyjXR/PMp5gTv4n/HbF2Jq
 ixgm+8poal0ku5r9xnqFLtZFDEMxMCzHVsTJLmrqmPPxnaVCL3WJr5Drpsqo6ysq
 VoAI/Zc8yXnKhBAWv+FKOW+a7rYlchL/I4Hq6+0/599vXq6rlD7ez8PQAsW/9nQZ
 qo0Sx2oLBor+Jo8j9S37B16eohf7/INduBpNSUOUXQ==
Date: Wed, 1 Feb 2023 20:24:51 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <Y9qucziByvXsx5Q0@shredder>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-5-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130173429.3577450-5-netdev@kapio-technology.com>
Subject: Re: [Bridge] [PATCH net-next 4/5] net: bridge: ensure FDB offloaded
 flag is handled as needed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Mon, Jan 30, 2023 at 06:34:28PM +0100, Hans J. Schultz wrote:
> Since user added entries in the bridge FDB will get the BR_FDB_OFFLOADED
> flag set, we do not want the bridge to age those entries and we want the
> entries to be deleted in the bridge upon an SWITCHDEV_FDB_DEL_TO_BRIDGE
> event.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> ---
>  net/bridge/br_fdb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index e69a872bfc1d..b0c23a72bc76 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -537,6 +537,7 @@ void br_fdb_cleanup(struct work_struct *work)
>  		unsigned long this_timer = f->updated + delay;
>  
>  		if (test_bit(BR_FDB_STATIC, &f->flags) ||
> +		    test_bit(BR_FDB_OFFLOADED, &f->flags) ||
>  		    test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags)) {
>  			if (test_bit(BR_FDB_NOTIFY, &f->flags)) {
>  				if (time_after(this_timer, now))

Looks correct

> @@ -1465,7 +1466,9 @@ int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
>  	spin_lock_bh(&br->hash_lock);
>  
>  	fdb = br_fdb_find(br, addr, vid);
> -	if (fdb && test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
> +	if (fdb &&
> +	    (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags) ||
> +	     test_bit(BR_FDB_OFFLOADED, &fdb->flags)))

This also looks correct, but the function name is not really accurate
anymore. I guess you can keep it as-is unless someone has a better name

>  		fdb_delete(br, fdb, swdev_notify);
>  	else
>  		err = -ENOENT;
> -- 
> 2.34.1
> 
