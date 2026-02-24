Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A49329E57
	for <bridge@lists.linux.dev>; Tue, 24 Feb 2026 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932077; cv=none; b=GF6+sKqxkSnr91OGl6LNYRa2gQwECxal5uIkD75qVcmhlKmAjcJBFZHfXhDGR+eZO/fHhNTlvUNmxFV6Qeep+rpev2jyk2xRaxx0jINDoF88kwi2+kNo5rpcGQphZxgupfroiA0EZ6d/szU5xxPp3QI+YxPs5esHQJqXPvoefx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932077; c=relaxed/simple;
	bh=u8DFcZr6PrNIgWweTXks8B4ZPWysQUYeU0IhnqpvGHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnME9/flI3VxPO7xbKMwM9N8qwl5XnkjD4A1c/49WCjxG0is/N/BvTLBhFYg2bmy9ko2Cy5BjbGGu7UHMwydwPvsjm5/RSCAtc2YW0vSlguuMhiSUO5WylndtO9zg9fxov9fOIEHMP9pHGKw7XnutU8FF/GUtsmyScIl5+8lIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhVHZkc0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhVHZkc0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771932075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6clpakBnI/FsH5CU8EtT8oTpZLAR4ADDoYBwMfYPgk=;
	b=RhVHZkc0HpXn1eTIZkPFYxurG1Toea+PiKrSEnxNMB7JXwqep1OslNP79mflMig8mP9If8
	1FgQLlTmsgfQUlY93b1eK9npyV/no+i9spbJr8y2TZezX1abiAutwXOgTQRTylPgJa8VPx
	4Mw0fEKR64p876XEVnJYODDcM6LYBmI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-LhqiswBhOs2XkWSFoEZTuQ-1; Tue, 24 Feb 2026 06:21:13 -0500
X-MC-Unique: LhqiswBhOs2XkWSFoEZTuQ-1
X-Mimecast-MFC-AGG-ID: LhqiswBhOs2XkWSFoEZTuQ_1771932072
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837b9913c9so52805975e9.0
        for <bridge@lists.linux.dev>; Tue, 24 Feb 2026 03:21:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771932072; x=1772536872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6clpakBnI/FsH5CU8EtT8oTpZLAR4ADDoYBwMfYPgk=;
        b=OJCha0cEVF7C35V3TlWQtVYTmZTwpZpZiZPPInWnUvAjI6ftg+V6Xkh8XggoYAIsnY
         tSSn7o4n0XYKTyZRh3eNj6B+gpYZqKfUEhv73dhc38Isu8q/Oxuejldq8AP2hlqzqRfg
         JWgKSpG/bmlQ0uNv0TVyvK8YvrPSe9oKGxmq9n5YFebeMyvxUkxJLbDzEbpVXRIXJTQO
         6J32ey8L02QGHNjFoVpy7BVSdq2liSbyhvLXgT8DcH/zoL1c+0LyvpeTXYG32sfPAwFa
         FJiaEWKaabVRPpsf2GZOpj115f6yfeSGf+xOUBSBUIWG1aVLQyKfly8Gza36Yp6YynA6
         dSYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO7m1tuvJqEHZUwtDruprv95hlK4Qk6cUeAchhviv6GGn4JCVGRFv+e8PzhxpyJrCga3HKnrQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf6/igO7PhBVocpwb6AoXNYQHhkcP4ogOtiZlwcUKLJFDWztfY
	UyFSVDhmG5bpmvB50o9i3LH8Yy3YPrBOq2WLfLtb+fkThj4N+Jj9mSKKyV9hE2EKuva4LeHUJwM
	H3zCKWDKjDUQJvffsgYUfZiCZy75Vf4o6s65IUXRwVDpVsMF3MX4sM4ZLqw==
