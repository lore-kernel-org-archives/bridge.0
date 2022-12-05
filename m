Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03F9981D18
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 462318177A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nrWL8VxV0K9t0uZy6ZzE5+V/ehvOIE3e5uGU6WmUU3g=;
 b=n/JHSIp5f7fAh4109T4B/S5kbuGEk//xfTg/w87G677OjtlH3/YKvF8TZjZSMoP9Ra
 qUQ98PTxBGTeetn12wzisQsFSgoesqRH5HORYzjd4GN+yi/VcZBsu3EGjAI3aC1nrrW9
 9mw58FvzPYZfn5/gYnda4NFrSNsSbWXzf/k3tA0iE649LOq0EXGLbRMzswfvN4eSrp7R
 3qlRany7DwBZYrwvwpCFV/O8B0FyUXJCFUE8SmAy4Fx+Nl+hTGpqFB42N18fY904YwE7
 51q9JRMNPjnI4E2GPnN83p6wc6hyEJoXNTh7a+zBzP8pGNTJDOG4P7RRjjG/b9WPyvKH
 uX9A==
Message-ID: <aa2c2350-7210-ce54-f75e-62d56be2b4d2@blackwall.org>
Date: Mon, 5 Dec 2022 13:42:02 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221205074251.4049275-1-idosch@nvidia.com>
 <20221205074251.4049275-7-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221205074251.4049275-7-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 6/8] bridge: mcast: Remove
	br_mdb_parse()
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

On 05/12/2022 09:42, Ido Schimmel wrote:
> The parsing of the netlink messages and the validity checks are now
> performed in br_mdb_config_init() so we can remove br_mdb_parse().
> 
> This finally allows us to stop passing netlink attributes deep in the
> MDB control path and only use the MDB configuration structure.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 93 +++------------------------------------------
>  1 file changed, 5 insertions(+), 88 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


