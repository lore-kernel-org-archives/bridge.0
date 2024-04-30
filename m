Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F8176FA3
	for <bridge@lists.linux.dev>; Tue, 30 Apr 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494480; cv=none; b=SDHobfPmAKZ4ZvgIEPgxw0rWFP5bqQNsT8Px53quSeRZMh+lE6TVGF1GZzkKnTM5Csz1wa1/+WA/RDdfELqZ4aiHSj4j3TBxd0TJSJBkhiBEhwdBymjOZpNHUl5JZ+cVznJx+U415hEC5RyfD5CtembTfETWgZ7W2ezt2fiGPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494480; c=relaxed/simple;
	bh=rJDlPb4ASLQZZzLVdH8uAuINKNXrJtAZBRgiHy9ePlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMBzNNI7cmrO93NDPoKrCEUeaBlBmdGdC5QKoqwgE74O0skYtvbGuMoM/glUARAsLyGWu4UOFX1L3qkYPPIa00ire4joWPXQqzqS4i/zwy5uU4UG5UbItGyAqWQ2/xIQPuJOQdm+Rl51S63PV3jOIQ9/24JLdm3U/HK7HbdGXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A76JsK49; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A76JsK49"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-61be4b986aaso19270117b3.3
        for <bridge@lists.linux.dev>; Tue, 30 Apr 2024 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494477; x=1715099277; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WyUpI+bsqZm6dktATA64nmoLL6nMTXAlQcvkjd29RmE=;
        b=A76JsK499mbzPao/DG92lETckD7dMHq3T/Ri/AH3WF0S4379lbzEkTuPampslcPsYX
         DkxQiRq4cuYLH8u9zl3Xm6j/R337LduGVyj67qoUMgCBxbZuTVTiOJClR51e45KEBCaL
         UC7W66YmadafVVjhftRHR/yUefwAH8zEUzd6R4JxQeyze9z70DB81z3qfn+EsGcEZjut
         Ib6ics7vm+KPDQCogr8REoDkgI2DFqCW1S/KZkDheesSoNcN4ridp9L1E5IY2I6YGp05
         eMIEy76jtSyEgomBs/kqb3ROQDC8uWhdjTk+8HBePUdq9DOEyr4nE9n6vZKEnJV7gxEd
         ZYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494477; x=1715099277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WyUpI+bsqZm6dktATA64nmoLL6nMTXAlQcvkjd29RmE=;
        b=VH9+k/SdG5Y5lM9khuOByy/znDR9PRLdi2MEDtMWAVYZ+Qm/uL+u2ywv4pK06OAIVP
         sefyz2WSL2db0k8AxvSFyqtMoPN0rHzUPyQRmt5KKPCJHRv0pF3UyKmehWmdN400h9J2
         9zl+ecb0dzo3FBGiR8AbMLMnDg2Sd5ODMrMNy/Z4c2ZRFfISB/J00uCSJYZQ58hsgG9J
         keEiyFSsqSCr4Vaot7F59LgVfl5cl747fIQ1/Q8koyAYyu4uLqABTrWHxw0srxVxNaHf
         6earCPt6p6jLfQM5Sk1ioi8iYFhVXFeBO/UVaiv+tLE3aI+CYmsVeKJ75g0Dr8h8CJ4H
         wf9g==
X-Forwarded-Encrypted: i=1; AJvYcCVODDbvSlqjusiLQEuLfyxHNXKOHO6bNwLiusy3nS5JD5QpuoV/GwrN7PIzdGoNveCJdM1b2SehK+eIBbOWiphsQgWk8GRC
X-Gm-Message-State: AOJu0YxKII+D2h7wUErLbkIC3d6NCfk8979r1dUcpt7EIK+IyLDi2crk
	mEAAdO6hYKTQn3LQO9lXnUpR/Ol1qdnHPIGGn6+ytBabAKqsYUmP
