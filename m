Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X6D0Ror+2mO5zJfkz9qAnbmgE+QzWXoroVWR4akLGf8=;
 b=s5ssW1+ERHepdZYBphFnv0uGNdmvm9qfiAQ+ezzdvRMUdNLSSfX5yH9rbWeN3dajnI
 MsPJvfe/hKGZMZvtGy+2+V7Od80b210yFBfb10Kku7sofHqFrxvpy04y3AxJZEqJIJ0l
 hI3xO52Gk6IIjF7eHeSdd5jGaiAvqp5Th2mixIU0AquVhM9CmGRcXahAUQlaDlLLIRBl
 1VPaaN1rqwQz/uNu35CTX+BChIzjc0L1UiGvQcZU2bYEa8zymc2uV/mvIyimIRYRpV+u
 78mCAkllTB/rT8HR3KyzJE861EqOb2dYq7mZdKqjD0uDZj/YIYVWGHhYg9HSgBVQoGyd
 ZVrg==
References: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
 <20201013173951.25677bcc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201014054250.GB6305@unreal>
 <3be8fd19-1c7e-0e05-6039-e5404b2682b9@gmail.com>
 <20201014075310.GG6305@unreal>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <cb02626b-71bd-360d-c864-5dac2a1a7603@gmail.com>
Date: Wed, 14 Oct 2020 09:59:10 +0200
MIME-Version: 1.0
In-Reply-To: <20201014075310.GG6305@unreal>
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
To: Leon Romanovsky <leon@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Sergey Matyukevich <geomatsi@gmail.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, Pravin B Shelar <pshelar@ovn.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Igor Mitsyanko <imitsyanko@quantenna.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Kalle Valo <kvalo@codeaurora.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, linux-wireless <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, David Miller <davem@davemloft.net>, =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>

On 14.10.2020 09:53, Leon Romanovsky wrote:
> On Wed, Oct 14, 2020 at 08:13:47AM +0200, Heiner Kallweit wrote:
>> On 14.10.2020 07:42, Leon Romanovsky wrote:
>>> On Tue, Oct 13, 2020 at 05:39:51PM -0700, Jakub Kicinski wrote:
>>>> On Mon, 12 Oct 2020 10:00:11 +0200 Heiner Kallweit wrote:
>>>>> In several places the same code is used to populate rtnl_link_stats64
>>>>> fields with data from pcpu_sw_netstats. Therefore factor out this code
>>>>> to a new function dev_fetch_sw_netstats().
>>>>>
>>>>> v2:
>>>>> - constify argument netstats
>>>>> - don't ignore netstats being NULL or an ERRPTR
>>>>> - switch to EXPORT_SYMBOL_GPL
>>>>
>>>> Applied, thank you!
>>>
>>> Jakub,
>>>
>>> Is it possible to make sure that changelogs are not part of the commit
>>> messages? We don't store previous revisions in the git repo, so it doesn't
>>> give too much to anyone who is looking on git log later. The lore link
>>> to the patch is more than enough.
>>>
>> I remember that once I did it the usual way (changelog below the ---) David
>> requested the changelog to be part of the commit message. So obviously he
>> sees some benefit in doing so.
> 
> Do you have a link? What is the benefit and how can we use it?
> 
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1873080.html

> Usually such request comes to ensure that commit message is updated with
> extra information (explanation) existed in changelog which is missing in
> the patch.
> 
> Thanks
> 
>>
>>> 44fa32f008ab ("net: add function dev_fetch_sw_netstats for fetching pcpu_sw_netstats")
>>>
>>> Thanks
>>>
>>

