Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E78DD4014B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6ED104014A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I/NiR04BbzcUV//md2hUQO/dnN6Z7scyidQgiE5B2hg=;
 b=VJTtQyFx7jDB5CrXOwLXWeqcAcBabtG5fa63nVOt4TWI9j7o3YzB+csFGOP/omIVBg
 cYHSkr9dmk0R1su2IXweF0YNvv4WbGvLjIpNAHwEK6LSISOBPx7B1IRiLxl2zaMou9pC
 G1pCmcnwlMl6zRzZsmCLbSUldc3x0POKJ86BjYHZ9X/+z46ngn3Jqm1NCRiM3ahlIrGZ
 OsrovOfG9d7bA5qrlMCD7KqaTcYoyRAi0UDJl/faqN7JZe1ruoc5Cf2/xQZQ20SwSmL4
 ix8t8192Bdkcoy2/BFKQtbTjlsGUs/ckoiPZd+9uaoiqEViqbKJJOQD6A04mJw4TT4Fk
 88wQ==
Message-ID: <9246d282-2691-d1c4-c1cc-fe3f0461e330@blackwall.org>
Date: Fri, 9 Dec 2022 09:29:53 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-3-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 02/14] bridge: mcast: Split (*,
 G) and (S, G) addition into different functions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 08/12/2022 17:28, Ido Schimmel wrote:
> When the bridge is using IGMP version 3 or MLD version 2, it handles the
> addition of (*, G) and (S, G) entries differently.
> 
> When a new (S, G) port group entry is added, all the (*, G) EXCLUDE
> ports need to be added to the port group of the new entry. Similarly,
> when a new (*, G) EXCLUDE port group entry is added, the port needs to
> be added to the port group of all the matching (S, G) entries.
> 
> Subsequent patches will create more differences between both entry
> types. Namely, filter mode and source list can only be specified for (*,
> G) entries.
> 
> Given the current and future differences between both entry types,
> handle the addition of each entry type in a different function, thereby
> avoiding the creation of one complex function.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 145 +++++++++++++++++++++++++++++---------------
>  1 file changed, 96 insertions(+), 49 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


