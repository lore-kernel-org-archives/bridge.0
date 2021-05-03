Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=YtUzOINInaYSLv1I0cAftRc5Acy9OQRqkK2xrgI5y9s=;
 b=elfQnWM43np1UUejnXyHYsWlgZtqbABCywcBfB6eKOjd2FoA7YKFDpjHVC//0Mn/x9
 d66MAXnKjW6y1NmRlxPKRqCsewvsZ4gOzewzrSW2BfGStMwtJ6Y0SOnZka67FJZQwhZy
 7f0E3xIcclfCFhKgOl5c10TmF1jTuhtmyNlLSgmULWOBIMAIzyajLQNhxv/TCiP+qpQb
 OFNB0hVYvZCfMz2qmCa2CQeWmpXk53R9CF8XLfUWMsAWUU0cnHVCXa40oUgJGbAUqOzf
 djdtVT7tCXl1KR4DzWMKnG8v3ZVHkA8Iu8tLScBfz5cfneXyLnvO7xe9uxGUH3Tkyrjo
 C9LA==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <YI6/li9hwHo8GfCm@shredder>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-5-tobias@waldekranz.com> <YI6/li9hwHo8GfCm@shredder>
Date: Mon, 03 May 2021 10:53:36 +0200
Message-ID: <87eeeonqpb.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [RFC net-next 4/9] net: bridge: switchdev: Forward
	offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, olteanv@gmail.com, davem@davemloft.net

On Sun, May 02, 2021 at 18:04, Ido Schimmel <idosch@idosch.org> wrote:
> On Mon, Apr 26, 2021 at 07:04:06PM +0200, Tobias Waldekranz wrote:
>> +static void nbp_switchdev_fwd_offload_add(struct net_bridge_port *p)
>> +{
>> +	void *priv;
>> +
>> +	if (!(p->dev->features & NETIF_F_HW_L2FW_DOFFLOAD))
>> +		return;
>> +
>> +	priv = p->dev->netdev_ops->ndo_dfwd_add_station(p->dev, p->br->dev);
>
> Some changes to team/bond/8021q will be needed in order to get this
> optimization to work when they are enslaved to the bridge instead of the
> front panel port itself?

Right you are. We should probably do something similar to the
switchdev_handle_port_* family of helpers that could be reused in
stacked devices. I will look at it for v1.

>> +	if (!IS_ERR_OR_NULL(priv))
>> +		p->accel_priv = priv;
>> +}
>> +
>> +static void nbp_switchdev_fwd_offload_del(struct net_bridge_port *p)
>> +{
>> +	if (!p->accel_priv)
>> +		return;
>> +
>> +	p->dev->netdev_ops->ndo_dfwd_del_station(p->dev, p->accel_priv);
>> +	p->accel_priv = NULL;
>> +}
