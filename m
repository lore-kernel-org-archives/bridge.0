Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E288E6120A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FDFA6111A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vd8KhtWL5F0EsdGFzYWR17p0npLpxD8vu6l4K0Uyi0=;
 b=tNIWYqKg+YxYkA+mGeEgN23xfQEUGYK4FHY3IgOA4A8xYoSEI8VxWEPegXoda1nDNxw1j/Uvt2pPnkaMQaPKruDvyMtqR8Hk4i+AD4KDHhBZHTiFDGBZWxFnNvu+0wKGRTDMc28KP7QqrNH0bXgSeBIZ5yvZIqvZ4HMIw+KJCLvzeTmM+1LXZ1inj/JLM+3PY29Fd77ZEvmItu+C3CuSbtDeein/ZBjnAGh0hTcfGD9ViowZAO9NV8uMZNEdp+PyJWoLZbizVtQGRKPb8KLatcxsiEwEdzTMA3JUfvNTphMp/tOVNzVni2sn3Yq8wCVxnJ99m//ebrFfI2KgedKGPA==
Date: Tue, 23 May 2023 14:34:38 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZGykzh1LgjV+liKh@shredder>
References: <20230518113328.1952135-1-idosch@nvidia.com>
 <20230518113328.1952135-2-idosch@nvidia.com>
 <1ed139d5-6cb9-90c7-323c-22cf916e96a0@blackwall.org>
 <ZGd+9CUBM+eWG5FR@shredder> <20230519145218.659b0104@kernel.org>
 <ZGx0/hwPmFFN2ivS@shredder>
 <de69794bc23a7a019136134cee1e819937f0777a.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de69794bc23a7a019136134cee1e819937f0777a.camel@redhat.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 1/5] skbuff: bridge: Add layer 2 miss
	indication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Paolo Abeni <pabeni@redhat.com>
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com, xiyou.wangcong@gmail.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, saeedm@nvidia.com, davem@davemloft.net

On Tue, May 23, 2023 at 11:04:27AM +0200, Paolo Abeni wrote:
> I think you would only need to set/add the extension when l2_miss is
> true, right? (with no extension l2 hit is assumed). That will avoid
> unneeded overhead for br_dev_xmit().

If an extension is already present (possibly with 'l2_miss' being 'true'
because the packet was flooded by a different bridge earlier in the
pipeline), then we need to clear it when the packet enters the bridge.
IMO, this is quite unlikely. However, if the extension is missing, then
you are correct and there is no point in allocating one.

IOW, I can squash the following diff to the first patch:

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index fb6525553a8a..32115d76a6de 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -764,10 +764,16 @@ static inline void br_tc_skb_miss_set(struct sk_buff *skb, bool miss)
                return;
 
        ext = skb_ext_find(skb, TC_SKB_EXT);
-       if (!ext)
-               ext = tc_skb_ext_alloc(skb);
-       if (ext)
+       if (ext) {
                ext->l2_miss = miss;
+               return;
+       }
+       if (!miss)
+               return;
+       ext = tc_skb_ext_alloc(skb);
+       if (!ext)
+               return;
+       ext->l2_miss = miss;
 }
 #else
 static inline void br_tc_skb_miss_set(struct sk_buff *skb, bool miss)

Thanks
