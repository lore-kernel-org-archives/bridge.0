Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC13F412D
	for <bridge@lists.linux.dev>; Wed,  2 Sep 2026 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353503; cv=none; b=frNU5t3sE5b5/lO/475r1jiZu8A7CBvda8LfGriTlt8oRTYu65kg/5krPQl1/X40hUTts5NYAUGv47bokz9g4SWpVpl9YNl62yssMxv9NS/SwN94RkYXrndFc3OEwQAFEsDUem4gn11r9LnvscjIjzNMg0XKsXkilJ7hcnyfhoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353503; c=relaxed/simple;
	bh=Gg+4rRp/Qi2XDpyS1c2FX4MhFGl1KgseWlnE4lP3Yj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0ksov9tZ036/uvzqpvWwT4fje0LtVxCYYG/Pel5iIffH3Lhv5wUHQqyNqvf/f7eC4tbHyP+dDwJ7HiZ6MhSYFEpLxEX+tIaccZLJXh+AvUQ9chQIp0bFOy2qJq3GTELmWuXkCqbMdEa7WZd/xgeJpJt9d9B0H3jbJPtL4c2irQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=EGOW2m8Z; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="EGOW2m8Z"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-485538d3499so593364f8f.0
        for <bridge@lists.linux.dev>; Wed, 02 Sep 2026 05:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788353498; x=1788958298; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r/ZcwH8ZRW0EEjJcn1cLNCRw5OdPHU7AFoMVmArvcNw=;
        b=EGOW2m8Zgn8N9iH4cPWcErgP/gw0lJT2Pk66VXOXYIHXk2f8bkmlY5MFgdFvT651Bl
         MkpZEYyjsZvabd9lQP/hwtUN/55qauv+H7ICrq21v0lyrlS7BDK/xmap83ew27srvdVi
         yuBKKaYCqBdQIosiFdeZaGw/yXyD+t1NiusOJM7iasZmqkCU67KHsglwl47579RsW9LR
         SfD0y0l+bdy8Uyen509B7W8e5duOn8079y3gvGfkzEhirDZCF9cUwbXF59vt7iXlRLeo
         Uy9fj6TMT4LO/7aLr3dJS2SjJk49yJkzUE53VmPQS6kmOLx051ZXsvoVjMrHE6g/jbj+
         +e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353498; x=1788958298;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/ZcwH8ZRW0EEjJcn1cLNCRw5OdPHU7AFoMVmArvcNw=;
        b=IwMcPrw8VnUaf44OB5tdHGOay5P8pU9evN2FQ4FR8EBTNN4ZdxjltNhD807RU/z3gY
         MbUG/2q+Xss/2uOPhZOgzfIWegHkMLmSys9rOV1LVlEbAlRnBokIHCvOMDdKyHF+h5Wc
         FwP4l5emadVhinpO/vJPXzMKd/GJefTDl1lEntdOSCaQWT7ER9gCYaBOKvQb/Y8kASUq
         tFhE5w2qMbHOW9ksSqGupubuPqtI6liKG1HWRruZoyHk69Q3QSkcWy3m2pfLaa6R8Jb5
         pfCij+mk2k0+r3SIRQwCkWdeUJYNTjJIM/x0B4mrxe4xEUbxPwkowOAuGHLGYzkpUqaC
         0hug==
X-Forwarded-Encrypted: i=1; AKwUvBzok6dac0OqbS11/YqQ1R3L0EQLo1jekgHkB/mL/BW3MVqOQ13Fy5ejeSTU9cXjKceEGwPYghA=@lists.linux.dev
X-Gm-Message-State: AFuF++mTh8sl+iSMBiXjuR0pRrFk5+WN6h8q2fx1ewwJMlplY8w0e/G3
	9qzZl5wFOr8sz6FmAXLLNwpzRDPwUqhgYSy7dourjHPd9wjbIfkgXKg3TZjft4U826M=
X-Gm-Gg: AYBFou3E3ycHdhcklUxTKzZM/0S6/pux8Sv12sjTmJHIirc5ri/HcaD/Rb+p0M7OvQ/
	ZmwNPiVqnFQmqIK2aeToxHAs2w0PNjJ+y90hSe3dijHiOKNwPbQVU3fP8V6WjSX4nu7M1rnRHQn
	ZuysoH61OmCmetcJDqYRxB55agPcEiPrYUQwFr9vE8kz33jJTG1l8fgB4N9gc6zdNlIIXg1taT4
	FAF1a9mPZzFkB8ztRMdoLEoLbIjtgQJOio+T4y8x1athvoTLLXjTA6LHWE6dHWeqAwnwt9lSZdt
	s5u3oBYdpKGzvVVd8egwccMrzIMXxkvlKvu8zSYLIPox1aUtzmWFKXMIf3bczYmgvfsd5VvQcH3
	0dkDeSKGk2fcJ4tE1d0VThirs4rDqszsgXqqLiR/3luolt2SiDclP37ehUuN3f2PdqO3D4tgdmH
	v/bmY47rP/SgwBS/kotJJbLhecBkpxcv0QvWbQ0LUUJ5Uo0HOSQjNrG4f1DcL5KILOC+cuf0Dz7
	EJcv6c/R50tKnoMlVk=
