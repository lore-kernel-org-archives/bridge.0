Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369A15665E
	for <bridge@lists.linux-foundation.org>; Thu, 31 Oct 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364297; cv=none; b=ehxl5nlXuByeBJzT4+VXPUs7Ay5M5oaTo9HkkliMb0lkEV7qJ5x2b+zn18WqzIDYW+PAvzB/Hhfmwt3Q4bSMtuoT71SeyZ/ZNgv5g6u/ThQauELrP/97x1B0H1leV1jdp1i1Qr7lZr3J6bPM113R3oMHKm2MlkVq0Q3RCL/cKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364297; c=relaxed/simple;
	bh=eNGZbXS5xYbci/PRfEF2hbIicvay9ljkesgFb9Zbwb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CS/YG8JPydGIWCcLNzS20u69Tmy6/xStZG95HuAVHw0daMOJox2VZ6dPwmbv5nKgVEsVdfD5MXoqCCb2YDlF26R4BKU1NZLxNeyhLHkSFQBLT4SJTIVA9K1Xgy2/gzdwsXLfihhjfJ2GHB6AEoN63EJJaG3rbAOEH9Op2YR9+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=lrGNpjHG; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="lrGNpjHG"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D135605E9
	for <bridge@lists.linux-foundation.org>; Thu, 31 Oct 2024 08:44:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B4_AK6K3yR08 for <bridge@lists.linux-foundation.org>;
 Thu, 31 Oct 2024 08:44:54 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0B25F605AE
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B25F605AE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=lrGNpjHG
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0B25F605AE
	for <bridge@lists.linux-foundation.org>; Thu, 31 Oct 2024 08:44:53 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so465826f8f.1
        for <bridge@lists.linux-foundation.org>; Thu, 31 Oct 2024 01:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730364292; x=1730969092; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7XH+4h15HqpZhxc7vaK8pogYPWIYWMJq3J37NVY9vs=;
        b=lrGNpjHGu5uXWRGcvnAVmurMbAFOyGaFalR1y3OHXd92XztouCjY7e3F9xtLx3JUhS
         O4MhWYL5dl0cGL5FE19TseIeFLPBTBcmfSxWvH5a6/DbqQ8+wpZkkIBNOkWXCk0MiNGO
         6M7Ng2CO/i0nygJi0oUbQqlEvWqPeYVc3MFp0IyUukiWtqCtHS4ZMcJhKmCCe9bRdYGt
         X77xnF9KNtVvSHhIzLVR67ogsEPV0aetDz1He/F979SieNTx6DmCqFUJl23/OZ2VP08c
         EE7n0dQlANc0lRcD7Mx+nDzEUskp7ro5YkkL6Ssj7sYTVx9fa3SUSAqvTN8cy+J3NTDc
         tnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730364292; x=1730969092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7XH+4h15HqpZhxc7vaK8pogYPWIYWMJq3J37NVY9vs=;
        b=NQ8EgNO1aL5bsUaGHWXtX73SUTjevHZXwYfFLPRCJZsrjFHOO5rNuTBu/4Xmj7tlTk
         64GUR1JeCTRhqqIw1h0GKoxIXvdEX/Ovoz5ylbWDekAzEFyEuPbUvkXrsqja/aasCJXJ
         MjPTfmfw1JXnWdG7ku+ceS2K7tTvmf53Z21FajP7K2Pcec6IUnl+ZHykUww/TndXmUDl
         2vjjEVn8K0sU834EgomcTj7opY9EfR0boOBD+VbIkI+5AVxzrTc1rBUwNl1ibuvPcC1K
         7D9ym799tP/iozX9u3LT8vpNhBuyrsNzhw9RkFKgMVdeVJqy83XrEWf2ewNE5UQU0fXk
         sl3g==
X-Gm-Message-State: AOJu0YzrxxKWzQHUwXcEudB5ibBSzyC2XVKdWN6jB6ZmvpufnCOkcJeM
	w3nwMU+dG+b6/F+bxR6itl54+Gs0PtYjufyJneRApO6EC5VD/JPZs/d/F7hcC34=
X-Google-Smtp-Source: AGHT+IGMPPAm8oKO3lf+cyTPbVkOrDb2WFhOlduZaxysibQCUGshe5RgjOS5o/oahMrPOON/kVx0eA==
X-Received: by 2002:a05:6000:18a7:b0:37d:45ab:422b with SMTP id ffacd0b85a97d-381b708b694mr5397349f8f.31.1730364290179;
        Thu, 31 Oct 2024 01:44:50 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e6b5sm1432467f8f.88.2024.10.31.01.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 01:44:49 -0700 (PDT)
Message-ID: <8c8a53ee-ce3b-4337-973a-9450cd4a1363@blackwall.org>
Date: Thu, 31 Oct 2024 10:44:48 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute] bridge: dump mcast querier state
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, entwicklung@pengutronix.de
References: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
 <f4efc424-6505-4e20-a9f2-14e973281921@blackwall.org>
 <58d40a6c-7c42-4a46-8c9a-0da4a0c77380@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <58d40a6c-7c42-4a46-8c9a-0da4a0c77380@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/10/2024 00:10, Fabian Pfitzner wrote:
>> For the second time(!), please CC maintainers because it's very easy to
>> miss a patch. In addition to maintainers, please CC reviewers of previous
>> versions as well.
> Could you please tell me at which mail addresses I should send the patch?
> You said that I should send it to "the bridge maintainers" as well, so I put "bridge@lists.linux-foundation.org" into the CC this time.
> 

from iproute2/MAINTAINERS file:
 Ethernet Bridging - bridge
 M: Roopa Prabhu <roopa@nvidia.com>
 M: Nikolay Aleksandrov <razor@blackwall.org>
 L: bridge@lists.linux-foundation.org (moderated for non-subscribers)
 F: bridge/*

Unrelated - I just noticed we have to add a few more F: lines there, I'll send a patch.

In addition to maintainers, please always add reviewers of previous patch versions.

Cheers,
 Nik

> On 10/30/24 4:29 PM, Nikolay Aleksandrov wrote:
>> On 30/10/2024 10:46, Fabian Pfitzner wrote:
>>> Kernel support for dumping the multicast querier state was added in this
>>> commit [1]. As some people might be interested to get this information
>>> from userspace, this commit implements the necessary changes to show it
>>> via
>>>
>>> ip -d link show [dev]
>>>
>>> The querier state shows the following information for IPv4 and IPv6
>>> respectively:
>>>
>>> 1) The ip address of the current querier in the network. This could be
>>>     ourselves or an external querier.
>>> 2) The port on which the querier was seen
>>> 3) Querier timeout in seconds
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
>>>
>>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>>> ---
>>>
>>> v1->v2: refactor code
>>>
>>>   ip/iplink_bridge.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 47 insertions(+)
>>>
>> For the second time(!), please CC maintainers because it's very easy to
>> miss a patch. In addition to maintainers, please CC reviewers of previous
>> versions as well.
>>
>> Thank you,
>>   Nik
>>
>>
>>

