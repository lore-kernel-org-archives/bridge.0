Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9AE760C08
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2523F60BF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1675444017; x=1675530417; bh=VxXJxYIPXv5W1b2DuSTnG3h266yM
 n84BrwVZXf0OoBE=; b=FF9EwHkwa0Zr/2YgDkYkO260VoVYDFPfdSKIw0xooXry
 POePgsM/c0pJ4275GEWJCj5+R2viqbMMxLWnlJu7PBFfP+p7nqWnlkpI/JyIjgvM
 0BAsN2x3u8KEWhaQamirT/bZGqOUc9Nb+IqdFHay0v1VtPhb9WsAOFzZFHYpVPrm
 ufNgPrK42fo31lVBnNYqODjPWWfxPTXWmqxspIX5OMPa881YYqPx5SwBssMYh/dr
 XEWjfg+V220WXBlFZieLX5wZXmaOuVXePunwWkPm9XjwDVAEM7DaivKJcFH7ZjCG
 y4VHyCoLJu/hMY3gfpYyjmH6ADsgspjUeC/1GampaQ==
Date: Fri, 3 Feb 2023 19:06:51 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <Y90/K8BPHijxFZci@shredder>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-2-netdev@kapio-technology.com>
 <Y9qrAup9Xt/ZDEG0@shredder>
 <f27dd18d9d0b7ff8b693af8a58ea8616@kapio-technology.com>
 <Y9vgz4x/O+dIp+0/@shredder>
 <766efaf94fcb6362c5ceb176ad7955f1@kapio-technology.com>
 <Y90y9u+4PxWk4b9E@shredder>
 <4188a35c3c260d8ea2b5f8b2ac0ae6b2@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4188a35c3c260d8ea2b5f8b2ac0ae6b2@kapio-technology.com>
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

On Fri, Feb 03, 2023 at 05:27:43PM +0100, netdev@kapio-technology.com wrote:
> On 2023-02-03 17:14, Ido Schimmel wrote:
> > 
> > OK, so can't this hunk:
> > 
> > ```
> > 	if (fdb_info->is_dyn)
> > 		fdb_flags |= DSA_FDB_FLAG_DYNAMIC;
> > ```
> > 
> > Become:
> > 
> > ```
> > 	if (fdb_info->is_dyn && !fdb_info->added_by_user)
> > 		fdb_flags |= DSA_FDB_FLAG_DYNAMIC;
> > ```
> > 
> > ?
> > 
> > Then there is no need to fold 'added_by_user' into 'is_dyn' in the
> > bridge driver. I *think* this is the change Vladimir asked you to do.
> 
> I suppose you mean?:
>  	if (fdb_info->is_dyn && fdb_info->added_by_user)
>  		fdb_flags |= DSA_FDB_FLAG_DYNAMIC;

Yes
