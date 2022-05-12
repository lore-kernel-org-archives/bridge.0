Return-Path: <eng.alaamohamedsoliman.am@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=PCs+Ktha+vtmFq4XrExb1Mfp7UobjBZfKORd/6xUEnQ=;
 b=iH0GrPY8XRZBVfl7obokvqEguSGfgHDNW8WAl7iOB+g/Tlurte7GKIvSy3OEiTVO04
 eeh/9EJnTUt6gzmU0bJjxim8YpzFs4XRKTC8P/aVgEsfaam05KCZbdiKxj29+g1xkBf2
 UswmbtAGRTFvqTtmGRyBTdOYcZ91J6QPLUDDL9SOMpFlBJobtcsSwimEIYKHDMDu7YNx
 1BVEe5l3GsRKpiGKl6dB3pC9DEHDcu+83r0s6ZCjgVOR2/pWwazCqY3XbkZXfdcQz8RU
 dWawCs8ihVRvFOIIN+xL2Nx6s/6O7CHzwkCSwJ30NXqCG6IpajUa2NASiP9w4dKNfVa3
 GKXA==
Message-ID: <191b395a-996b-597e-4ee9-06722ac3c776@gmail.com>
Date: Thu, 12 May 2022 10:39:38 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1651762829.git.eng.alaamohamedsoliman.am@gmail.com>
 <ac4b6c650b6519cc56baa32ef20415460a5aa8ee.1651762830.git.eng.alaamohamedsoliman.am@gmail.com>
 <20220509154603.4a7b4243@kernel.org>
From: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
In-Reply-To: <20220509154603.4a7b4243@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v6 2/2] net: vxlan: Add extack support
 to vxlan_fdb_delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shshaikh@marvell.com, jdenham@redhat.com, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, alexandre.belloni@bootlin.com, outreachy@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com, sbrivio@redhat.com, claudiu.manoil@nxp.com, anthony.l.nguyen@intel.com, roopa@nvidia.com, intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net, UNGLinuxDriver@microchip.com


On ١٠‏/٥‏/٢٠٢٢ ٠٠:٤٦, Jakub Kicinski wrote:
> On Thu,  5 May 2022 17:09:58 +0200 Alaa Mohamed wrote:
>> +			NL_SET_ERR_MSG(extack,
>> +						  "DST, VNI, ifindex and port are mutually exclusive with NH_ID");
> This continuation line still does not align with the opening bracket.
> Look here if your email client makes it hard to see:
>
> https://lore.kernel.org/all/ac4b6c650b6519cc56baa32ef20415460a5aa8ee.1651762830.git.eng.alaamohamedsoliman.am@gmail.com/
>
> Same story in patch 1:
>
>>   static int ocelot_port_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
>>   			       struct net_device *dev,
>> -			       const unsigned char *addr, u16 vid)
>> +			       const unsigned char *addr, u16 vid,
>> +				   struct netlink_ext_ack *extack)
> and here:
>
>>   static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
>>   			    struct net_device *dev,
>> -			    const unsigned char *addr, u16 vid)
>> +			    const unsigned char *addr, u16 vid,
>> +				struct netlink_ext_ack *extack)


I will fix it, thanks.

