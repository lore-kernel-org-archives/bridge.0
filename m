Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ce5PmEqmv1YSWMDHRt7GbAyKG6KhkYzK8oKJ+L0ajJU=;
 b=NecgSIK6HUp8mfsj4UInLUpOx0FhmYVbOiqvrr2fvZ5TYkrQUuEXkLPTzx5tcFBsEz
 Nq5+JltEQ91NdKRQV2G4Iq1a+xepvbeY+DfJKI4gN+xMLpM7ffxRD/Vy8ael2SRXmk1R
 zyFNBrWANYpGkvC0C9FQlDI7o+XgrW96Kn/50uUMwFceO/cPDsQ5nMCNredRM1yohFiF
 WCfcxk5DLRJtocYCPu/Q2rJDAWygrt7fEniMPlOpK2C7WdbS9Qof9pGftoU6zVWTgefu
 A0B22SdP73LR4NQuzphqUkQ+dMI1GkQXsNYI0Dl/JKScaU4MYP2jBBnNoIji5e1DpelC
 TCTQ==
Date: Sun, 11 Oct 2020 12:54:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20201011125412.3719926a@hermes.local>
In-Reply-To: <5bb71143-0dac-c413-7e97-50eed8a57862@gmail.com>
References: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
 <5bb71143-0dac-c413-7e97-50eed8a57862@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Sergey Matyukevich <geomatsi@gmail.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, Pravin B Shelar <pshelar@ovn.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Igor Mitsyanko <imitsyanko@quantenna.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Kalle Valo <kvalo@codeaurora.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, linux-wireless <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, David Miller <davem@davemloft.net>, =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>

On Sun, 11 Oct 2020 21:36:43 +0200
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> +void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
> +			   struct pcpu_sw_netstats __percpu *netstats)

netstats is unmodified, should it be const?

> +{
> +	int cpu;
> +
> +	if (IS_ERR_OR_NULL(netstats))
> +		return;

Any code calling this with a null pointer is broken/buggy, please don't
ignore that.
