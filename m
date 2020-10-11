Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tQ91KlC16+iOxVZEy8exzFaomSm6trhPKyMZYS/SYiU=;
 b=PP9UpdZvCKxodnhOYk4LuNzIiPq8nQmjYXzFJGBVU8T13xxMaMqw6hOGHhSIaGlu+d
 OKJFfKtjG/RHYeEBg8xLVQfzwZmArdPUU+M3hqJir1FuFbe3V2qVQgmbqzHcDfadfMow
 KUG01+d89GZ2W5VcxD6+k6Lq/1vvDvN/AZGNqX4TbFFmX07qDc5SslLMXEDHqgxi44o6
 m6ZAKXvUGiFzdux3takZtPZYu34B3qtoNricau8sf9dwS3HjhxFdpDw0LRcZEW23XZhi
 YE/SeGnjEHYM9SCIBuyueZ2XT1cTAmDwTrqF2Fz5BAvsAhyxQtaByifhP2a8nynKsRid
 QpOA==
References: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
 <20201011151030.05ad88dd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <1f1dceab-bab0-ff9e-dae6-ed35be504a9c@gmail.com>
Date: Mon, 12 Oct 2020 00:29:52 +0200
MIME-Version: 1.0
In-Reply-To: <20201011151030.05ad88dd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 00/12] net: add and use function
 dev_fetch_sw_netstats for fetching pcpu_sw_netstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Sergey Matyukevich <geomatsi@gmail.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, Pravin B Shelar <pshelar@ovn.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Vivien Didelot <vivien.didelot@gmail.com>, Igor Mitsyanko <imitsyanko@quantenna.com>, Kalle Valo <kvalo@codeaurora.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, linux-wireless <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, David Miller <davem@davemloft.net>, =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>

On 12.10.2020 00:10, Jakub Kicinski wrote:
> On Sun, 11 Oct 2020 21:34:58 +0200 Heiner Kallweit wrote:
>> In several places the same code is used to populate rtnl_link_stats64
>> fields with data from pcpu_sw_netstats. Therefore factor out this code
>> to a new function dev_fetch_sw_netstats().
> 
> FWIW probably fine to convert nfp_repr_get_host_stats64() as well, just
> take out the drop counter and make it a separate atomic. If you're up
> for that.
> 
Looking at nfp_repr_get_host_stats64() I'm not sure why the authors
decided to add a 64bit tx drop counter, struct net_device_stats has
an unsigned long tx_dropped counter already. And that the number of
dropped tx packets exceeds 32bit (on 32bit systems) seems not very
likely.
