Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aeWyu0fhicZ35ndvB5G7CKdKzKpJv3Q8+/dMeny8r3E=;
 b=ngUoDnD3ez3wPljEH7V6ZRJPxi6VyKPo3NxCEGkokrtq2QA/+s/lV/gHCbtL1ccOZM
 y4RF2dEUkDYGhH4MNBxZg/1KDQafk1w8ITyco6/45YqH8gEgwjnp0z6zsFzKn4IOHj4s
 SEgx35DPjNeiQzLyJktDf8AGW15iQC8AEp6CWP5YKxFjWBgY54Ck35nwJlqfo9PVt8+y
 bOUQNnEc8FKh9al2GBvmeJd6AXmxiWSD5M3XIfYFKi7rr36blaxM8b/XEUh/rGL1Hk8R
 zvF+ytnIvMGQMQUTRgQmPC6Nm15fiVz3SDDpT9DWCqkOjC2BvUYWeMwsgd6Mu48AXDAk
 ln9Q==
References: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
 <20201013173951.25677bcc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201014054250.GB6305@unreal>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <3be8fd19-1c7e-0e05-6039-e5404b2682b9@gmail.com>
Date: Wed, 14 Oct 2020 08:13:47 +0200
MIME-Version: 1.0
In-Reply-To: <20201014054250.GB6305@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Leon Romanovsky <leon@kernel.org>, Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Sergey Matyukevich <geomatsi@gmail.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, Pravin B Shelar <pshelar@ovn.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Vivien Didelot <vivien.didelot@gmail.com>, Igor Mitsyanko <imitsyanko@quantenna.com>, Kalle Valo <kvalo@codeaurora.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, linux-wireless <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>

On 14.10.2020 07:42, Leon Romanovsky wrote:
> On Tue, Oct 13, 2020 at 05:39:51PM -0700, Jakub Kicinski wrote:
>> On Mon, 12 Oct 2020 10:00:11 +0200 Heiner Kallweit wrote:
>>> In several places the same code is used to populate rtnl_link_stats64
>>> fields with data from pcpu_sw_netstats. Therefore factor out this code
>>> to a new function dev_fetch_sw_netstats().
>>>
>>> v2:
>>> - constify argument netstats
>>> - don't ignore netstats being NULL or an ERRPTR
>>> - switch to EXPORT_SYMBOL_GPL
>>
>> Applied, thank you!
> 
> Jakub,
> 
> Is it possible to make sure that changelogs are not part of the commit
> messages? We don't store previous revisions in the git repo, so it doesn't
> give too much to anyone who is looking on git log later. The lore link
> to the patch is more than enough.
> 
I remember that once I did it the usual way (changelog below the ---) David
requested the changelog to be part of the commit message. So obviously he
sees some benefit in doing so. 

> 44fa32f008ab ("net: add function dev_fetch_sw_netstats for fetching pcpu_sw_netstats")
> 
> Thanks
> 

