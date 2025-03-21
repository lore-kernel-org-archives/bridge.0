Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714141C72
	for <bridge@lists.linux.dev>; Fri, 21 Mar 2025 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546833; cv=none; b=duMwE0AHpCS+E888Afyn3EI06hDOShS6YkIcw3/BeN9VJYZrBVRylcUY6LStoYNqvzvCkaVWRfJrmIA86mK9JyLkiHfMsS+JIA8UK+dESUZbLYubC0uBiF/gXG2oAv+nY14l2Fov/0BqUUjCjIs1abb/cGoojK6vGSx1V62XMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546833; c=relaxed/simple;
	bh=M6FotxqtmdavVYyLKswlHnM+jqLmZsfU30b8Zccel+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6jb1mcKheMVGws2lgyhwUceJDy0fgM/NEMqu+rQGA7bavlsfwTAUolpkMCECEzPFsyjk6f7rRHMAQbEUl7Zyxm9PZSkioccY+tl5h21DQWCHWwvEHLl7urJEDRvnbF3TW4Jgq7kVisyOOYjf4yBTGDaysl/5nLKXNMrb0lkrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=L0Q78pCu; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="L0Q78pCu"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so11593235e9.1
        for <bridge@lists.linux.dev>; Fri, 21 Mar 2025 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1742546830; x=1743151630; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIPyhC1mQXfhzrv4tuYQo78989Vt+LnaUDryQAFr0iA=;
        b=L0Q78pCu63HmgqIi4mok/iX0PeWv3r65V/phxLicqHOEtx0A2pvVNua+hdNQ2P2Ywo
         AaTz6D7yFb3FQa3T27UTUIGCef3lHHHV2/nuoIdYQV+oKGzqv8io8HRpFNkxk4Eb+71l
         hiaHUer5Yc6+SPn78xYdqHYdPPbKTol+TsL3upmZxV1l1U7cF19m7cS1GUkeYQteHZSw
         Sj2knGwROcxxnDN1bA0XRXqb0HXGsOcmOfQOnJqP/a361ldQqcTw2gOzy/akJNwPoiCd
         NF/1yYUyq0FiSBJP81RrfssB8MW0hMPns1O/y8ugL0p9KzZJr5S0iiiv29WKp0IpiS4k
         0XdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742546830; x=1743151630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIPyhC1mQXfhzrv4tuYQo78989Vt+LnaUDryQAFr0iA=;
        b=nZbwFbSrs+q99lwIxpdrZk+Kw3nsIRP/bsVbOGEiFQ4u8482NR/F1317aRFI2Qu5ud
         Z5IL/BkiA2reV3Wd9bE7mT1MNG9tWHw1eKY9xwIkqC+ol4zmQnyahYKUSnCjtMSIQiQL
         4Fb0IRDTWcyhEHDLz2UMwM89cPy8n1kDRZq/rp2hH6P//yUlFsTH7ldBkpGvCI6N5amL
         kG8Z+D3EMJra0hUeiNAPP6HsCQAZXJ2+KuO12Ejt9NfFY+MZs0WBohtY5aWt65Hgq9wd
         ko3mi8fckcWMlWg46llLHfNZT0z/AIMNqGlBYQFl4/xwCM1ZsUsnuKa1LbZsXrN14RVK
         wVMA==
X-Forwarded-Encrypted: i=1; AJvYcCX1xHoeIr3FHG2vJcKBo3zXHvcdliejHVspHqxOTg+yELtOKGPoKCtQQ+hFSVshXaIAwjEMZ8g=@lists.linux.dev
X-Gm-Message-State: AOJu0YyOIll2/e/HxA2acvjg1Ogp6pxSZcgV3TVQYGSu2A2dVZsqsJVc
	z5GYoIv6Pg1gSWYJj4Xvv9K8H+WuCF36kQErr8Ns9RqVXoXcWkVbjYs/HD/JAbs=
X-Gm-Gg: ASbGncsBFaouk+PQEEFWPZzD0kqX4XLoXqOQf7EtdhgwI74YoR1zHrlGcmE+S2C8f5R
	uASMX9PM5v3r8NXQgBEXZAu/9e/zTOd3JcJFXs66AmB4/OPaj+WccXcrXhBce3t0mKzZFnPC7N8
	rDUAWiNTpsDAktNsaUUIffGRyIOhflqm0yxzfKHX0rcqu173sPusTTygbsrz3R/IrVIfORLa/SO
	/MnuB4ZCZW6tfQG71www38GkKA6g3Bsy2v/JdB2RtaKAirIyZshuU1mtw+1AQesisPx3ZTS2abo
	CCI8B81LRPFu8T6nGtYoWuuKDgcDUQtddA+y8plyKssctLAC9DKt9JDJvNzdIT9gWrd8O0e5kki
	X
X-Google-Smtp-Source: AGHT+IF5uQ2yTshrsDrGp62So7nEjMJNwK5T0pG9RVDW3pCpQP0pC5/YcQGWJV4LHQkA8pXUbJCnBg==
X-Received: by 2002:a05:600c:4684:b0:43c:eec7:eabb with SMTP id 5b1f17b1804b1-43d509eccf1mr17666555e9.8.1742546829899;
        Fri, 21 Mar 2025 01:47:09 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f76sm1794946f8f.37.2025.03.21.01.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 01:47:09 -0700 (PDT)
