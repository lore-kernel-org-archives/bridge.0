Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630AE47ACC6
	for <bridge@lists.linux.dev>; Tue, 15 Sep 2026 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467983; cv=none; b=OeG2+vz5O2wi5R5eW1kGO6ZnYFAcjt5ECUDhmwaSU/FbpVGfYyr8PF6NHqe59WYmWjt9J8eNASLXbevFgckc3E7WeThSW+BBxYOuDTviP2xYrtMjw7jvxopq9f44GHV2HdHG7klCtS9iFIvIv4+r90q0+Plc/gmrzmHrkJRHqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467983; c=relaxed/simple;
	bh=Km4iOXUDzEA/paiw4gBm8sJ5RUhR7oNFvxSF0WlPpX4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qWf88SjdLOw5oxBCGDO1yojhING/S2aQvj51zWYoTeXyMSZmuArnsUMKlhDwzuYCnDc2DGuEFyx9Rkkp1Li38V8wmPAjXIh+dE6BfDU5dyNFheu2wrO/h7EoClxaTRrGLivwI5Kec8VtjqH9pAvuOJi6R6GCx2HNCsLg/GrKVdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LPXdBTKi; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LPXdBTKi"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48583cc7ab1so1370830f8f.2
        for <bridge@lists.linux.dev>; Tue, 15 Sep 2026 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789467979; x=1790072779; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AW6Angy73DE+FcoQnAj7AGMpu43bPwy4fXJShfDRPu8=;
        b=LPXdBTKitZkqDbwzn5TpFgopEza5Y3CJpd5Z5iHC+bv+iIU4CTmkX+IUWn8nWKMVBY
         y9NJx12jENTKlWWVhFGMkjdPwhtk35twZJwxLjLSXhgiE/g5/FQwYRlzPMSHwvlse8m8
         DFXC+aVg2Rgrglo1e+UA67Jy+D88mZ34tp4B7ERSli6PcMaUcjJ5Fwbs78YDSVD6ePGB
         spHIHlOKCSjGp6OPVthEpMsVZY7iInNiyawmP3PXuF0uHSxG7q29wRssnl93k8zW7PY8
         +Db6NyiY7tW3mYNuigi8mf2GmwhQLvCmk9aV5eGo59yUzdeFvpUL/rmApTirahcuJx4u
         w46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467979; x=1790072779;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AW6Angy73DE+FcoQnAj7AGMpu43bPwy4fXJShfDRPu8=;
        b=LzOprb2cCSvhugMZi+HAFZjslL4GVWbYzIY1OBMdGlAjTSfVR9NpCJLMWaNVsIPANo
         PV7xr2TYTecV6RgakpK2OlZecwMqshwS3pi7AelJBKrU2LiQCs4z4Je8iGP3yGoVV3zy
         lmoVY1jL9PNc+dvZx+8b1kdxS2FHt5bxyjbn7g6KjMMXKYXkvdDBFkmyG3hXXhRlltb1
         cZBGwCSZuaNqDgcLjGmdQ6Czq2rA9CjpDMX7klINniG67ApZkUF4I5QJBp0m6R22agVB
         zBl/xrtn9D3xiu1s98XnkxWNsv9z8UaxsHQloT/YTaFPoaWrdsDzazDZdjrdIwzTBJFK
         CcAw==
X-Forwarded-Encrypted: i=1; AKwUvBwSz3Mglpmmytk4OIecuSJxLMBVIoXHwSK8fm2TocesU/o1AeihO9USqKkxAei3KL6IdCrKUHU=@lists.linux.dev
X-Gm-Message-State: AFuF++mnII3jU+ooijDKwhxtGi7LsZDbKwbx3dKmbLtf1v3lLwoYk7fF
	7RRT7NY0IcTfrvgOpzn6N/e4tgR/lU9YPMB3FzEdmzm28lNutnVqY0X9jwuFTLXe7l8=
X-Gm-Gg: AYBFou2v8VpGnOPA8ZJ3u8kzkFDM+7LtuLNlaHx/k1YbMCWjTJifdvkTU9H+4WBf2IE
	+TmgQ+eyKmbxq3qwgFyZh11suEkLiM+GQC+N85niGUIs/gEQ2ywbK0+sIkdV2N54HvloNjwmTVX
	zb5b7ZqMLcdLms9T0MSdciowopkuRQgMZXzklPK0WeWt0jaOv9zfOurqqImy6KDW3WGa95LLiHy
	2Ib9TSah3Iq7j3OX4kkrD3RkN38QunPMwCN0JGckqne6uk5MnKIRucm4SMA7W7bysDIkKhRCGjB
	pAr6Mcul+XjzvleCuz8uZ2uBxE9Y/jCqwwPw2g4z3QFm9Qems5aItQtdvIM6Wlo+9Or5AY9GbqZ
	SBD1aPK5HfERzjDTui34wu8QS36ECWTfMLgUskygVNKz7Ul4j0bANdpy8NxtTplLQRJXrIyFKrT
	MI6IV24Ni5zkapQrx9AcHw8l6sZ8plz+PFFgMM7GOY0Z4dKL6LLrnLSTTzb0O5fW+xMRT1Y9UvM
	53JiS+JdoZBO+toyBoBnocPN6ceIw==
X-Received: by 2002:a05:600c:3593:b0:49c:e3ad:41d3 with SMTP id 5b1f17b1804b1-49e7a5edc17mr76536725e9.0.1789467979378;
        Tue, 15 Sep 2026 03:26:19 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33e020sm35176780f8f.18.2026.09.15.03.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 03:26:18 -0700 (PDT)
Message-ID: <aa5eba0c-b9ea-4b7f-a529-54980081e259@blackwall.org>
Date: Tue, 15 Sep 2026 13:26:17 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mst: move switchdev call outside rcu
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, tobias@waldekranz.com,
 bridge@lists.linux.dev
References: <20260911105021.1385934-1-razor@blackwall.org>
 <7043a1fb-fd55-4a4a-82bf-c5428f67a035@redhat.com>
 <b696c600-4ab1-41d5-b391-3f6373200cd8@blackwall.org>
In-Reply-To: <b696c600-4ab1-41d5-b391-3f6373200cd8@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2026 13:25, Nikolay Aleksandrov wrote:
> On 15/09/2026 13:23, Paolo Abeni wrote:
>> On 9/11/26 12:50 PM, Nikolay Aleksandrov wrote:
>>> This is a follow-up of one of sashiko's pre-existing bug reports.
>>> br_mst_set_state() calls switchdev_port_attr_set() for nonzero MSTIs
>>> while holding rcu_read_lock() which invokes the blocking switchdev
>>> notifier chain and may sleep. Nonzero MSTI changes come from netlink
>>> with rtnl held. Move the switchdev call before entering the rcu section and
>>> assert that rtnl is held.
>>>
>>> The call cannot be deferred because netlink needs its error and extack.
>>> Also DSA reads the old bridge MST state during the callback and checks it.
>>> A deferred callback will be late and will see the updated state.
>>>
>>> Fixes: 7ae9147f4312 ("net: bridge: mst: Notify switchdev drivers of MST state changes")
>>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> Clashiko noted that the fixes tag looks inaccurate, should be:
>>
>> Fixes: 3a7c1661ae1383 ("net: bridge: mst: fix vlan use-after-free")
>>
>> do you agree? I can fix the tag while applying the patch no need to repost.
>>
>> /P
>>
> 
> Yeah, I agree. As Ido also noted, that is the correct commit id but it is
> from the same set. :)

err, I meant same release

> Thank you for taking care of this.

