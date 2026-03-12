Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE093FB7E2
	for <bridge@lists.linux.dev>; Thu, 12 Mar 2026 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334081; cv=none; b=Alru3m+3g3YLn2zU0d4u0Iu3otDZy+e7wXi0ukso+bz0OAJyQHnpjzct6q0sdY7C5iZtigE1SFJ06VkhxPU0hd2CPBra/HyCmiJGA43trCRVcs+THWYXXSkQV9Q5qkRgugn5P5CQ0cRy3rUI0SyWgzQOj3x19V4c53CdTPx7VgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334081; c=relaxed/simple;
	bh=IIb3lnFy9ZZgffcMQ1sb/OxpBNFDfrikKLoctgY2LdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gm2tBJK4J7C+Fah4b0gZAAeKxuhmfY6LeDw7XHB9AN8ACHwF7lnr3hdJytxwVHaPhbwMG078vMe1VXKdAl6kxLychoU3WXJC15aFkJcrwAIdKcrPGg1cISrHuti+gPaq8gH6kdQEKIunW90E1r/Zb2PEhpJMV7dqcKT2wn2we50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VokwVflU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VokwVflU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773334073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QopztaDQaDXdF0WurIHvj6v5UeE/ENNGQg9kHKBDRS8=;
	b=VokwVflUg0tbr7t/+tXumVBDbLtqhAS6vUo9J4TWYSscqC7we77dwfqOmy4OPPdKVkUx8l
	PDT3jPnJqlnBzdDzMXD+2H9CD2N3upMY4jYUlQslWnuVcz5TtdPowHu0VY1NlM16TKw4f7
	CXvzIh778HeFAitwExBz4SAQmzJKkYI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-NcAshzyOPS2-xw2zj0tgIg-1; Thu, 12 Mar 2026 12:47:52 -0400
X-MC-Unique: NcAshzyOPS2-xw2zj0tgIg-1
X-Mimecast-MFC-AGG-ID: NcAshzyOPS2-xw2zj0tgIg_1773334071
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-38a27d3b22cso5336611fa.1
        for <bridge@lists.linux.dev>; Thu, 12 Mar 2026 09:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334070; x=1773938870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QopztaDQaDXdF0WurIHvj6v5UeE/ENNGQg9kHKBDRS8=;
        b=avUSdeTV7TywrBwkAqOYjR4AiC4tPD8bVeCmeHszoZEx0ZyJMzTAsIQ32V3hqPb01H
         cgQoOgT1SggZUAyYFmiO3AzcixqEeNSKBqXx1gNs4uGAXhHzblcJfZ3y/gcJVAZUI/+j
         8PYRwt3ntG8Pkrc9zm3IW+O5E98TxhzhGMsT5FIG++F5oKPSgBpEnQbRsKsovZwUiU2M
         NjqPjT+h8nR+Lizh7pvaNHwWHpuwV+ZcjFqhdrc6aDL4n3Dcxj7Q93XRT9IuRfZ3aX3H
         Y0vQ8Dy+K8kq8mleFFI6ehTafiKiyis58i66z3Ved95uN89Cwr0OCe+TcsRqE0dT3wTx
         ZQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwArJCzo4R6Exf3pUveMbSwOX80TRslDhP5kXe7arjXlMxoI3wVhTBJ4HlfHmqukrsoIoEMYk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxwFym6L1jW6Sov4nBcBetY+35YJnGbOfrvNWoUdD3WkNQLu1bw
	XXdUcSmvAi4F6JhIdQWTWnyKNPQkRa8tpaqOf5jJwJZBhW8WHLsgGypL4zztLZ01Cm1TKQITvHD
	T1/J/W4weGjJzWxopMdCL39wmpv+kdzpB+zdqhA6HqiJkcXVwUuR0fe0+qA==
X-Gm-Gg: ATEYQzwiXhjdr1m63tNXkdwahfwSBSUgjqcGD2T8jLUAYaUTI8nz+QlCKyn4pXB6dft
	HF28IRO2ZE9VfpjMFv/5oZwTh59QOjc6baExyhe5wOOIjUUwPsLd32jp7KhqvFkbU0yts8pVaH6
	3AMEMxhZm8+HOfenG7SuNuSXdrJToXFzJZdnkmYlrY9JIh9+NKNROe1N0HRcgSgaoLby8ujIzIP
	iE5HE0WksQi7eLex6Ii87xTu6+k1TU3OLc5WkHyGkfcvoC+YefOku5CAGXyBQ1ngHoeRsAKAtzH
	Ew4CDsoIMFXxnhy+ZcUwRPPUUcJMRhcFvWV6qJwbb/sm/rXIfQoAWEt1SUKH76dK2Ev/I1wLqcX
	fa7cWDZejSPLsRWLDOsfsHkzXbHfUVVYYxnYz/U48wzxS0STiOvd9zII=
