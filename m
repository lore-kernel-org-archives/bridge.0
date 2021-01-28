Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PiWPUkYWirALNH3srwHMZyB8M+2z39u4PPSrRrniMj0=;
 b=X9Cz6XO/3EAt6MSawZAW8HJBYaEM3CpAF7LwXY/bUY7Xq5iE5bCtpKvVE81jnuRH6M
 YmF5wPFW0p3/cAq0kieYeXBKrHtHbWKU0VTuR8d1Ao39E4XAWb6defdNh7J81/3kuhdG
 lK8Lor1+q+VO4qcGqmPMVTbEOSj8lXw+t1ueLMTbkt3XWgmCVKSpjxLZS/x4fgccUokQ
 9qLVfvH+SlkxIU7EeJX0u0UvUVVZPMgVK6/pG0DhwOu0VryYdKhJE+dKl61nknpqywQm
 lTh8cBJm5bnEvfwAVQm92rwQjjxs3ObZD6n8sQpzQ+/VhovFNLwA0hJLkZ2itcWv7Hm1
 UpOA==
Date: Thu, 28 Jan 2021 11:27:26 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <20210128032726.GP1421720@Leo-laptop-t470s>
References: <20210126040949.3130937-1-liuhangbin@gmail.com>
 <8a34f089-204f-aeb1-afc7-26ccc06419eb@nvidia.com>
 <20210126132448.GN1421720@Leo-laptop-t470s>
 <90df4fe6-fcc5-f59a-c89c-6f596443af4d@nvidia.com>
 <0b5741b6-48c0-0c34-aed8-257f3e203ac5@nvidia.com>
 <20210127041521.GO1421720@Leo-laptop-t470s>
 <e22d0eea-4236-5916-cc42-532a3dfcc9dd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22d0eea-4236-5916-cc42-532a3dfcc9dd@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next] bridge: Propagate NETDEV_NOTIFY_PEERS
	notifier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Jarod Wilson <jarod@redhat.com>, Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>, "David S . Miller" <davem@davemloft.net>

On Wed, Jan 27, 2021 at 11:43:30AM +0200, Nikolay Aleksandrov wrote:
> > For IGMP, although you said they are different. In my understanding, when
> > bridge mac changed, we need to re-join multicast group, while a gratuitous
> > ARP is also needed. I couldn't find a reason why IGMP message is OK but GARP
> > is not.
> > 
> 
> I think that's needed more because of port changing rather than mac changing.
> Switches need to be updated if the port has changed, all of that is already handled
> correctly by the bond. And I also meant that mcast is handled very differently in
> the bridge, usually you'd have snooping enabled.
> 
> The patch below isn't correct and will actually break some cases when bonding
> flaps ports and propagates NETDEV_RESEND_IGMP with a bridge on top.

Hi Nikolay,

I'm little curious. bond/team device will resend IGMP as their MAC address changed.

- bond_resend_igmp_join_requests_delayed()
  - call_netdevice_notifiers(NETDEV_RESEND_IGMP, bond->dev);
- team_mcast_rejoin_work()
  - call_netdevice_notifiers(NETDEV_RESEND_IGMP, team->dev);

What's the purpose that bridge resend IGMP if it's mac address not changed?

I mean, when there is a bridge on top of bond/team, when bond/team flap ports,
bond/team will re-send IGMP and bridge just need to forward it. bridge doesn't
need to re-send the IGMP itself if it's MAC address not changed.

Thanks
Hangbin
