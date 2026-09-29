Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919B3A9017
	for <bridge@lists.linux.dev>; Tue, 29 Sep 2026 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667852; cv=none; b=A9fZzJzdSayrqP1UVtzgTYwjtpSCvHgEY9t30kodFKFSWyOzwWHdUU8zAKcsdGIjWkBWCcsK/7WvGU01SEhVgOMdgn9iGpLkHQwl/RKVinMwY+yTizoRB2n89TDClhjaEdBDX1sX6tigmnlZY4k2wzYv+T5hi2KMxUgcgDH+krU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667852; c=relaxed/simple;
	bh=Z4HLh6x3TXcq+IGnxeku780VsScevwodu7+asM0q/T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rlcs6Ni4WaufILLh51QvQJ8ZnoZybkoUHoI/gyLxpiYxlYKYPALlvtC9wtrhoumEUKKUUuZLjfeN2xODXB1U2YkFxTLr4FuISHLFUNd168CP3mD2S7aH8piL1NsvibpCpgK4kNjhIOur1Q63zPq6NVCHifu8tK4dxHD4VYbftrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=fr5B4Dha; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="fr5B4Dha"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so20709335e9.0
        for <bridge@lists.linux.dev>; Tue, 29 Sep 2026 00:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790667848; x=1791272648; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D1gEgNNUIuRxKLIUuOnRgjSxzo/gFqBNwHA7M+ft3uk=;
        b=fr5B4DhaMIg9yTTYUKwpIP/SkOOKUtAb2JUB4W7e+TT8mXIQC5VDC/neSi11Tk64Ng
         nm4mQWqSJrWQFH1cSjzBhU9Ox3aGRU8IR9H2mIHzmD/x/5Ur2Rvn0/ikv6tP2IhdOG2Q
         7uqP9JADQjI+UpcXo3aDl26BUxdFwkA6Jwl0W0piqeYzLyMZ5zzDXCyA0nvCF+VHlTrS
         MNubiV8ZgeQCRnGcxiVJ8AidDth695LMPKK9lJJaSKQ9xTBrAYS/MeUak9GVkMLdcIXP
         o4xVUFln2d2FaeikQfN4Uy8v4o596ZIKRUbAvZVYlT6v2hNd9JlqfSHdyYTCmVP/Az/g
         6PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667848; x=1791272648;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D1gEgNNUIuRxKLIUuOnRgjSxzo/gFqBNwHA7M+ft3uk=;
        b=Y75g5DoV2YYUr9MjeFNZOWu0mllU+5/Ahm1zWrqjz0kf6HZKEbxHH0JNXky82RXezz
         /v8Y7IMHM+PbdIbyxGcekzDGz5gZTAjnNFBMuB3IDzYZvKYrIRheLJYMDZlXnnbHy6iO
         1+XrwFmHtNKeZ7ywyIVkRzRr1AWmVYH/7phf+bhxLobD6Qz9EMKfhPnF47m8UUbLVu0g
         0WzCigxKs9H7pWe+W6+D/OsVNeeF4w6c6UH1PMl6nJm1crTZsmnaIZoqOZQWH7hSjvFl
         pqF5eqiqB6rkIoSiMgRqRjD/aRgax/KSYCztp38xFx/AhD6GJayk627XupHsBGxh/uV9
         0w3w==
X-Forwarded-Encrypted: i=1; AKwUvBxyj2B21ObaFh1iBy91TfgFIJfvyEaie2KAJL7JBZz1IqeqpnX/PhtvttNQvXzc8xDviqFSseo=@lists.linux.dev
X-Gm-Message-State: AFuF++lCszfURG2UC62kgiZ+eJNWZtPY3ntngbmhth/TFJNJ5voXWDDZ
	kODa1E4aOttpyfEVTfb4a0egI0kgtvU+0pyYHhg7GZL7uxEwDs7Fy4iUKyoo1Kd7SgE=