X-Google-Smtp-Source: AGHT+IGADJ9TPHQXgX8QG0yNVqQqugF1S2ZYflRqjNxJMWbb6ZPENPYsOth6IjtWdpdVyNs/gg2k4A==
X-Received: by 2002:a05:690c:b9b:b0:61a:e50c:1940 with SMTP id ck27-20020a05690c0b9b00b0061ae50c1940mr87426ywb.7.1714494477383;
        Tue, 30 Apr 2024 09:27:57 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id n129-20020a817287000000b0061bed877011sm235745ywc.68.2024.04.30.09.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 09:27:56 -0700 (PDT)
Message-ID: <f5ca9b38-3729-49a1-b221-fcc3aecba5d6@gmail.com>
Date: Tue, 30 Apr 2024 12:27:56 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb
 objects
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-8-Joseph.Huang@garmin.com>
 <20240402122343.a7o5narxsctrkaoo@skbuf>
 <b5f79571-b4a8-4f21-8dc8-e1aa11056a5d@gmail.com>
 <20240405110745.si4gc567jt5gwpbr@skbuf>
 <c4f5c444-832c-4376-845f-7c28e88e4436@gmail.com>
 <d36e2b82-0353-4c9c-aa89-22383c3bda2b@gmail.com>
 <20240430005949.44lcegwhmcetpddm@skbuf>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20240430005949.44lcegwhmcetpddm@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/2024 8:59 PM, Vladimir Oltean wrote:
> On Mon, Apr 29, 2024 at 06:07:25PM -0400, Joseph Huang wrote:
>> Something like this (some layers omitted for brevity)?
>>
>>                                        +br_iterator
>>                                        |  for each mdb
>>                                        |    _br_switchdev_mdb_notify
>> rtnl_lock                             |      without F_DEFER flag
>>   |                                    |      |
>>   +switchdev_port_attr_set_deferred    |      +switchdev_port_obj_notify
>>     |                                  |        |
>>     +dsa_port_mrouter                  |        +dsa_user_port_obj_a/d
>>       |                                |          |
>>       +mv88e6xxx_port_mrouter----------+          +mv88e6xxx_port_obj_a/d
>>                                          |
>>   +--------------------------------------+
>>   |
>> rtnl_unlock
> 
> At a _very_ superficial glance, I don't think you are properly
> accounting for the fact that even with rtnl_lock() held, there are still
> SWITCHDEV_OBJ_ID_PORT_MDB events which may be pending on the switchdev
> chain. Without a switchdev_deferred_process() flush call, you won't be
> getting rid of them, so when you rtnl_unlock(), they will still run.
> 
> Even worse, holding rtnl_lock() will not stop the bridge multicast layer
> from modifying its br->mdb_list; only br->multicast_lock will.
> 
> So you may be better off also acquiring br->multicast_lock, and
> notifying the MDB entries to the switchdev chain _with_the F_DEFER flag.

Like this?

                                       +br_iterator(dsa_cb)
                                       |  lock br->multicask_lock
                                       |  for each mdb
                                       |    br_switchdev_mdb_notify
rtnl_lock                             |      |
  |                                    |      +switchdev_port_obj_._defer
  +switchdev_port_attr_set_deferred    |  unlock br->multicast_lock
    |                                  |
    +dsa_port_mrouter                  |
      |                                |
      +mv88e6xxx_port_mrouter----------+
                                         |
  +--------------------------------------+
  |
rtnl_unlock

(potential task change)

rtnl_lock
  |
  +switchdev_deferred_process
  | flush all queued dfitems in queuing order
  |
rtnl_unlock

I'm not that familiar with the bridge code, but is there any concern 
with potential deadlock here (bewteen rtnl_lock and br->multicast_lock)?

> 
>> Note that on the system I tested, each register read/write takes about 100us
>> to complete. For 100's of mdb groups, this would mean that we will be
>> holding rtnl lock for 10's of ms. I don't know if it's considered too long.
> 
> Not sure how this is going to be any better if the iteration over MDB
> entries is done 100% in the driver, though - since its hook,
> dsa_port_mrouter(), runs entirely under rtnl_lock(). >
> Anyway, with the SWITCHDEV_F_DEFER flag, maybe the mdb object
> notifications can be made to run by switchdev only a few at a time, to
> give the network stack time to do other things as well.


