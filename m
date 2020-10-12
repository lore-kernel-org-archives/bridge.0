Return-Path: <bounce+52adeb.be9e4a-bridge=lists.linux-foundation.org@mg.codeaurora.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1602486691; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=JAOckvyZSGiRSyfXilzxRRUkdvcueb1oRO7CQ0IBXN0=;
 b=YcLTF1ZptYkPIexT5e2wfTHEN5cz0vL4TxeLTWvrRI33MWlNQqZe6hYNoGxTt/ZSgzu5JgyR
 TyztzQf/kcEd/wlfNrpIInBMGPQrakay/NeLlKP5cPxRlPhXYQMO3h7DmtV7ksB45tu1Qd5Z
 rjtRWo05o4k/T9gJHvz7n/s8X2M=
Sender: kvalo=codeaurora.org@mg.codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
References: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
 <a4fa20e9-23bc-4f2f-cbe9-16d801ce3b20@gmail.com>
Date: Mon, 12 Oct 2020 10:10:43 +0300
In-Reply-To: <a4fa20e9-23bc-4f2f-cbe9-16d801ce3b20@gmail.com> (Heiner
 Kallweit's message of "Sun, 11 Oct 2020 21:40:10 +0200")
Message-ID: <87sgajzzpo.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 06/12] qtnfmac: use new function
	dev_fetch_sw_netstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Sergey Matyukevich <geomatsi@gmail.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, Pravin B Shelar <pshelar@ovn.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Igor Mitsyanko <imitsyanko@quantenna.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, linux-wireless <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, David Miller <davem@davemloft.net>, =?utf-8?Q?Bj=C3=B8rn?= Mork <bjorn@mork.no>

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Simplify the code by using new function dev_fetch_sw_netstats().
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

I assume this goes via net-next so:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