Message-ID: <5512ee47-37ea-41b0-86b6-efdb4a2e10c4@blackwall.org>
Date: Fri, 21 Mar 2025 10:47:08 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 0/3] Add support for mdb offload failure
 notification
To: Joseph Huang <joseph.huang.2024@gmail.com>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <039a0673-6254-45a0-b511-69d2a15aa96d@blackwall.org>
 <52b437bc-3f0e-4a5e-ae18-aea6576eb1ad@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <52b437bc-3f0e-4a5e-ae18-aea6576eb1ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/20/25 23:14, Joseph Huang wrote:
> On 3/20/2025 2:17 AM, Nikolay Aleksandrov wrote:
>> On 3/19/25 00:42, Joseph Huang wrote:
>>> Currently the bridge does not provide real-time feedback to user space
>>> on whether or not an attempt to offload an mdb entry was successful.
>>>
>>> This patch set adds support to notify user space about successful and
>>> failed offload attempts, and the behavior is controlled by a new knob
>>> mdb_notify_on_flag_change:
>>>
>>> 0 - the bridge will not notify user space about MDB flag change
>>> 1 - the bridge will notify user space about flag change if either
>>>      MDB_PG_FLAGS_OFFLOAD or MDB_PG_FLAGS_OFFLOAD_FAILED has changed
>>> 2 - the bridge will notify user space about flag change only if
>>>      MDB_PG_FLAGS_OFFLOAD_FAILED has changed
>>>
>>> The default value is 0.
>>>
>>> A break-down of the patches in the series:
>>>
>>> Patch 1 adds offload failed flag to indicate that the offload attempt
>>> has failed. The flag is reflected in netlink mdb entry flags.
>>>
>>> Patch 2 adds the knob mdb_notify_on_flag_change, and notify user space
>>> accordingly in br_switchdev_mdb_complete() when the result is known.
>>>
>>> Patch 3 adds netlink interface to manipulate mdb_notify_on_flag_change
>>> knob.
>>>
>>> This patch set was inspired by the patch series "Add support for route
>>> offload failure notifications" discussed here:
>>> https://lore.kernel.org/all/20210207082258.3872086-1-idosch@idosch.org/
>>>
>>> Joseph Huang (3):
>>>    net: bridge: mcast: Add offload failed mdb flag
>>>    net: bridge: mcast: Notify on offload flag change
>>>    net: bridge: Add notify on flag change netlink i/f
>>>
>>>   include/uapi/linux/if_bridge.h |  9 +++++----
>>>   include/uapi/linux/if_link.h   | 14 ++++++++++++++
>>>   net/bridge/br_mdb.c            | 30 +++++++++++++++++++++++++-----
>>>   net/bridge/br_multicast.c      | 25 +++++++++++++++++++++++++
>>>   net/bridge/br_netlink.c        | 21 +++++++++++++++++++++
>>>   net/bridge/br_private.h        | 26 +++++++++++++++++++++-----
>>>   net/bridge/br_switchdev.c      | 31 ++++++++++++++++++++++++++-----
>>>   7 files changed, 137 insertions(+), 19 deletions(-)
>>>
>>
>> Hi,
>> Could you please share more about the motivation - why do you need this and
>> what will be using it? 
> 
> Hi Nik,
> 
> The API for a user space application to join a multicast group is write-only (and really best-efforts only), meaning that after an application calls setsockopt(), the application has no way to know whether the operation actually succeeded or not. Normally for soft bridges this is not an issue; however for switchdev-backed bridges, due to limited hardware resources, the failure rate is meaningfully higher.
> 
> With this patch set, the user space application will now get a notification about a failed attempt to join a multicast group. The user space application can then have the opportunity to mitigate the failure [1][2].
> 

Thanks for the pointers.

>> Also why do you need an option with 3 different modes
>> instead of just an on/off switch for these notifications?
>>
>> Thanks,
>>   Nik
>>
> 
> Some user space application might be interested in both successful and failed offload attempts (for example the application might want to keep an mdb database which is perfectly in sync with the hardware), while some other user space application might only be interested in failed attempts (so that it can retry the operation or choose a different group for example).
> 
> This knob is modeled after fib_notify_on_flag_change knob on route offload failure notification (see https://lore.kernel.org/all/20210207082258.3872086-4-idosch@idosch.org/). The rationale is that "Separate value (read: 2) is added for such notifications because there are less of them, so they do not impact performance and some users will find them more important."
> 
> Thanks,
> Joseph
> 

Can we please not add features that don't have actual users? It seems you're interested
in failed attempts, so you can just add a bridge boolopt on/off switch to notify about
those events, if anyone becomes interested in all then we can extend it. Also it can
have a more specific name like mdb_offload_fail_notification instead, saying that we
notify on mdb flags change is misleading because there are more flags which can change.

Also please drop all of the switchdev ifdefs and just always have this option available
it will actually be used only with switchdev enabled so setting it in other
cases is a noop, these flags will never be seen anyway.
 
Cheers,
 Nik


