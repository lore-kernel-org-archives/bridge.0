Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5A8LBG/0winkhIB+qQknveTCUeenAgAerHH1NCQ2T74=;
 b=WqOZJMT5w2wzqQecct+baorFdZNCF95QdWg2USqadi60RgTMKQKmqz9oa827zluMxC
 dFROYainZKQ1g9Frxqi9Y3CU6kv687nGJ8H2v2/u7lZoGO/7Ve4FqordX6MU34srPqwJ
 UpWGnOJp/UopqTiIWaikBsozE1KTBAbNRPPffEAnfMPfFYWy+w5HjKUOHW/NGIiAnXsS
 4jbmSIf5SJg7bYOWos4A/FpkgfGzuNhy8SzoIyruJ6/ReMlKVI9Y89mFqYLpDAJPu85g
 Juhn02DKmGW1GewGDujDulfjEqR3Ijze5uXMth1bi6t5CPxee7RX7n2Br3wWA8+Uko8r
 gZvQ==
References: <20201213024018.772586-1-vladimir.oltean@nxp.com>
 <20201213024018.772586-5-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <972b7427-0efe-118b-5e11-88ea10c2d217@gmail.com>
Date: Sat, 12 Dec 2020 19:29:34 -0800
MIME-Version: 1.0
In-Reply-To: <20201213024018.772586-5-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 4/6] net: dsa: exit early in
 dsa_slave_switchdev_event if we can't program the FDB
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Tobias Waldekranz <tobias@waldekranz.com>



On 12/12/2020 6:40 PM, Vladimir Oltean wrote:
> Right now, the following would happen for a switch driver that does not
> implement .port_fdb_add or .port_fdb_del.
> 
> dsa_slave_switchdev_event returns NOTIFY_OK and schedules:
> -> dsa_slave_switchdev_event_work
>    -> dsa_port_fdb_add
>       -> dsa_port_notify(DSA_NOTIFIER_FDB_ADD)
>          -> dsa_switch_fdb_add
>             -> if (!ds->ops->port_fdb_add) return -EOPNOTSUPP;
>    -> an error is printed with dev_dbg, and
>       dsa_fdb_offload_notify(switchdev_work) is not called.
> 
> We can avoid scheduling the worker for nothing and say NOTIFY_OK.

Not sure if this comment is intended to describe what is being added,
only if you have to respin, should this be NOTIFY_DONE?

> Because we don't call dsa_fdb_offload_notify, the static FDB entry will
> remain just in the software bridge.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