X-Gm-Gg: AYBFou0ea5tTTsn6EeaZFvj5w2tTZAA6SyekQuwoen/lF90ZIPtELRfuo/YgWknVtXS
	RmOzbxzNcTFmaetj1+RrzW/o0DQ5NeNwaNpGNkdIBmTsyr6AYwmJYKS73sx/F7rxscw4yelkEtW
	Jks62alSuays0h3t3r18TjoR5TVw7IcmP70rGxeEng7PCODbbeq+PM0WfPtdtXbg0gFcvWSEnPo
	9rhDVZmi73oGw3ADx5acBsQIE4IRPSOO3mSihb3Y3cny/aSxsByY36klLpIdG483X4IIbgws4+j
	ozQC5m1h/J1f0is12t/3hMa9WsecvroL2LKUNK7P8HwnKGHg4hP7luIjzV3PgQAKyLqCv51s8rS
	CXrK01y7BTI2OSvko354WA7RHRUYEleAYHRIC6NjpwHRh4G8JY9X9cH9dcrEHa+s7in7pnghFab
	P+3J0vLEjoCrbcdUIM8ADMUXDqpMej+pWYME/rydiRbkqVnrUTiaaSeGZQ14cFe6dCGX9XP79z1
	rlumFzWPU/nSgUG2fBJi5QUj69m
X-Received: by 2002:a05:600c:870c:b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-49fe66d76camr258621725e9.15.1790667847789;
        Tue, 29 Sep 2026 00:44:07 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d45ce1csm37147125e9.3.2026.09.29.00.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 00:44:06 -0700 (PDT)
Message-ID: <b8ad269f-186a-4279-887d-60ef9968025f@blackwall.org>
Date: Tue, 29 Sep 2026 10:44:05 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/1] net: bridge: avoid recursive multicast cleanup
Content-Language: en-US, bg
To: Zixuan Chai <petalzu987@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Ren Wei <weir@nebusec.ai>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vega@nebusec.ai
References: <cover.1790323012.git.petalzu987@gmail.com>
 <156c41b1-fc86-4ecf-8181-461944734be9@lunn.ch>
 <CADTzadLbmd5E73RG16kQ1rFmwYESNuQqgc-JCX2RVhY0FRh8nw@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CADTzadLbmd5E73RG16kQ1rFmwYESNuQqgc-JCX2RVhY0FRh8nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/09/2026 22:35, Zixuan Chai wrote:
> On Mon, 28 Sept 2026 at 00:31, Andrew Lunn <andrew@lunn.ch> wrote:
>>
>> On Sun, Sep 27, 2026 at 01:04:38AM +0800, Ren Wei wrote:
>>> From: Zixuan Chai <petalzu987@gmail.com>
>>>
>>> Hi Linux kernel maintainers,
>>>
>>> We found and validated an issue in net/bridge/br_multicast.c. The bug is
>>> reachable by a non-root user via user and network namespaces. We've tested
>>> it, and it should not affect any other bridge multicast functionality.
>>>
>>> This bug is tracked at: https://bugtracker.nebusec.ai/f/4342
>>>
>>> We will provide detailed information about the bug in this email, along
>>> with a PoC to trigger it.
>>>
>>> ---- details below ----
>>>
>>> Bug details:
>>>
>>> When an EXCLUDE (*,G) port is deleted, br_multicast_star_g_handle_mode()
>>> removes its corresponding temporary STAR_EXCL (S,G) port. For an (S,G)
>>> entry, br_multicast_del_pg() then calls
>>> br_multicast_sg_del_exclude_ports() to remove the remaining automatically
>>> added ports. That helper also calls br_multicast_del_pg() for each port,
>>> which re-enters the same cleanup and adds another stack frame per port.
>>> With enough ports, the task hits the kernel stack guard page.
>>
>> What is the value of "enough"?
> 
> Thanks for your review.
> By "enough", we mean 151 temporary EXCLUDE ports in our tested setup.
> This is the smallest number of ports we have tested that triggers the
> issue.
> 
>> We get lots of bug reports for theoretical issues which in practice
>> will never happen. And we get some reports for real issues which can
>> happen. You are more likely to get your reported looked at if you make
>> it clear the issues really can happen, give todays systems.
>>
>>> The PoC uses unshare -Urn, creates 256 temporary EXCLUDE ports and a
>>> permanent INCLUDE source entry with IGMPv3 enabled, then deletes one
>>> EXCLUDE port.
>>
>> So a hardware switch with 256 ports is on the high side, but this
>> could happen in an SDN setup.
> 
> We also believe this is realistic in SDN and container setups, where a
> single bridge can have hundreds of virtual ports.
> 
> Thanks,
> Zixuan Chai

Noone will setup an mdb with 150 ports, sorry but it is not realistic at all,
not even by a long shot. I'd send this for net-next.

Either way the fix is small and looks correct.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


