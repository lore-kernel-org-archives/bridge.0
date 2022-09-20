Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 03E7940C1B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 991D840129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663716595;
 bh=nD4QLliR2Fg9W839ij/O4HSyRbpGyiFLDJtkdeZ/HeY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BfwBkfqbihYRed6NuVk9N/7VrgAlWrxMTTnaQQMPx7cebYpFkqsE/ktZQWEHBiYaX
 cwb7Y3AEkerp3zVtNY/ziEbnaENtxPrhGS2KNFOpI3iXxcnGhMvgX70B+w7J7FZ7Qa
 gyI9tRxfZgHOF677hYUGAYQ6JwTXL76IREzWK8r+S2mxTeINADcF+H3zunuUqAWrR0
 aX9eX8dtdd4RMautD7Rb4Nl0d45XaSRDRwrxVHc0ijebPXXz9ay9zNlH78gp7F9lj9
 F37xn7mSvuyaRC4CLmwhHztTmpzkWd8eXwN79QyBkJSDeLNm5wQE7HPnfkuPhJlNC4
 vsHKvmKaq4Txg==
Date: Tue, 20 Sep 2022 16:29:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220920162954.1f4aaf7b@kernel.org>
In-Reply-To: <78bd0e54-4ee3-bd3c-2154-9eb8b9a70497@blackwall.org>
References: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
 <78bd0e54-4ee3-bd3c-2154-9eb8b9a70497@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: aroulin@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, Sevinj Aghayeva <sevinj.aghayeva@gmail.com>, roopa@nvidia.com, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, 20 Sep 2022 12:16:26 +0300 Nikolay Aleksandrov wrote:
> The set looks good to me, the bridge and vlan direct dependency is gone and
> the new notification type is used for passing link type specific info.

IDK, vlan knows it's calling the bridge:

+	if ((vlan->flags ^ old_flags) & VLAN_FLAG_BRIDGE_BINDING &&
+	    netif_is_bridge_master(vlan->real_dev)) {

bridge knows it's vlan calling:

+	if (is_vlan_dev(dev)) {
+		br_vlan_device_event(dev, event, ptr);

going thru the generic NETDEV notifier seems odd.

If this is just to avoid the dependency we can perhaps add a stub 
like net/ipv4/udp_tunnel_stub.c ?

> If the others are ok with it I think you can send it as non-RFC, but I'd give it
> a few more days at least. :)
