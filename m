Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 13 May 2021 15:34:24 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20210513133423.GB2222@otheros>
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
 <c5634f19-f9f3-5966-a5b3-a0a64ca4534b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5634f19-f9f3-5966-a5b3-a0a64ca4534b@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v3 00/11] net: bridge: split IPv4/v6
 mc router state and export for batman-adv
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>

On Thu, May 13, 2021 at 03:02:13PM +0300, Nikolay Aleksandrov wrote:
> Nice work overall, thank you. I hope it was tested well. :)
> It'd be great if later you could add some selftests.
> 
> Cheers,
>  Nik

Hi Nikolay,

I think I found a way now to better deal with the protocol
specific hlist_for_each_entry(), by using hlist_for_each()
and a helper function, to reduce the duplicate code
with br_{ip4,ip6}_multicast_get_rport_slot() as you suggested
(and also removing duplicate code with 
br_{ip4,ip6}_multicast_mark_router()) and reworked patches 7
and 9 a bit for that...

Sorry for the inconvience and my bad timing with your reviews. But
thanks a lot for all your valuable feedback!

Also netdevbpf patchwork had a few more remarks, they should
hopefully be fixed now, too.

Regards, Linus
