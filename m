Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 19 Feb 2019 09:57:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1550566639; h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=dxccSu8Qmm+/lITXvnqtX1g5CBwXFzDuDvOs275g3FY=;
	b=Ep8dJJRALe787t1GOVnGDYOCc/t0JbMoeBcIHntGiJs5dWW+s6GYoVAw/gGMEwCKfkMqn4
	/mOOwp0LGASd/VB8O3V1lDXen4kR7YbQgOhJxznhJoDn+Dr8aHFlj8HrYwpwkWaNVyMj2w
	pAJCdJELJuOHMH7WzHbLiErm+uVDOm/pAXRkFDFua3s2vNRtbgLfFa5mT/5cPaKGoCkTmy
	3gVmhupAaVtTEvvVinlvC4wlQZnSGXHVVEji8S5FqeQzuIYgxqJYeHeEdH+nPIpV7yzyZy
	uRJeGy8pLmeQKew/r5zWNblHVDFn0gK3QnW9fwH/NVXJkC6RlTb4W5ITJYHZgQ==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190219085716.GD10191@otheros>
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
	<20190218122107.10097-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190218122107.10097-1-nikolay@cumulusnetworks.com>
Subject: Re: [Bridge] [RFC v2] net: bridge: don't flood known multicast
 traffic when snooping is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, roopa@cumulusnetworks.com, f.fainelli@gmail.com, idosch@idosch.org

On Mon, Feb 18, 2019 at 02:21:07PM +0200, Nikolay Aleksandrov wrote:
> This is v2 of the RFC patch which aims to forward packets to known
> mdsts' ports only (the no querier case). After v1 I've kept
> the previous behaviour when it comes to unregistered traffic or when
> a querier is present. All of this is of course only with snooping
> enabled. So with this patch the following changes should occur:
>  - No querier: forward known mdst traffic to its registered ports,
>                no change about unknown mcast (flood)
>  - Querier present: no change
> 
> The reason to do this is simple - we want to respect the user's mdb
> configuration in both cases, that is if the user adds static mdb entries
> manually then we should use that information about forwarding traffic.
> 
> What do you think ?
> 
> * Notes
> Traffic that is currently marked as mrouters_only:
>  - IPv4: non-local mcast traffic, igmp reports
>  - IPv6: non-all-nodes-dst mcast traffic, mldv1 reports
> 
> Simple use case:
>  $ echo 1 > /sys/class/net/bridge/bridge/multicast_snooping
>  $ bridge mdb add dev bridge port swp1 grp 239.0.0.1
>  - without a querier currently traffic for 239.0.0.1 will still be flooded,
>    with this change it will be forwarded only to swp1

There is still the issue with unsolicited reports adding mdst
entries here, too. Leading to unwanted packet loss and connectivity issues.

If I understand correctly, then the goal is to give the user
slightly more control over specific, dedicated multicast addresses, right?
Could you achieve the same via netfilter? Or is that rather unfeasible
with switchdev drivers? (sorry, don't have much
knowledge/experience with switchdev yet)

Regards, Linus
