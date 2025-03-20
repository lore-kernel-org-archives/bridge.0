Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764AD1E5B7E
	for <bridge@lists.linux.dev>; Thu, 20 Mar 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742505263; cv=none; b=cikWlw817hjt3TzST78g+v55nCw3krYh6smsz2tnRO6f42pO4KBNVi0ttHJt+Eq5U6uIOHhEUwmoy4/j082mXHtP7nCFwovb8dImCSwz0JWElnNBgYhK7cj1gKa/3Lp32qX9uA5d9Tgz6yIwgVF3PEjwog5rPYQGa6YdphcnA5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742505263; c=relaxed/simple;
	bh=rDnOAA4lucrldV/uOPZAcMt+11QMeVvynKOYtUfZiVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYt0AalbpmelyfNCC/LQjcbqomedZToB6B7gPt5svKos9qoT/w0kdxIQ3mtVAcUgWFP7e8gW01K7Nd1WUpQT75mXkdfwoep3La9IJu6AsVyk7M+m4q/9ZzqFkFu1FTHsoW0RQox9me7r5uy3mGE5dr0Bh1/qwhCX1OuGCLSz1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMVLeIK8; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMVLeIK8"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6ff37565154so12479077b3.3
        for <bridge@lists.linux.dev>; Thu, 20 Mar 2025 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742505260; x=1743110060; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vR0a3RR/t05HfQIX2qz1HHcu0hel3X1oYKiWEBUqDO8=;
        b=FMVLeIK8BYnenMGpIgvNqMYX6UGjO2ByY72iE2UXWRzxXXqPpEo8DzynQVOlCX67ms
         8a3YjoPqGtXzdKjSRjFFbaLpmoYLlLAcfVyoy2SsB1KuHo9h8IGv3RoYnEMTsPFLrL1l
         M6vF2mvFguf2cOXdcwB03uvvcm2y6hz3Ydv7SjOQWYxmMxkHdaJxnu1WNkcPe9+A72Rp
         AwZdIpfSCok/vgk2kzItwfhNqFfTFSNTeNq0qD/41awmIgXCUcPuW9FqRCA+1gP/pz6W
         s5yddkUz26feq83Q+8Dhk9nbQLh6PIVloSdpbvogCFGjspLFg21oG/o6E181S5YOwscu
         Ez2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742505260; x=1743110060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vR0a3RR/t05HfQIX2qz1HHcu0hel3X1oYKiWEBUqDO8=;
        b=N0iLmqOpbntMnwhEVgf0mmy0cPiuoIWCC7pgrGTQtxrd4hDuH9T2kKDHyy/K3fytYB
         TTnpy8DhLNAqmNgI4QpJtd6CEETfunRlZoLckPCcUcNMdr7EUe9Cz8h8Rp5A47lLIaxF
         AVyOm44KzIi5gBF6+vkVHuPUJbHVAxpD8/8vjCSH19SFSaOFnvmmwrE3lkXSYBJPe9LS
         83z9134RdmVgMXVIZGSp4zsFChxc6Q4SkkE1sJ6Rp9U9/253cbFJrv2VDrJ+9Q0CxV18
         ePq6S//FqAB6Nc6PGck2LcXu+LD215f4q6u90nbzfnfqXYpR9OugHUq4IAc4AQJwddav
         gEiw==
X-Forwarded-Encrypted: i=1; AJvYcCXWGwx317pBIqBZZXoQKni2LCRgkXA3iAOJuJvWlkLV338NKaAh8m+qFtrKiw6uROwdbeJIpf0=@lists.linux.dev
X-Gm-Message-State: AOJu0YyzjnAa9nmMfTVmC2z/+K2OgM5DSqNAco4SDBrZpqazMVHgNdZ/
	kkuxUSbbCzPoNx7GFIArlu4MVighbJ7GslUpQBwrP+bKC3Qtc8W8
X-Gm-Gg: ASbGnctSv1Zc6KpOaOvn3VqVHf2ZGlCk1oM//zwRTseA7JuCaV2AczVXL7Ujswa3qLL
	8J2pK1+2ZJFIsNsJMDbDce069PGmOMNd/isznl9iZUiE0mZBqLbx4ft8jL9aN3eWPnCVYNdKTe+
	+A9/NUGCKcjsTEXQ/yP8Vuyws6upihwq8tGTDYX26MM8k1CHUor2a9rLT3Xpmok+LSj9uNdqv8b
	I/fMwFgiqJoLrjyOoE9wFLMaygU6ij6ZupieqcgZpzcM8+QE29AM4PxWCVHSr5Rfb16qdexlaUR
	g2MCgoy6x6nPmn2KKW5u8NVNC+L2Rj7WdEKLUPLOg9RneMMRZCBwGSjxZH7abrZMzVS1BYCoVHr
	X6w==
