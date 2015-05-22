Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=w33JEFpyzAxvNgDAUg0PodL7Nty/T/DNJyrdZCLaPdc=;
	b=WZWIM4rhnHEOnZ3WvoiuldWO2Y9PBq07Jo6bqPtmde2WNZ+SgzNUDYwuex/10wZ58a
	tIN62+WwMKEsxwaKu1sBfNm7/yLWBx9dhV8/dnE8Xi+2Npt9NrZXlQxPSnT54spsTsYq
	0Ubb00byN5vblOuzLRzY0KPk4Zd9XpDkdG9BE=
Message-ID: <555E8CD9.9030004@cumulusnetworks.com>
Date: Thu, 21 May 2015 18:56:41 -0700
From: roopa <roopa@cumulusnetworks.com>
MIME-Version: 1.0
References: <1432256161-4425-1-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1432256161-4425-1-git-send-email-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] bridge: allow setting hash_max +
 multicast_router if interface is down
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Wilson Kok <wkok@cumulusnetworks.com>, "David S. Miller" <davem@davemloft.net>

On 5/21/15, 5:56 PM, Linus Lüssing wrote:
> Network managers like netifd (used in OpenWRT for instance) try to
> configure interface options after creation but before setting the
> interface up.
>
> Unfortunately the sysfs / bridge currently only allows to configure the
> hash_max and multicast_router options when the bridge interface is up.
> But since br_multicast_init() doesn't start any timers and only sets
> default values and initializes timers it should be save to reconfigure
> the default values after that, before things actually get active after
> the bridge is set up.
>
> With this patch hash_max and multicast_router attributes can be
> changed even if the according bridge (port) is down, just like other
> other bridge (port) attributes allow too.
>
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
> Changelog:
> * [RFC PATCH net-next] -> [PATCH net-next]
Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>

we have a similar patch in-house waiting to be up-streamed.

thanks.
