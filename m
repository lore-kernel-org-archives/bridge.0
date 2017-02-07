Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=QhBv1KZyJgOTXWWYhSbL2mS5bYtwuU1IU7O2mXt1Pw8=;
	b=XA6yR36zhwTQ6pkDeFa6HJbmP3UbK6rcwj4rk0b3Wc162bc7ktWEBbBJQBiOqpSHAM
	ohWFjfPAOGVGKyaIO9Mb9NTei/BL7c2ohhGXE5C1TzM88EvWmHJUSOSZjhraD4jy5qrV
	+/Hhl/mmMzrN/5NjJnECFONk0V8/NlabHFkR4=
References: <a2d719a8-da7c-da82-96f7-0b24bd164418@canonical.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <c341a60f-f3d1-29f6-b825-5ebd1432e5b9@cumulusnetworks.com>
Date: Tue, 7 Feb 2017 12:29:16 +0100
MIME-Version: 1.0
In-Reply-To: <a2d719a8-da7c-da82-96f7-0b24bd164418@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge: per vlan dst_metadata netlink support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Colin Ian King <colin.king@canonical.com>, Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On 07/02/17 12:25, Colin Ian King wrote:
> Hi,
> 
> Static analysis with CoverityScan on net/bridge/br_netlink_tunnel.c has
> picked up and issue where tb[] is being referenced but contains
> uninitialized data.
> 
> 222 int br_parse_vlan_tunnel_info(struct nlattr *attr,
> 223                               struct vtunnel_info *tinfo)
> 224 {
> 
>     1. var_decl: Declaring variable tb without initializer.
> 
> 225         struct nlattr *tb[IFLA_BRIDGE_VLAN_TUNNEL_MAX + 1];
> 226         u32 tun_id;
> 227         u16 vid, flags = 0;
> 228         int err;
> 229
> 230         memset(tinfo, 0, sizeof(*tinfo));
> 231
> 
>     CID 1400055 (#1 of 1): Uninitialized pointer read (UNINIT)2.
> uninit_use: Using uninitialized value tb[IFLA_BRIDGE_VLAN_TUNNEL_ID].
> 
> 232         if (!tb[IFLA_BRIDGE_VLAN_TUNNEL_ID] ||
> 233             !tb[IFLA_BRIDGE_VLAN_TUNNEL_VID])
> 234                 return -EINVAL;
> 
> Colin
> 

Good catch, these should go after the parsing.

