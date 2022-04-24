Return-Path: <eng.alaamohamedsoliman.am@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=lReuseCvVNEXlTNL6o6EN+A35b6tYTj8OfIs+Kswr2w=;
 b=Q/lDeS27Mli6BRmeY0+ReefxtLnq4WxEwOUeT23rab46xj9eLTLuRI+y6emQa/uvJ3
 yifh02I+4aZKTF/Vy/urexsI9DOfBN6/Kj4U0Gx1K9JVqsaatT8Oi3amtqIn6ixWZiHv
 XF9M01eykb6CK6J27qfas0wtFodk89XkyCgvO1B6dTvnLtP3+SRjiIOyaBU762tRIgc0
 fxOA5ZUa80Z0V2zzMwxGYyG2MhhjWo/D/J4a4Y17sALe1ZZ6E8LBhd3SmPFxchcimHwo
 FaWsMtf8VdXiZuEc1jFR1kSCszoDsbFSMWMp8h0/wGkm9GWRG4HO+kArfHJJJKzcJHkY
 d4dw==
Message-ID: <06622e4c-b9a5-1c4f-2764-a72733000b4e@gmail.com>
Date: Sun, 24 Apr 2022 20:52:27 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1650800975.git.eng.alaamohamedsoliman.am@gmail.com>
 <0d09ad611bb78b9113491007955f2211f3a06e82.1650800975.git.eng.alaamohamedsoliman.am@gmail.com>
 <alpine.DEB.2.22.394.2204241813210.7691@hadrien>
From: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2204241813210.7691@hadrien>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v3 2/2] net: vxlan: vxlan_core.c: Add
 extack support to vxlan_fdb_delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: shshaikh@marvell.com, jdenham@redhat.com, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, alexandre.belloni@bootlin.com, outreachy@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com, sbrivio@redhat.com, claudiu.manoil@nxp.com, anthony.l.nguyen@intel.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, UNGLinuxDriver@microchip.com, intel-wired-lan@lists.osuosl.org


On ٢٤‏/٤‏/٢٠٢٢ ١٨:١٥, Julia Lawall wrote:
>
> On Sun, 24 Apr 2022, Alaa Mohamed wrote:
>
>> Add extack to vxlan_fdb_delete and vxlan_fdb_parse
> It could be helpful to say more about what adding extack support involves.
>
>> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
>> ---
>> changes in V2:
>> 	- fix spelling vxlan_fdb_delete
>> 	- add missing braces
>> 	- edit error message
>> ---
>> changes in V3:
>> 	fix errors reported by checkpatch.pl
> But your changes would seem to also be introducing more checkpatch errors,
> because the Linux kernel coding style puts a space before an { at the
> start of an if branch.
I ran checkpatch script before submitting this patch and got no error
>
> julia
>
>> ---
>>   drivers/net/vxlan/vxlan_core.c | 36 +++++++++++++++++++++++-----------
>>   1 file changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
>> index cf2f60037340..4e1886655101 100644
>> --- a/drivers/net/vxlan/vxlan_core.c
>> +++ b/drivers/net/vxlan/vxlan_core.c
>> @@ -1129,19 +1129,23 @@ static void vxlan_fdb_dst_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
>>
>>   static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
>>   			   union vxlan_addr *ip, __be16 *port, __be32 *src_vni,
>> -			   __be32 *vni, u32 *ifindex, u32 *nhid)
>> +			   __be32 *vni, u32 *ifindex, u32 *nhid, struct netlink_ext_ack *extack)
>>   {
>>   	struct net *net = dev_net(vxlan->dev);
>>   	int err;
>>
>>   	if (tb[NDA_NH_ID] && (tb[NDA_DST] || tb[NDA_VNI] || tb[NDA_IFINDEX] ||
>> -	    tb[NDA_PORT]))
>> -		return -EINVAL;
>> +	    tb[NDA_PORT])){
>> +			NL_SET_ERR_MSG(extack, "DST, VNI, ifindex and port are mutually exclusive with NH_ID");
>> +			return -EINVAL;
>> +		}
>>
>>   	if (tb[NDA_DST]) {
>>   		err = vxlan_nla_get_addr(ip, tb[NDA_DST]);
>> -		if (err)
>> +		if (err){
>> +			NL_SET_ERR_MSG(extack, "Unsupported address family");
>>   			return err;
>> +		}
>>   	} else {
>>   		union vxlan_addr *remote = &vxlan->default_dst.remote_ip;
>>
>> @@ -1157,24 +1161,30 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
>>   	}
>>
>>   	if (tb[NDA_PORT]) {
>> -		if (nla_len(tb[NDA_PORT]) != sizeof(__be16))
>> +		if (nla_len(tb[NDA_PORT]) != sizeof(__be16)){
>> +			NL_SET_ERR_MSG(extack, "Invalid vxlan port");
>>   			return -EINVAL;
>> +		}
>>   		*port = nla_get_be16(tb[NDA_PORT]);
>>   	} else {
>>   		*port = vxlan->cfg.dst_port;
>>   	}
>>
>>   	if (tb[NDA_VNI]) {
>> -		if (nla_len(tb[NDA_VNI]) != sizeof(u32))
>> +		if (nla_len(tb[NDA_VNI]) != sizeof(u32)){
>> +			NL_SET_ERR_MSG(extack, "Invalid vni");
>>   			return -EINVAL;
>> +		}
>>   		*vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
>>   	} else {
>>   		*vni = vxlan->default_dst.remote_vni;
>>   	}
>>
>>   	if (tb[NDA_SRC_VNI]) {
>> -		if (nla_len(tb[NDA_SRC_VNI]) != sizeof(u32))
>> +		if (nla_len(tb[NDA_SRC_VNI]) != sizeof(u32)){
>> +			NL_SET_ERR_MSG(extack, "Invalid src vni");
>>   			return -EINVAL;
>> +		}
>>   		*src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
>>   	} else {
>>   		*src_vni = vxlan->default_dst.remote_vni;
>> @@ -1183,12 +1193,16 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
>>   	if (tb[NDA_IFINDEX]) {
>>   		struct net_device *tdev;
>>
>> -		if (nla_len(tb[NDA_IFINDEX]) != sizeof(u32))
>> +		if (nla_len(tb[NDA_IFINDEX]) != sizeof(u32)){
>> +			NL_SET_ERR_MSG(extack, "Invalid ifindex");
>>   			return -EINVAL;
>> +		}
>>   		*ifindex = nla_get_u32(tb[NDA_IFINDEX]);
>>   		tdev = __dev_get_by_index(net, *ifindex);
>> -		if (!tdev)
>> +		if (!tdev){
>> +			NL_SET_ERR_MSG(extack,"Device not found");
>>   			return -EADDRNOTAVAIL;
>> +		}
>>   	} else {
>>   		*ifindex = 0;
>>   	}
>> @@ -1226,7 +1240,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
>>   		return -EINVAL;
>>
>>   	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
>> -			      &nhid);
>> +			      &nhid, extack);
>>   	if (err)
>>   		return err;
>>
>> @@ -1291,7 +1305,7 @@ static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
>>   	int err;
>>
>>   	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
>> -			      &nhid);
>> +			      &nhid, extack);
>>   	if (err)
>>   		return err;
>>
>> --
>> 2.36.0
>>
>>
>>