X-Gm-Gg: AZuq6aL3AalbtkZMDYCf73fthzj/5xrXT03WWA2rXHT+myz3dFMZAJop+bXcvyZ+ywN
	7SMUUm2pK3bXYMJM3NIxwV0iEeAlThiJCENmW/ed/rVT5tVlRmo+Gk5/mNGA6pxyMiGZyqQP6uE
	o/ifkDWwanD5wduUnzfX5c4gnyrbDZW1sYcsv/29+XBKLu+AadTI4aa/vsdNa9GrhQ4GPSM6egL
	5F/bBp0oR5Wg/1y6uHH71X2fI+3W7wq27SK2a17ZPQy0ttzn+xwKmfw4SD1zL7SD83CB9g2BkO3
	DouXHrOyTdaFePyfa6OKs+fUs2lqyKm2crsgMvpbunEBpaWmtsKY748tbWUvz+zwkJc/7kCOckS
	KW7fnrOP2JzdV1wJ7Z2gx
X-Received: by 2002:a05:600c:45ce:b0:483:a895:9d85 with SMTP id 5b1f17b1804b1-483a95b3e18mr211925265e9.2.1771932072291;
        Tue, 24 Feb 2026 03:21:12 -0800 (PST)
X-Received: by 2002:a05:600c:45ce:b0:483:a895:9d85 with SMTP id 5b1f17b1804b1-483a95b3e18mr211924625e9.2.1771932071750;
        Tue, 24 Feb 2026 03:21:11 -0800 (PST)
Received: from [192.168.88.32] ([216.128.9.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b3e0dsm504628215e9.1.2026.02.24.03.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 03:21:11 -0800 (PST)
Message-ID: <d3a43f4c-1b6e-4cac-a127-3e297fd6d224@redhat.com>
Date: Tue, 24 Feb 2026 12:21:09 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: net: Add bridge VLAN range grouping
 tests
To: Simon Horman <horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com
References: <20260222085338.3143823-1-danieller@nvidia.com>
 <20260222085338.3143823-3-danieller@nvidia.com>
 <aZ1agwUGRt2Qqzv3@horms.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aZ1agwUGRt2Qqzv3@horms.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 68YrXdFjZtlKy-QUEr986hulOmNXa-37IPATzUsEcxU_1771932072
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/26 9:00 AM, Simon Horman wrote:
> On Sun, Feb 22, 2026 at 10:53:38AM +0200, Danielle Ratson wrote:
>> Add a new test file bridge_vlan_dump.sh with four test cases that verify
>> VLANs with different per-VLAN options are not incorrectly grouped into
>> ranges in the dump output.
>>
>> The tests verify the kernel's br_vlan_opts_eq_range() function correctly
>> prevents VLAN range grouping when neigh_suppress, mcast_max_groups,
>> mcast_n_groups, or mcast_enabled options differ.
>>
>> Each test verifies that VLANs with different option values appear as
>> individual entries rather than ranges, and that VLANs with matching
>> values are properly grouped together.
>>
>> Example output:
>>
>> $ ./bridge_vlan_dump.sh
>> TEST: VLAN range grouping with neigh_suppress                       [ OK ]
>> TEST: VLAN range grouping with mcast_max_groups                     [ OK ]
>> TEST: VLAN range grouping with mcast_n_groups                       [ OK ]
>> TEST: VLAN range grouping with mcast_enabled                        [ OK ]
>>
>> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
>> ---
>>  tools/testing/selftests/net/Makefile          |   1 +
>>  .../testing/selftests/net/bridge_vlan_dump.sh | 203 ++++++++++++++++++
>>  2 files changed, 204 insertions(+)
>>  create mode 100755 tools/testing/selftests/net/bridge_vlan_dump.sh
> 
> Hi Danielle,
> 
> I'm wondering if you could consider running running shellcheck over this
> and cleaning  things up a little.
> 
> I see SC2086 which I think can be trivially addressed.
> And SC2329, which I think would be best ignored using #shellcheck disable=SC2086

@Danielle: please address the shellcheck-reported issues. We are trying
to avoid them in the new code, and with time we will hopefully achieve
code consistency.

You can use the ingest_mdir.py script from
https://github.com/linux-netdev/nipa/ to automate the shellcheck test
before submission.

Thanks,

Paolo

