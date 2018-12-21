Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=dXhQBukfKWvAIAwxIDey7FTgXKt5X0FJHC3d9IIOa3Y=;
	b=QiZ6QXX7LOzYWcy4f20zoVA+VTc2UVic3ktRvPXQO6G9W1GhAsjErvGsKvy1y/ijM1
	t2/e5qoBCGn5zmH21/rH6yI8roh4hmJf5SH9XqUg5XxvyvGH9f/Gx0WW0Yd6TAYMpV7E
	j1gs/KaEqcWC52lMjKtzyWe617mlaoq2SwQr8=
References: <20181221151511.14923-1-linus.luessing@c0d3.blue>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <e930f996-de2c-3d69-ccb9-a512ef846de6@cumulusnetworks.com>
Date: Fri, 21 Dec 2018 17:37:32 +0200
MIME-Version: 1.0
In-Reply-To: <20181221151511.14923-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next 0/4] bridge: implement Multicast
 Router Discovery (RFC4286)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S . Miller" <davem@davemloft.net>

On 12/21/18 5:15 PM, Linus Lüssing wrote:
> Hi,
> 
> This patchset adds initial Multicast Router Discovery support to
> the Linux bridge (RFC4286). With MRD it is possible to detect multicast
> routers and mark bridge ports and forward multicast packets to such routers
> accordingly.
> 
> So far, multicast routers are detected via IGMP/MLD queries and PIM
> messages in the Linux bridge. As there is only one active, selected
> querier at a time RFC4541 ("Considerations for Internet Group Management
> Protocol (IGMP) and Multicast Listener Discovery (MLD) Snooping
> Switches") section 2.1.1.a) recommends snooping Multicast Router
> Advertisements as provided by MRD (RFC4286).
> 
> 
> The first two patches are refactoring some existing code which is reused
> for parsing the Multicast Router Advertisements later in the fourth
> patch. The third patch lets the bridge join the all-snoopers multicast
> address to be able to reliably receive the Multicast Router
> Advertisements.
> 
> 
> What is not implemented yet from RFC4286 yet:
> 
> * Sending Multicast Router Solicitations:
>   -> RFC4286: "[...] may be sent when [...] an interface is
>      (re-)initialized [or] MRD is enabled"
> * Snooping Multicast Router Terminations:
>   -> currently this only relies on our own timeouts
> * Adjusting timeouts with the values provided in the announcements
> 
> 
> Regards, Linus
> 
> 
> 

Hi Linus,
Nice work, unfortunately net-next is currenty closed. Anyway I'll
review the patches in detail after the holidays so if there's
anything it can be adjusted for when net-next opens up.

Thanks,
 Nik

