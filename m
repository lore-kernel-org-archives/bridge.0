Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdpyEYmZy2LSYRhBT2FcVK8Zyrg+vly7pYR7eqZpjqQ=;
 b=OFqmVF/6YDS9AiNsapp/n/ha3ZpFioDyL14nyau+lwCByFqmSyftlmayiJ+F8KPKNpfTx6/nWTb+53Kz/1GLJMs1zIOBfu3NtoEBqKZGWb5DwAMwDwmhQinfe8SA9qOEL1gWXaezHp4cLF3IU7s06vYBJKHX3aICqM+CYNYs4nLn2mBUTUWA4D57PC2KKm4yzRGi0Itl/gioxOyT672G5W/qQ7VfkbNQ11L3M6X5je37ye//WIdcUr9ps4VBH6ZvOXtvu73K5LIKJkgpRf6FIE8Lhc3GBxMUB8o2sCm/uASwUvBAFmwkZQpvwa32eSTbK1E/8SYEKCNLFlGN8218Cw==
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <c5634f19-f9f3-5966-a5b3-a0a64ca4534b@nvidia.com>
Date: Thu, 13 May 2021 15:02:13 +0300
In-Reply-To: <20210512231941.19211-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>

On 13/05/2021 02:19, Linus Lüssing wrote:
> Hi,
> 
> The following patches are splitting the so far combined multicast router
> state in the Linux bridge into two ones, one for IPv4 and one for IPv6,
> for a more fine-grained detection of multicast routers. This avoids
> sending IPv4 multicast packets to an IPv6-only multicast router and 
> avoids sending IPv6 multicast packets to an IPv4-only multicast router.
> This also allows batman-adv to make use of the now split information in
> the final patch.
> 
> The first eight patches prepare the bridge code to avoid duplicate
> code or IPv6-#ifdef clutter for the multicast router state split. And 
> contain no functional changes yet.
> 
> The ninth patch then implements the IPv4+IPv6 multicast router state
> split.
> 
> Patch number ten adds IPv4+IPv6 specific timers to the mdb netlink
> router port dump, so that the timers validity can be checked individually
> from userspace.
> 
> The final, eleventh patch exports this now per protocol family multicast
> router state so that batman-adv can then later make full use of the 
> Multicast Router Discovery (MRD) support in the Linux bridge. The 
> batman-adv protocol format currently expects separate multicast router
> states for IPv4 and IPv6, therefore it depends on the first patch.
> batman-adv will then make use of this newly exported functions like
> this[0].
> 
> Regards, Linus
> 
> [0]: https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/linus/multicast-routeable-mrd
>      -> https://git.open-mesh.org/batman-adv.git/commit/d4bed3a92427445708baeb1f2d1841c5fb816fd4
> 

Nice work overall, thank you. I hope it was tested well. :)
It'd be great if later you could add some selftests.

Cheers,
 Nik

