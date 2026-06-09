Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CC3859D7
	for <bridge@lists.linux.dev>; Tue,  9 Jun 2026 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989569; cv=none; b=hatemrXNZDNmN3DdtQWonD3xnhphZwsEFhPR26N9QuSK5QWdX4Y05k2GXwlQlcK9AZZIAvml7kEaVUbnPFslQ6YV5ahDci1NDZ9r55K6kwu6/VS195mNvhwn+brxwLjRoAkNT0WAYpUeeA2l+EUuGPB4WNPcFagPK700m7nRasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989569; c=relaxed/simple;
	bh=hbu9LZPJQJKkJV5RA0xvycBkawmZo+tP6274zj/Z2kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4saEXvtKnPvazwgaLfXbHEWDiOBMp0JVCWuv4iDMLhr9UnhJlfyHrFkQLBYLwC498Am4gq+lQIl1oDKw5x+uG9IBRnGAMstzDINrfD1kea9sThoQHc9QpPCHag7Y0L+bOIQjTQ1kURlvsWMUBVEh3lH0l5y2SThOfNVhP3r9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=IqwYjDsj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="IqwYjDsj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so66217895e9.2
        for <bridge@lists.linux.dev>; Tue, 09 Jun 2026 00:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780989566; x=1781594366; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wq+m8phuoZlyVyvQJDDKnLnM7niPzjxS+4T8fLFpKmo=;
        b=IqwYjDsjBmIthYMINBEKVyipciol4zESXnTps0oHM1ygPPdPLZ6ZQLUtK8O81NHRI7
         LI/2OP0uq7u7RULH/BREvCnk7p380KYgsTS1FZ2WNKAb1guF2mq9PZMfbeQID2Z+dFf/
         I7Gl373PBbt2n82q9rHpOnzw3zl0AVlv7glfHBUDK9COrnSkeK78Cje9ht5EdXXmWKIL
         xSmUHWj2+s/R2eti2H8UyZm1cmcq6WFazNz2QhbFALnI0+rRlR52j7nJZy+VG7GMSnj1
         H9Ea2UH2eBdsLtBxPERYc/gbuvaUGdHHfq65ZKmsXgemu32M2jnwZ98SX4eFl7NhJ/WB
         Bx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780989566; x=1781594366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq+m8phuoZlyVyvQJDDKnLnM7niPzjxS+4T8fLFpKmo=;
        b=WJL2VLLWoVKYgOvDGaDzIgpVcJalU3+mi7iEqIEsMe7elSeB+7PAI9Z1aIZAjgqlvI
         NOXdxm1F9fgSD1GBaW8B++a26dOHo/q4FUkdGVYrz+7af3fjMg94o5UNho1Qb1sjjAap
         MHeBifIB6/1gRH/FL9MwafPGPMaSSmkI8GBXvWYsevslP7rXtMdXSZK6RoomFEs3d9Co
         E14zx7Zd/PXfPmdEvOVp8Dn4WgI3dy/2apkkNMcYeoBRwng2ye1pxZfCRmHnJEgZ0mBF
         wLJXGJuJiwWE46KNAJYr2xGTBMz/r+eJn9fXmJuFyIAjc3HaoffTOgNjOGPzrRV5R364
         s8zw==
X-Forwarded-Encrypted: i=1; AFNElJ9Jxc/7GmV05VzqROgYoJqRnGv4OUkUUyP0Lwe8YrJYCjm5uz1UTwqkZEjd1fXvBjqXnW/D6y0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwUaY7UAOyrPVtXlbkpa7XM+Dc+YCEuXr464Gs8jBYiLCc3OsJS
	IM176SwJC6i7+uCNcswPW3u0sMoP7ZeLfCQ0mMqfUzcowUiwtGgCj+HlVkvYt+GEm4Q=
X-Gm-Gg: Acq92OFaHObP06o6qfUbGbO/SjmYqU4i1teCkdIMYC5AfF9hgkSBE039jQeZrlD93fv
	1uSDTiEgbOdR3E4DMLZeSPYbw3+IJVr08HWPyspy0jAKKgG197jci/lw3BG16Xm0eYBsbisWeIC
	aw58S+CFjWPtY2GQmioVmuftv/lMUsYsZvgaxjZE1vlGkPW18ptp1ktM5yvlfDLQTm7HkplMrAG
	UugRZMUAWL7LeFa5ZfFS9WShWf+opIVBQoIDot/rXz+rJ/MbfEgEG4eNRpl350pEGTopEQeC29P
	7zoAeXFolPjxNTUnWOgX4ClthjbkoyC0APGLCcUrYXFnRI5E+r+M2PyPKyfebdl5Z3R5jA5cCne
	Cu2WhuhLsXZqUNGL8nCUc/0V5zQJxBMqCQsKeWV5EYjIqFkphJSrSlJNvU5VnlNKqSkaxg368wV
	VBQFZj7ptA8nsFQ4ihVFGDO7P3X/hI5OyWpHcxqqaTIw6RZai0SJAlk1J2XdkmkHMm02f7f3Eqi
	ew=
X-Received: by 2002:a05:600c:6087:b0:490:b294:c652 with SMTP id 5b1f17b1804b1-490c25b0696mr319291365e9.20.1780989565866;
        Tue, 09 Jun 2026 00:19:25 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm401895235e9.4.2026.06.09.00.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 00:19:25 -0700 (PDT)
Message-ID: <099ba3ba-49af-4ed2-8b58-31f8132f0d32@blackwall.org>
Date: Tue, 9 Jun 2026 10:19:24 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] bridge: cfm: reject invalid CCM interval at
 configuration time
Content-Language: en-US, bg
To: Xiang Mei <xmei5@asu.edu>, Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bestswngs@gmail.com
References: <20260606215848.1951633-1-xmei5@asu.edu>
 <20260609064613.GA652158@shredder>
 <CAPpSM+QGAARoC2Jq2EfMkXCgBQXy7k64W6rBFdJ8mhpfrR0zXA@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAPpSM+QGAARoC2Jq2EfMkXCgBQXy7k64W6rBFdJ8mhpfrR0zXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/06/2026 09:51, Xiang Mei wrote:
> Thanks for your review and the tip. V4 was sent.
> 
> Xiang
> 

Please don't top post on netdev@.

Cheers,
  Nik

> On Mon, Jun 8, 2026 at 11:46 PM Ido Schimmel <idosch@nvidia.com> wrote:
>>
>> On Sat, Jun 06, 2026 at 02:58:48PM -0700, Xiang Mei wrote:
>>> ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
>>> the configured exp_interval converted by interval_to_us(). When
>>> exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
>>> interval_to_us() returns 0, causing the worker to fire immediately in
>>> a tight loop that allocates skbs until OOM.
>>>
>>> Fix this by validating exp_interval at configuration time:
>>>
>>>   - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid range
>>>     [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
>>>     netlink policy so userspace cannot set an invalid value.
>>>
>>>   - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
>>>     not yet been configured (defaults to 0 from kzalloc).
>>>
>>> Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interface.")
>>> Reported-by: Weiming Shi <bestswngs@gmail.com>
>>> Suggested-by: Ido Schimmel <idosch@nvidia.com>
>>> Signed-off-by: Xiang Mei <xmei5@asu.edu>
>>
>> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>>
>> Nit: I don't think that the Suggested-by is appropriate here since I
>> merely had minor comments on the previous version.

