Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=dB3TMvgAQGqW8iM7mvjr8ud3n5LrGEydMtsKYVuRKPk=;
	b=Yrdi+RWr6B8GIJ5Gd1jpC6S7VIX0PzLoO4dNloMRGV7Ge3x7uvxwZzdCsYefgzIJff
	mes21adcfTLGSpoHyQ3RBBy3M2HbfAUWNtw+sgsvLIvryc6CTSlvMcuZiFqEovBQtR2A
	RQi4i3jsdEJPDXOcyLSkb3znxvpvLYTMHMGQs=
MIME-Version: 1.0
In-Reply-To: <20171003112948.44d9cc56@xeon-e3>
References: <1507054876-16746-1-git-send-email-roopa@cumulusnetworks.com>
	<1507054876-16746-2-git-send-email-roopa@cumulusnetworks.com>
	<20171003112948.44d9cc56@xeon-e3>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Tue, 3 Oct 2017 21:47:19 -0700
Message-ID: <CAJieiUhLiTbt-+SWJ2Yq6WxYR+x=hLM_ONyqt+kCDBWbKCTU+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net-next v2 1/3] bridge: add new
 BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "davem@davemloft.net" <davem@davemloft.net>

On Tue, Oct 3, 2017 at 11:29 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Tue,  3 Oct 2017 11:21:14 -0700
> Roopa Prabhu <roopa@cumulusnetworks.com> wrote:
>
>> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
>> index 48fb174..7a50dc5 100644
>> --- a/net/bridge/br_forward.c
>> +++ b/net/bridge/br_forward.c
>> @@ -204,7 +204,8 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
>>               /* Do not flood to ports that enable proxy ARP */
>>               if (p->flags & BR_PROXYARP)
>>                       continue;
>> -             if ((p->flags & BR_PROXYARP_WIFI) &&
>> +             if ((p->flags & BR_PROXYARP_WIFI ||
>> +                  p->flags & BR_NEIGH_SUPPRESS) &&
>>                   BR_INPUT_SKB_CB(skb)->proxyarp_replied)
>>                       continue;
>
> Don;t you need additional paren here to avoid warnings.
> Or do one mask:
>                 if ((p->flags & (BR_PROXYARP_WIFI | BR_NEIGH_SUPPRESS)) &&
>                     BR_INPUT_SKB_CB(skb)->proxyarp_replied)
>                         continue;

Missed seeing this, i just posted v3. I did not get a warning. I can
certainly simplify the mask and post.
