Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 181A0815AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3848F81585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=631yiMfd/HSHyv7vF2uoZkf1bP44ApXazpR4vBm2RS0=;
 b=FK/6LiCca2iJVfpTUna4Ww6HscuDHHrb0lOds2yd33X2MBsF/BH4Wc7PQPwBisKShr
 I8VO/kU7HFssvgkbvUFCoXm30lO5msX4+rqYLDj2cXu0JkkUAkeiQRwMMku4NIghMpcS
 hOeh//p3hVDZjrvjYfNpHaHPoAm8cZcyqvU1z9pBJZwIp5LiZZEwRNdmW8WW55CFfERJ
 Y59m8Okr/Frg4EZTfmRVIGSDG/WtE3fyX1FMz+wB3gZqdxyw7xY6LdWd2xSiK4TtvlcX
 WEZ/CoYq6TBFB4nwbO275ChseLUfZS+m3sMIpeDHIJ5K31xg8xXQBRrXiGRvSNTSYezb
 d9nA==
Date: Mon, 9 Jan 2023 12:02:36 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230109100236.euq7iaaorqxrun7u@skbuf>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-2-tobias@waldekranz.com>
 <Y7vK4T18pOZ9KAKE@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7vK4T18pOZ9KAKE@shredder>
Subject: Re: [Bridge] [PATCH v5 net-next 01/15] net: bridge: mst: Multiple
 Spanning Tree (MST) mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org, Tobias Waldekranz <tobias@waldekranz.com>

Hi Ido,

On Mon, Jan 09, 2023 at 10:05:53AM +0200, Ido Schimmel wrote:
> > +	if (on)
> > +		static_branch_enable(&br_mst_used);
> > +	else
> > +		static_branch_disable(&br_mst_used);
> 
> Hi,
> 
> I'm not actually using MST, but I ran into this code and was wondering
> if the static key usage is correct. The static key is global (not
> per-bridge), so what happens when two bridges have MST enabled and then
> it is disabled on one? I believe it would be disabled for both. If so,
> maybe use static_branch_inc() / static_branch_dec() instead?

Sounds about right. FWIW, br_switchdev_tx_fwd_offload does use
static_branch_inc() / static_branch_dec().
