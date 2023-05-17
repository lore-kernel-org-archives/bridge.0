Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14F9C42043
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FD9641D8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1684308785; x=1686900785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dNSDSFrDFbpPqdYEuN89e9yeuyZne6fiLX09JZpnnaQ=;
 b=VmMAPOyosODi0Oa3kk/lczgV+F2wFxVZqk/0hszxe6QSeo3ux81DeWhkAFDUa5ku0B
 EBVL5IutHi6M7si8Vm8aAiOTcMFGFAjk2kxuqfj5x+sT5Wgsu9+Yjj6y0E0+GkB7eV/2
 FcWAUoD3eg8bs96ntWcLX2TarfzeCS74IoXx8FkajG2BQ+HIC36UoFg/oq4Yl4J/r7eB
 yxTxC+pJiMcArvLGowXWqL736Ukqmfc4j7mLQYNDCwG8QVYKAAeWyzgOZK/HILnza1fW
 erNjN9FdiNH4EGuBRrPcKURazxmzSrlDlhDlg9c1cencscueOAOfdJbO3HGQHPACDuZv
 +vgg==
Message-ID: <63f12ee5-bd7d-a734-af98-e99196d84441@blackwall.org>
Date: Wed, 17 May 2023 10:33:03 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230516194625.549249-1-arnd@kernel.org>
 <20230516194625.549249-3-arnd@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230516194625.549249-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 3/4] bridge: always declare tunnel functions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@kernel.org>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Roopa Prabhu <roopa@nvidia.com>

On 16/05/2023 22:45, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_BRIDGE_VLAN_FILTERING is disabled, two functions are still
> defined but have no prototype or caller. This causes a W=1 warning for
> the missing prototypes:
> 
> net/bridge/br_netlink_tunnel.c:29:6: error: no previous prototype for 'vlan_tunid_inrange' [-Werror=missing-prototypes]
> net/bridge/br_netlink_tunnel.c:199:5: error: no previous prototype for 'br_vlan_tunnel_info' [-Werror=missing-prototypes]
> 
> The functions are already contitional on CONFIG_BRIDGE_VLAN_FILTERING,
> and I coulnd't easily figure out the right set of #ifdefs, so just
> move the declarations out of the #ifdef to avoid the warning,
> at a small cost in code size over a more elaborate fix.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/bridge/br_private_tunnel.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

This should be for -net.

Fixes: 188c67dd1906 ("net: bridge: vlan options: add support for tunnel id dumping")
Fixes: 569da0822808 ("net: bridge: vlan options: add support for tunnel mapping set/del")
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks,
 Nik