X-Received: by 2002:a05:6000:310b:b0:482:e4bc:51b3 with SMTP id ffacd0b85a97d-48488deb735mr7314605f8f.1.1788353497400;
        Wed, 02 Sep 2026 05:51:37 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e7f8f9sm6318171f8f.9.2026.09.02.05.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:51:36 -0700 (PDT)
Message-ID: <1df834f1-cdf8-4b1a-aae6-a86c74278509@blackwall.org>
Date: Wed, 2 Sep 2026 15:51:35 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,v2] net: bridge: mcast: fix br_multicast_list_adjacent rcu
 walk of mglist
Content-Language: en-US, bg
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linus.luessing@c0d3.blue, bridge@lists.linux.dev
References: <20260901074046.316190-1-razor@blackwall.org>
 <178835300671.3394541.1735736223580358438@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <178835300671.3394541.1735736223580358438@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/09/2026 15:43, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] net/bridge/br_multicast.c:br_multicast_list_adjacent() now
>    performs the entire per-port mglist walk, including one…
> 
> --
> 
> net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist
> 
> The patch converts the mglist walk in br_multicast_list_adjacent() from an
> RCU walk to one done under the bridge's multicast_lock, since mglist was
> never converted to RCU.  It also makes the function return -ENOMEM on
> allocation failure and documents that in the kdoc.
> 
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com
> 
>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>> index 3ef5d8bbf552e..97686984de6d5 100644
>> --- a/net/bridge/br_multicast.c
>> +++ b/net/bridge/br_multicast.c
> 
> [ ... ]
> 
>> @@ -4967,15 +4969,20 @@ int br_multicast_list_adjacent(struct net_device *dev,
>>   		if (!port->dev || port->dev == dev)
>>   			continue;
>>   
>> -		hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
>> +		spin_lock_bh(&br->multicast_lock);
>> +		hlist_for_each_entry(group, &port->mglist, mglist) {
>>   			entry = kmalloc_obj(*entry, GFP_ATOMIC);
>> -			if (!entry)
>> +			if (!entry) {
>> +				spin_unlock_bh(&br->multicast_lock);
>> +				count = -ENOMEM;
>>   				goto unlock;
>> +			}
>>   
>>   			entry->addr = group->key.addr;
>>   			list_add(&entry->list, br_ip_list);
>>   			count++;
>>   		}
>> +		spin_unlock_bh(&br->multicast_lock);
>>   	}
> 
> [Severity: Medium]
> How long can this critical section get?  The whole per-port mglist walk,
> including one kmalloc_obj(*entry, GFP_ATOMIC) per port group, now runs with
> br->multicast_lock held and bottom halves disabled.
> 
> The number of allocations inside the section equals the length of
> port->mglist, which is only bounded by br->hash_max in
> br_multicast_new_group():
> 
> net/bridge/br_multicast.c:br_multicast_new_group() {
> 	...
> 	if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
> 	...
> }
> 
> hash_max defaults to BR_MULTICAST_DEFAULT_HASH_MAX (4096) and can be set to
> any u32 without validation via netlink
> (br->hash_max = nla_get_u32(data[IFLA_BR_MCAST_HASH_MAX]) in br_netlink.c)
> or via set_hash_max() in br_sysfs_br.c.  The list contents themselves are
> populated by IGMP/MLD reports from hosts on the bridged L2 domain.
> 
> While the lock is held, every other CPU that needs br->multicast_lock spins
> for it, including the br_multicast_rcv() receive path, the group and query
> expiry timers and br_multicast_port_group_rexmit().  Before this change the
> loop only held rcu_read_lock(), so a long mglist slowed the caller but did
> not block bridge multicast processing.
> 
> The caller is periodic, so this is not a one-off:
> 
> batadv_mcast_mla_update()
>    __batadv_mcast_mla_update()
>      batadv_mcast_mla_bridge_get()
>        br_multicast_list_adjacent()
> 
> which runs every BATADV_MCAST_WORK_PERIOD (500 ms) from the batman-adv
> workqueue.
> 
> Would it be preferable to bound the section, for example by pre-allocating
> the entries outside the lock, or by dropping and re-taking the lock in
> batches, rather than holding a bh-disabling spinlock across up to hash_max
> slab allocations?
> 

Oh please, enough with this shit. This is taking way too much time for a function
that is largely useless.

I will just convert it properly to RCU in -net and be done with this.

