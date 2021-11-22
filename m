Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkqXOICDwkvy3Uv45WLrn0veTuvdTBs8UNmAEkNg4Rk=;
 b=r/l+M3N+741p2oJQYbNRDztQO0qwoR9YyLJ9Dp5qoS6fRL+vxKSMxe+LmuL1UN4WR5crZG5KDBHQ6q9og1w62SkrCzsbq5dq8OYOhsLS3PzFiY/h2oUSgW6U21Owp2uRD4ADQoJw+ys9WayQhqFKNLlOf8vxRMt5Lu4u/p2grMX8zyxL1tYvdnbDFYbEVl25n1WQvh+fMe+zvv6ffqoiwbAtmxhQoa/KLs9yUZcvHIXJL15KdmO9lMwtowHEesnOZvkoGivtZwdhAbdUszMT/1ASV57W/N+AfHqWQQWO5M2wOloFx37h7iat2pgxeLUNmgFLYm2UQqthA6PPs99OHA==
Message-ID: <f98615d9-a129-d0b0-e444-cb649c14d7ce@nvidia.com>
Date: Mon, 22 Nov 2021 12:17:39 +0200
Content-Language: en-US
References: <20211119020642.108397-1-bernard@vivo.com>
 <YZtrM3Ukz7rKfNLN@shredder>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <YZtrM3Ukz7rKfNLN@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] net/bridge: replace simple_strtoul to kstrtol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, Bernard Zhao <bernard@vivo.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On 22/11/2021 12:04, Ido Schimmel wrote:
> On Thu, Nov 18, 2021 at 06:06:42PM -0800, Bernard Zhao wrote:
>> simple_strtoull is obsolete, use kstrtol instead.
>>
>> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>> ---
>>  net/bridge/br_sysfs_br.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
>> index d9a89ddd0331..11c490694296 100644
>> --- a/net/bridge/br_sysfs_br.c
>> +++ b/net/bridge/br_sysfs_br.c
>> @@ -36,15 +36,14 @@ static ssize_t store_bridge_parm(struct device *d,
>>  	struct net_bridge *br = to_bridge(d);
>>  	struct netlink_ext_ack extack = {0};
>>  	unsigned long val;
>> -	char *endp;
>>  	int err;
>>  
>>  	if (!ns_capable(dev_net(br->dev)->user_ns, CAP_NET_ADMIN))
>>  		return -EPERM;
>>  
>> -	val = simple_strtoul(buf, &endp, 0);
>> -	if (endp == buf)
>> -		return -EINVAL;
>> +	err = kstrtoul(buf, 10, &val);
> 
> Base 16 is valid.
> 
> Before this patch:
> 
> # ip link add name br0 type bridge vlan_filtering 1
> # echo "0x88a8" > /sys/class/net/br0/bridge/vlan_protocol
> # echo $?
> 0
> 
> After this patch:
> 
> # ip link add name br0 type bridge vlan_filtering 1
> # echo "0x88a8" > /sys/class/net/br0/bridge/vlan_protocol 
> bash: echo: write error: Invalid argument
> 

Good catch, Bernard please send a revert. Thanks.



