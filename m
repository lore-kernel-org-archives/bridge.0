Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D14FC8250B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E24B581ADE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=qzk5oLYbYGm3BHnsgSBtDHRCJL48j9t8HeQTS7gm2wg=;
 b=JxUWNI8TIHdFgVW1ngZne2CkuOQxif+pa+WY88wq2PlopW0EDUDjqn5HpjeYYMv+i0
 KViOt3GPgDmkyqt1Z/qhvKgj0X4/bRphKTWbn6kPseH6bvajEKRR7pcj9uFjlpwWBAqh
 30uffDwipf38NBdVVSL6ejnuz1edkAxWTwUk7c4HnyUzPHmH82KXM046fdsnIIejakaa
 1IUmrViZEXVLRgEc5tjo2skcoQDycenjeh7l4cZmyYa8KG8ccAlPiLR7BmWBofJ5cwYJ
 3d3HwK9T9JFItsMEdseerz+vKXidMCitosRO75NmfH0r9/U+IlUQsJV7i+L9Rk01xnwy
 acXA==
Message-ID: <3f2d6682-7c5c-5a6d-110b-568331650949@blackwall.org>
Date: Wed, 21 Sep 2022 07:45:07 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
 <78bd0e54-4ee3-bd3c-2154-9eb8b9a70497@blackwall.org>
 <20220920162954.1f4aaf7b@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220920162954.1f4aaf7b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH RFC net-next 0/5] net: vlan: fix bridge binding
 behavior and add selftests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: aroulin@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, Sevinj Aghayeva <sevinj.aghayeva@gmail.com>, roopa@nvidia.com, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 21/09/2022 02:29, Jakub Kicinski wrote:
> On Tue, 20 Sep 2022 12:16:26 +0300 Nikolay Aleksandrov wrote:
>> The set looks good to me, the bridge and vlan direct dependency is gone and
>> the new notification type is used for passing link type specific info.
> 
> IDK, vlan knows it's calling the bridge:
> 
> +	if ((vlan->flags ^ old_flags) & VLAN_FLAG_BRIDGE_BINDING &&
> +	    netif_is_bridge_master(vlan->real_dev)) {
> 

This one is more of an optimization so notifications are sent only when the bridge
is involved, it can be removed if other interested parties show up.

> bridge knows it's vlan calling:
> 
> +	if (is_vlan_dev(dev)) {
> +		br_vlan_device_event(dev, event, ptr);
> 
> going thru the generic NETDEV notifier seems odd.
> 
> If this is just to avoid the dependency we can perhaps add a stub 
> like net/ipv4/udp_tunnel_stub.c ?
> 

I suggested the notifier to be more generic and be able to re-use it for other link types although
I don't have other use cases in mind right now. Stubs are an alternative as long as they and
their lifetime are properly managed. I don't have a strong preference here so if you prefer
stubs I'm good.

>> If the others are ok with it I think you can send it as non-RFC, but I'd give it
>> a few more days at least. :)

Cheers,
 Nik

