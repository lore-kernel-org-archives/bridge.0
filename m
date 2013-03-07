Return-Path: <john.fastabend@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:message-id:date:from:user-agent:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding;
	bh=K26H23R8kvDCqcKgQxFlTthgi3BZMoggnA1Z56E+bZQ=;
	b=iRv64w/667ag7p9NszUfpc0L5wedxM/cDv+oFmHsQJGsRanrFbuWuSYgW9PaeJvAza
	0SQJ3q1KHOVVgmnyMD4TJ075aiCYEUaI2AplOg+aUC4TWyaI/8eD1arLiWXyz7EwbQ5z
	vxkg4z9C/LBazur179ZqHYOpAWZYbHkPUsKKM0oNJYnm8rPOqLe3y1s9YpCf0BW1bgPp
	qB9Lq8cx8md6nt60N8XzHBxQ7ULttxSWPokYWWw6kb9o3daA2rVyAu9UJl8fUkPt/8TG
	KbELt9ix2X+30oyFDDnx2fdOCzdESPDfin47VBPb/bqG8GUrM+Xrv8OuvWWSzwz9E8e6
	n5mA==
Message-ID: <51380542.4020601@gmail.com>
Date: Wed, 06 Mar 2013 19:10:58 -0800
From: John Fastabend <john.fastabend@gmail.com>
MIME-Version: 1.0
References: <1362623485-18209-1-git-send-email-vyasevic@redhat.com>
	<1362623485-18209-4-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1362623485-18209-4-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 3/3] bridge: Implement
	IFF_UNICAST_FLT
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 03/06/2013 06:31 PM, Vlad Yasevich wrote:
> Implement IFF_UNICAST_FLT on the bridge.  Unicast addresses added
> to the bridge device are synched to the uplink devices.  This
> allows for uplink devices to change while preserving mac assignment.
>
> Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
> ---

[...]

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index b0812c9..ef7b51e 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -677,6 +677,9 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
>   	struct net_port_vlans *pv;
>   	unsigned short vid = VLAN_N_VID;
>
> +	if ((ndm->ndm_flags & NTF_SELF) && (dev->priv_flags & IFF_EBRIDGE))
> +		return ndo_dflt_fdb_add(ndm, tb, dev, addr, nlh_flags);
> +
>   	if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_NOARP|NUD_REACHABLE))) {
>   		pr_info("bridge: RTM_NEWNEIGH with invalid state %#x\n", ndm->ndm_state);
>   		return -EINVAL;
> @@ -774,6 +777,9 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
>   	struct net_port_vlans *pv;
>   	unsigned short vid = VLAN_N_VID;
>
> +	if ((ndm->ndm_flags & NTF_SELF) && (dev->priv_flags & IFF_EBRIDGE))
> +		return ndo_dflt_fdb_del(ndm, tb, dev, addr);
> +
>   	if (tb[NDA_VLAN]) {
>   		if (nla_len(tb[NDA_VLAN]) != sizeof(unsigned short)) {
>   			pr_info("bridge: RTM_NEWNEIGH with invalid vlan\n");
>

How is this different then calling the fdb op from rtnetlink.c when the
NTF_SELF bit is set after your previous patch

	net: generic fdb support for drivers without ndo_fdb_<op>

the generic routine gets called if a specific op is not supplied via
ndo ops anyways right?

Also I suspect if the driver supplies a specific ndo_fdb_<op> we should
use it over the generic one.

What am I missing?

Thanks,
John

-- 
John Fastabend         Intel Corporation