X-Received: by 2002:ac2:4ed9:0:b0:5a0:ff97:4374 with SMTP id 2adb3069b0e04-5a162703bebmr82066e87.7.1773334070498;
        Thu, 12 Mar 2026 09:47:50 -0700 (PDT)
X-Received: by 2002:ac2:4ed9:0:b0:5a0:ff97:4374 with SMTP id 2adb3069b0e04-5a162703bebmr82051e87.7.1773334070004;
        Thu, 12 Mar 2026 09:47:50 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156366b22sm1021366e87.77.2026.03.12.09.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 09:47:49 -0700 (PDT)
Message-ID: <2d1e0acc-efad-4166-b738-721d88d533ca@redhat.com>
Date: Thu, 12 Mar 2026 17:47:45 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot ci] Re: net: move netdev_compute_master_upper_features to
 ndo_set_features
To: Sabrina Dubroca <sd@queasysnail.net>, Hangbin Liu <liuhangbin@gmail.com>
Cc: syzbot ci <syzbot+ci098fa7c1795eceac@syzkaller.appspotmail.com>,
 andrew@lunn.ch, bridge@lists.linux.dev, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us,
 jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, razor@blackwall.org, sridhar.samudrala@intel.com,
 syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
 <69b04e91.a70a0220.51e36.0000.GAE@google.com> <abBuLV3P6aTzUg3W@krikkit>
 <abC7rdjxv9ENw-tA@fedora> <abHcP3GTO29rfKML@krikkit>
 <bcc536ac-dde1-4b63-8fed-70850818472b@redhat.com> <abKf8Fg865Fhipwk@krikkit>
 <abLPBEg_-j5rp4IM@fedora> <abLivB2KPK0JcTFR@krikkit>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <abLivB2KPK0JcTFR@krikkit>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qHPXx_3aJoIRUWDmaaMAL_1ojWg05maw4XONw6shIoM_1773334071
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/12/26 4:58 PM, Sabrina Dubroca wrote:
> 2026-03-12, 14:34:44 +0000, Hangbin Liu wrote:
>> On Thu, Mar 12, 2026 at 12:13:52PM +0100, Sabrina Dubroca wrote:
>>> Proper fix (so that the notification we're sending during
>>> upper_dev_link has full linkinfo) would be to move
>>> netdev_upper_dev_link() to after macsec_changelink_common() and fix up
>>> the error handling. I don't see anything in macsec_add_dev or
>>> macsec_changelink_common that needs the device to be linked. But
>>
>> If we move the netdev_upper_dev_link() after macsec_changelink_common(),
>> we will not goto nla_put_failure via default, right?
> 
> Yes.
> 
>>> anyway it doesn't make sense for macsec_fill_info to return -EMSGSIZE
>>> on invalid data, so the "bandaid" should be included as well.
>>>
>>> Should this be part of this series (either just the "bandaid" or the
>>> "proper fix"+bandaid), since we never saw a problem before?
>>
>> Since macsec need the "bandaid" fix either way. How about you post the
>> "bandaid" fix to net. And I include the "proper fix" in this series for
>> net-next?
> 
> But I don't think it's needed in net. Am I missing a codepath (before
> your series) where macsec_fill_info could be called for the new device
> before macsec_newlink returns? If not, it doesn't really qualify as a
> fix, that's why I was asking Paolo.

FWIW, I don't see a codepath calling into rtmsg_ifinfo_build_skb()
before device initialization, so I would be fine targeting net-next with
the EMSGSIZE-related change.

Side note, it looks like that the WARN() in the rnnetlink code here
helped identifying a real problem and correctly returning 0 when the
key_len is not yet initialized will silence it forever, what about
preserving a warning for this kind of race? something alike:

---
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index f6cad0746a02..82974d4fa3f6 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4337,7 +4337,8 @@ static int macsec_fill_info(struct sk_buff *skb,
 		csid = secy->xpn ? MACSEC_CIPHER_ID_GCM_AES_XPN_256 :
MACSEC_CIPHER_ID_GCM_AES_256;
 		break;
 	default:
-		goto nla_put_failure;
+		WARN_ON_ONCE(1);
+		return 0;
 	}

