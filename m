Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v4MsclsAjBQ07tS6Y2k6AL+A2oNnHE0z2Kb1St2ZEIk=;
 b=neCttq4/0J3+3NTrhanFCgR56+zz6hfDnAOzM1dINwDLIuAqA3tMADIrgI6aUb+zAi
 +eW84mbUHzG1mA5KER0AFuvgMSlGeNFlSeYUrjL3m0dJOszx4WBDI7kWKXISNlENJhPD
 050WWxG7qW9dQuQpk2PmuXO+528K82e7K89uJXuvnEVnilQvnYJVi757k2QQYxh4CVa5
 Ed4GZZNn1vn+kv1i5dFESGPhlygVY4oDvkiD0PyxkFWDbCeb3YrRkppBbbm0d5WR0fxd
 tkkajfw+0ba0e9Nb5KjCCcTqY9wUM/LHdfNPLudLcRYIk6kS1/Eq5VLz1CoqDWXm0BU7
 Hy7Q==
References: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
 <5bb71143-0dac-c413-7e97-50eed8a57862@gmail.com>
 <20201011125412.3719926a@hermes.local>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <0a127353-4358-9664-6784-dec2c48e9b9d@gmail.com>
Date: Sun, 11 Oct 2020 22:18:58 +0200
MIME-Version: 1.0
In-Reply-To: <20201011125412.3719926a@hermes.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 01/12] net: core: add function
 dev_fetch_sw_netstats for fetching pcpu_sw_netstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Sergey Matyukevich <geomatsi@gmail.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, Pravin B Shelar <pshelar@ovn.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Igor Mitsyanko <imitsyanko@quantenna.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Kalle Valo <kvalo@codeaurora.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, linux-wireless <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, David Miller <davem@davemloft.net>, =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>

On 11.10.2020 21:54, Stephen Hemminger wrote:
> On Sun, 11 Oct 2020 21:36:43 +0200
> Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> +void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
>> +			   struct pcpu_sw_netstats __percpu *netstats)
> 
> netstats is unmodified, should it be const?
> 
>> +{
>> +	int cpu;
>> +
>> +	if (IS_ERR_OR_NULL(netstats))
>> +		return;
> 
> Any code calling this with a null pointer is broken/buggy, please don't
> ignore that.
> 
Thanks, I'll consider both points in a v2.
