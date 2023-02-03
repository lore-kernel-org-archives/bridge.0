Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E4EA415B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 896D8402BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1675440893; x=1675527293; bh=ZsTfWTfG+sKlRejLobl9gKT+7jxs
 vBf1Pr6YqiH/tfc=; b=fpwVXDIw98vLEX4I2DHTFp1G2HYcxx39hLDAmQtzN3ej
 rM4DwBU7iCWaWBA56FL5KJiPqoSa2aKno4iZTyJEtpIlVpN2EQREF6y5bK7KLds3
 p+vw/kvvtH7VTMIV/EPGtNIDiRmcCW7NnRUliQcNZPIxDdEC3RNnsVH8K08hpGlT
 3uy9234605kg27fNMWtfgPZmo9+3cN6Rjtg5fBvNvVpiDm9lSmtz1E9Qbo3yXRGW
 shHNi1kLjWQr5RgxuQHzZBtu7f1uEVGhrQ+2AmB0UCfTo2sPjxBf4jpJ1VOemO8x
 X1h+myMj/y9VmgCW+mczgf1jAAsFCk6nh13/y8dyZw==
Date: Fri, 3 Feb 2023 18:14:46 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <Y90y9u+4PxWk4b9E@shredder>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-2-netdev@kapio-technology.com>
 <Y9qrAup9Xt/ZDEG0@shredder>
 <f27dd18d9d0b7ff8b693af8a58ea8616@kapio-technology.com>
 <Y9vgz4x/O+dIp+0/@shredder>
 <766efaf94fcb6362c5ceb176ad7955f1@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <766efaf94fcb6362c5ceb176ad7955f1@kapio-technology.com>
Subject: Re: [Bridge] [PATCH net-next 1/5] net: bridge: add dynamic flag to
 switchdev notifier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Thu, Feb 02, 2023 at 05:38:06PM +0100, netdev@kapio-technology.com wrote:
> On the first question please look here:
> https://lore.kernel.org/netdev/20230119134045.fqdt6zrna5x3iavt@skbuf/

It seems Vladimir also wants the new field to be named 'is_static'
instead of 'is_dyn'. In your reason you mention
'SWITCHDEV_FDB_ADD_TO_BRIDGE', but this is not the interesting case for
the field. This event is used for devices to notify the bridge on new
learned entries. The bridge marks them as "extern_learn" which means
that "dynamic" / "static" flags are irrelevant.

The interesting case for the new field is the bridge to device direction
('SWITCHDEV_FDB_ADD_TO_DEVICE'). Drivers need to be patched to take the
new field into account when deciding the policy to program the entry
with. They can do it just as well if you name the new field 'is_static'
instead of 'is_dyn'.

> On the second question it is what Oltean pointed out to me here...
> https://lore.kernel.org/netdev/20230118230135.szu6a7kvt2mjb3i5@skbuf/
> 
> Oltean says there:
> "This is not true, because it assumes that DSA never called port_fdb_add()
> up until now for bridge FDB entries with the BR_FDB_STATIC flag unset,
> which is incorrect (it did)."
> 
> Though as I see it, if it is only from the DSA layer on, the new is_dynamic
> flag would not be set anyway in the case he references. And as can be seen
> the change is in the bridge layer, as the rest is just propagating the flag,
> but it ensures that to set this flag that it comes from the user adding an
> FDB entry.

OK, so can't this hunk:

```
	if (fdb_info->is_dyn)
		fdb_flags |= DSA_FDB_FLAG_DYNAMIC;
```

Become:

```
	if (fdb_info->is_dyn && !fdb_info->added_by_user)
		fdb_flags |= DSA_FDB_FLAG_DYNAMIC;
```

?

Then there is no need to fold 'added_by_user' into 'is_dyn' in the
bridge driver. I *think* this is the change Vladimir asked you to do.
