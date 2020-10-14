Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602635993;
 bh=CFDyw8SnopRjOQTv0trN9Zq7Ipl3I4xqiXTNATXIglw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nIH5M255GwfPrbDQw7nysc73Kb4lCHwXLccsHykUZ7j00IujiVWARwvphAzSdGbQP
 IuFY/nrDgxcHpobYsKZV6FppHfBO0ll8YvibDiZtw3KPKZ62M3T+AvO8PaoLzgQAhZ
 If59RIypN65WfSLeZIhy6Wa8MEgwOEApPF5WA8eU=
Date: Tue, 13 Oct 2020 17:39:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201013173951.25677bcc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
References: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 00/12] net: add and use function
 dev_fetch_sw_netstats for fetching pcpu_sw_netstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Sergey Matyukevich <geomatsi@gmail.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, Pravin B Shelar <pshelar@ovn.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Vivien Didelot <vivien.didelot@gmail.com>, Igor Mitsyanko <imitsyanko@quantenna.com>, Kalle Valo <kvalo@codeaurora.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, linux-wireless <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, David Miller <davem@davemloft.net>, =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>

On Mon, 12 Oct 2020 10:00:11 +0200 Heiner Kallweit wrote:
> In several places the same code is used to populate rtnl_link_stats64
> fields with data from pcpu_sw_netstats. Therefore factor out this code
> to a new function dev_fetch_sw_netstats().
> 
> v2:
> - constify argument netstats
> - don't ignore netstats being NULL or an ERRPTR
> - switch to EXPORT_SYMBOL_GPL

Applied, thank you!
