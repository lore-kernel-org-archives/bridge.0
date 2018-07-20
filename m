Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=date:user-agent:in-reply-to:references:mime-version
	:content-transfer-encoding:subject:to:cc:from:message-id;
	bh=IwiznEsaUJibKLlLE8bussJpYeQOcpAJnavdXFgV0sc=;
	b=BltK1xFnqhcwYI6WjaVxNtju+dB5hOA6MaAIPFPyrys5iC+BQlqhcTm0Rfo9VTLODm
	23Mn8MVxvtQwpE85an4hMW/p8X2aRF8/kpteapV6yiobCXy0jGrLIuSDH2LjtmEuFu1G
	xJbLmjQJycqHPxu+YPj/MWFQQo2UdBRDJjd98=
Date: Fri, 20 Jul 2018 20:14:43 +0300
In-Reply-To: <20180720085725.6dc1743d@xeon-e3>
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
	<20180720144826.29892-2-nikolay@cumulusnetworks.com>
	<20180720085725.6dc1743d@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <8D6C03E0-6596-4B5B-9B6C-5684B5DFE148@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: add support for raw
	sysfs port options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

On July 20, 2018 6:57:25 PM GMT+03:00, Stephen Hemminger <stephen@networkpl=
umber=2Eorg> wrote:
>On Fri, 20 Jul 2018 17:48:25 +0300
>Nikolay Aleksandrov <nikolay@cumulusnetworks=2Ecom> wrote:
>
>> This patch adds a new alternative store callback for port sysfs
>options
>> which takes a raw value (buf) and can use it directly=2E It is needed
>for the
>> backup port sysfs support since we have to pass the device by its
>name=2E
>>=20
>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks=2Ecom>
>> ---
>> There are a few checkpatch warnings here because of the old code,
>I've
>> noted them in my todo and will send separate patch for simple_strtoul
>> and the function prototypes=2E
>>=20
>>  net/bridge/br_sysfs_if=2Ec | 49
>+++++++++++++++++++++++++++++++++---------------
>>  1 file changed, 34 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/net/bridge/br_sysfs_if=2Ec b/net/bridge/br_sysfs_if=2Ec
>> index f99c5bf5c906=2E=2E38c58879423d 100644
>> --- a/net/bridge/br_sysfs_if=2Ec
>> +++ b/net/bridge/br_sysfs_if=2Ec
>> @@ -25,6 +25,15 @@ struct brport_attribute {
>>  	struct attribute	attr;
>>  	ssize_t (*show)(struct net_bridge_port *, char *);
>>  	int (*store)(struct net_bridge_port *, unsigned long);
>> +	int (*store_raw)(struct net_bridge_port *, char *);
>> +};
>> +
>> +#define BRPORT_ATTR_RAW(_name, _mode, _show, _store)			\
>> +const struct brport_attribute brport_attr_##_name =3D {			\
>> +	=2Eattr		=3D {=2Ename =3D __stringify(_name),			\
>> +			   =2Emode =3D _mode },				\
>> +	=2Eshow		=3D _show,					\
>> +	=2Estore_raw	=3D _store,					\
>>  };
>> =20
>>  #define BRPORT_ATTR(_name, _mode, _show, _store)		\
>> @@ -270,27 +279,37 @@ static ssize_t brport_store(struct kobject
>*kobj,
>>  	struct brport_attribute *brport_attr =3D to_brport_attr(attr);
>>  	struct net_bridge_port *p =3D to_brport(kobj);
>>  	ssize_t ret =3D -EINVAL;
>> -	char *endp;
>>  	unsigned long val;
>> +	char *endp;
>> =20
>>  	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
>>  		return -EPERM;
>> =20
>> -	val =3D simple_strtoul(buf, &endp, 0);
>> -	if (endp !=3D buf) {
>> -		if (!rtnl_trylock())
>> -			return restart_syscall();
>> -		if (p->dev && p->br && brport_attr->store) {
>> -			spin_lock_bh(&p->br->lock);
>> -			ret =3D brport_attr->store(p, val);
>> -			spin_unlock_bh(&p->br->lock);
>> -			if (!ret) {
>> -				br_ifinfo_notify(RTM_NEWLINK, NULL, p);
>> -				ret =3D count;
>> -			}
>> -		}
>> -		rtnl_unlock();
>> +	if (!rtnl_trylock())
>> +		return restart_syscall();
>> +
>> +	if (!p->dev || !p->br)
>> +		goto out_unlock;
>> +
>> +	if (brport_attr->store_raw) {
>> +		spin_lock_bh(&p->br->lock);
>> +		ret =3D brport_attr->store_raw(p, (char *)buf);
>> +		spin_unlock_bh(&p->br->lock);
>> +	} else if (brport_attr->store) {
>> +		val =3D simple_strtoul(buf, &endp, 0);
>> +		if (endp =3D=3D buf)
>> +			goto out_unlock;
>> +		spin_lock_bh(&p->br->lock);
>> +		ret =3D brport_attr->store(p, val);
>> +		spin_unlock_bh(&p->br->lock);
>> +	}
>> +	if (!ret) {
>> +		br_ifinfo_notify(RTM_NEWLINK, NULL, p);
>> +		ret =3D count;
>>  	}
>> +out_unlock:
>> +	rtnl_unlock();
>> +
>>  	return ret;
>>  }
>> =20
>
>I see where you are going with this=2E You want a sysfs attribute where
>is a string
>not a number=2E This makes sense=2E
>
>The code might be simpler if you always acquired  the lock=2E Or maybe
>move the locking into the store functions=2E
>

I considered that but wanted to limit the lock because it blocks learning=
=2E=20
Since the operations are relatively simple I'll move it earlier=2E


>Casting away the const on the buf variable is going to cause warnings
>and should not be necessary=2E
>

It doesn't when it's casted like that, the new line is changed to null byt=
e so we need to drop=20
the const=2E

>You might also want an error case if neither store or store_raw are
>defined=2E

It is already there, just try writing to any other attribute that doesn't =
have store=2E