X-Google-Smtp-Source: AGHT+IE3vy33qwuh10B1jPT96uPQFPJ0L0/5fq+sJdaJhhmDghj5RFArk99tKxN3tnEQGZjxTVWlEg==
X-Received: by 2002:a05:690c:3806:b0:6fb:9b19:ab49 with SMTP id 00721157ae682-700babfd37amr13100057b3.6.1742505260028;
        Thu, 20 Mar 2025 14:14:20 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba8c6b86sm980607b3.121.2025.03.20.14.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 14:14:19 -0700 (PDT)
Message-ID: <52b437bc-3f0e-4a5e-ae18-aea6576eb1ad@gmail.com>
Date: Thu, 20 Mar 2025 17:14:19 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 0/3] Add support for mdb offload failure
 notification
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <039a0673-6254-45a0-b511-69d2a15aa96d@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <039a0673-6254-45a0-b511-69d2a15aa96d@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/2025 2:17 AM, Nikolay Aleksandrov wrote:
> On 3/19/25 00:42, Joseph Huang wrote:
>> Currently the bridge does not provide real-time feedback to user space
>> on whether or not an attempt to offload an mdb entry was successful.
>>
>> This patch set adds support to notify user space about successful and
>> failed offload attempts, and the behavior is controlled by a new knob
>> mdb_notify_on_flag_change:
>>
>> 0 - the bridge will not notify user space about MDB flag change
>> 1 - the bridge will notify user space about flag change if either
>>      MDB_PG_FLAGS_OFFLOAD or MDB_PG_FLAGS_OFFLOAD_FAILED has changed
>> 2 - the bridge will notify user space about flag change only if
>>      MDB_PG_FLAGS_OFFLOAD_FAILED has changed
>>
>> The default value is 0.
>>
>> A break-down of the patches in the series:
>>
>> Patch 1 adds offload failed flag to indicate that the offload attempt
>> has failed. The flag is reflected in netlink mdb entry flags.
>>
>> Patch 2 adds the knob mdb_notify_on_flag_change, and notify user space
>> accordingly in br_switchdev_mdb_complete() when the result is known.
>>
>> Patch 3 adds netlink interface to manipulate mdb_notify_on_flag_change
>> knob.
>>
>> This patch set was inspired by the patch series "Add support for route
>> offload failure notifications" discussed here:
>> https://lore.kernel.org/all/20210207082258.3872086-1-idosch@idosch.org/
>>
>> Joseph Huang (3):
>>    net: bridge: mcast: Add offload failed mdb flag
>>    net: bridge: mcast: Notify on offload flag change
>>    net: bridge: Add notify on flag change netlink i/f
>>
>>   include/uapi/linux/if_bridge.h |  9 +++++----
>>   include/uapi/linux/if_link.h   | 14 ++++++++++++++
>>   net/bridge/br_mdb.c            | 30 +++++++++++++++++++++++++-----
>>   net/bridge/br_multicast.c      | 25 +++++++++++++++++++++++++
>>   net/bridge/br_netlink.c        | 21 +++++++++++++++++++++
>>   net/bridge/br_private.h        | 26 +++++++++++++++++++++-----
>>   net/bridge/br_switchdev.c      | 31 ++++++++++++++++++++++++++-----
>>   7 files changed, 137 insertions(+), 19 deletions(-)
>>
> 
> Hi,
> Could you please share more about the motivation - why do you need this and
> what will be using it? 

Hi Nik,

The API for a user space application to join a multicast group is 
write-only (and really best-efforts only), meaning that after an 
application calls setsockopt(), the application has no way to know 
whether the operation actually succeeded or not. Normally for soft 
bridges this is not an issue; however for switchdev-backed bridges, due 
to limited hardware resources, the failure rate is meaningfully higher.

With this patch set, the user space application will now get a 
notification about a failed attempt to join a multicast group. The user 
space application can then have the opportunity to mitigate the failure 
[1][2].

> Also why do you need an option with 3 different modes
> instead of just an on/off switch for these notifications?
> 
> Thanks,
>   Nik
> 

Some user space application might be interested in both successful and 
failed offload attempts (for example the application might want to keep 
an mdb database which is perfectly in sync with the hardware), while 
some other user space application might only be interested in failed 
attempts (so that it can retry the operation or choose a different group 
for example).

This knob is modeled after fib_notify_on_flag_change knob on route 
offload failure notification (see 
https://lore.kernel.org/all/20210207082258.3872086-4-idosch@idosch.org/). 
The rationale is that "Separate value (read: 2) is added for such 
notifications because there are less of them, so they do not impact 
performance and some users will find them more important."

Thanks,
Joseph

--

[1] 
https://datatracker.ietf.org/doc/draft-ietf-pim-zeroconf-mcast-addr-alloc-ps/, 
section 2, the last paragraph
[2] 
https://datatracker.ietf.org/doc/draft-ietf-pim-ipv6-zeroconf-assignment/, 
section 2.1, the first paragraph
