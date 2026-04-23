Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927392BEFF6
	for <bridge@lists.linux.dev>; Thu, 23 Apr 2026 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956088; cv=none; b=pf8D8NgFIAIqmdwPEz3iLLEtdL3yBtPQZnXvTBBjoQHfz/R0Fly5cjHAkMoxaF6eHDEG7kshGbyw8Ox/BAKuITslNuYmONzTlyCZdvc08ja3HtJyWwx08t+UXO4wAd3MpLgaRhpKzI7j8ibZT/WLbrg7ThkT3JJvY7C0mVEsMgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956088; c=relaxed/simple;
	bh=hfUHLyKJSvrgtYgi0uQNctjhIyNjTTEmXV7g3LiZRcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSYZKWXIb5dCKtxMownxwy4LNXoFntwxAZixyiKWPkZpDhvUb7t4cmWtKH6juxuAfdAxgR3PYo1TWZuG072q7vgAhGV/2DrU+6oxu6So2saUyu18ofVhRDrbsMghfn3NPIy/nRhdTMi0cmh7Mne2fIEAPUp/hTzGkE90Vtk5IaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dV1tzpp+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dV1tzpp+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776956086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdUVkFiLAqBCJes+oJ0QB0pTbT2jdIw+uaSjtun6geI=;
	b=dV1tzpp+JGeoe/daPipG6Clwob+O64hgsnMkp/Z6gm4LfvThcwuXrqyra7fNPl5Bf3k/5o
	SgBJ7fyoo0bXcR5gXaF/kPX0b6yg/QaEUPv6jqntEycM0/mD/bqpTbd+pOJuHLKlEaeMkX
	Nv3o5nC0r44dUQVn0A7yIk1na1bQ4Fw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-Jl7Kq95iPiKNmniLCadWXA-1; Thu, 23 Apr 2026 10:54:43 -0400
X-MC-Unique: Jl7Kq95iPiKNmniLCadWXA-1
X-Mimecast-MFC-AGG-ID: Jl7Kq95iPiKNmniLCadWXA_1776956082
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d780757eeso4185757f8f.1
        for <bridge@lists.linux.dev>; Thu, 23 Apr 2026 07:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956082; x=1777560882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdUVkFiLAqBCJes+oJ0QB0pTbT2jdIw+uaSjtun6geI=;
        b=DB915Tf/eN1EZhx4KwRPnIKDDmJkiC9F0ra6Dav8AZqQb8ezP15Nsbb14obv/T0x+K
         rhNdZ4PIom0YsUXTdksOC9WCmYzLpsKsAVXMG9EFOkmthOi+Yp16N4a7lRBH1V2bgwMC
         S/IaOhIDB0dnUl1TWboOWnFA6ZV9ZtJAEXXdTv1ARihY5OVUmkUgk8sOMiAl8c1OKg3q
         t1B88URuWw3HXoKduKoikrDrH6poc9mm7ITAORiUnAcftzg1W3T7bKfLPADWCqc4Xiiq
         G3HXtDLOB2xgGxbyXcwpYuspRJxPTkobfui84HVYg1bBcXM3Uw22oyEY/8Sd/TE7FnFG
         DZTw==
X-Forwarded-Encrypted: i=1; AFNElJ/YIfyinBFx4YQ2d9YDGSydktwpr2ZnKi3lRk5BwmxgarUv0mm3+dKn0VcBbuQwVAj8q92FSpw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7dZtm5ZUADYN/aPfAJfmMt1shHd5gCa2zq5Gt6Ofp6+EUGcyO
	bHpm9CuLQHoLZ93pYvXxZu2KytSMYCxLUwVwVKfiDlzK3X7ut4xugnFKw9Uaq+eFpxQ5RCjw7s+
	TaB9HEotMx2r4kkeOlHYRkTE0ivpzfvGm5yuLOL+iwvjUhwsPpLMoSa1RhQ==
X-Gm-Gg: AeBDietZKAnnIcc1ijCSPg+kt6QlbT3WIRo1BsRTVSZVtijIC/9lVlcboI/Y1BlaN+z
	MJtpfeaO/LwTYghP7aq8J7UU7JKIS6RUhHQle+lDdHyXSRYeHO9nDpFn5lGSIqMJQRUo/jGlLwo
	OsHQnWYdeTSaqmA0wfr8lTJzgiK8SIWGFlgCU/DsC8MLCsmYIFUf9iXSSE8oQLtnBrKSdS2XkRw
	11Pb4AKCO2bChzxYOv7nLpUMwV0yQ85sqdJMb6nc5Y7XN1W1POHCFf8+6DG71dFQcpiNwK0yuQ3
	wC06IS7pKjtQPHkiNTlj+XzbQJZNGViCMF21wxifBuPPmgKsaEgZZxV6GJxHOCpV9dU/u6VVavk
	s0tmPxCfAMmP04rpVAtNtNsAz/I9LVbqcglPsSA8TxNZko2AwUU13RiPczP/Qi7/jTaI=
X-Received: by 2002:a05:6000:4a1a:b0:43e:a8d8:f3dc with SMTP id ffacd0b85a97d-43fe4052190mr36059653f8f.13.1776956081730;
        Thu, 23 Apr 2026 07:54:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4a1a:b0:43e:a8d8:f3dc with SMTP id ffacd0b85a97d-43fe4052190mr36059588f8f.13.1776956081154;
        Thu, 23 Apr 2026 07:54:41 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm52345982f8f.33.2026.04.23.07.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 07:54:40 -0700 (PDT)
Message-ID: <8e81d2a9-e095-4687-ae37-e4328bedb7a6@redhat.com>
Date: Thu, 23 Apr 2026 16:54:37 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, linux@armlinux.org.uk, tsbogend@alpha.franken.de,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, 3chas3@gmail.com, razor@blackwall.org,
 idosch@nvidia.com, jani.nikula@intel.com, mchehab+huawei@kernel.org,
 tytso@mit.edu, herbert@gondor.apana.org.au, geert@linux-m68k.org,
 ebiggers@kernel.org, johannes.berg@intel.com, jonathan.cameron@huawei.com,
 kees@kernel.org, kuniyu@google.com, fourier.thomas@gmail.com,
 rdunlap@infradead.org, akpm@linux-foundation.org, linux-doc@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bridge@lists.linux.dev, dwmw2@infradead.org
References: <20260422041846.2035118-1-kuba@kernel.org>
 <aeh0CV3UQw1quCXv@ashevche-desk.local>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aeh0CV3UQw1quCXv@ashevche-desk.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mZlYUHig60Pma-uqNjCbNKuV2dhIMXfaW7k6zUxZ19g_1776956082
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 9:08 AM, Andy Shevchenko wrote:
> On Tue, Apr 21, 2026 at 09:18:44PM -0700, Jakub Kicinski wrote:
>> Remove the ATM protocol modules and PCI/SBUS ATM device drivers
>> that are no longer in active use.
>>
>> The ATM core protocol stack, PPPoATM, BR2684, and USB DSL modem
>> drivers (drivers/usb/atm/) are retained in-tree to maintain PPP
>> over ATM (PPPoA) and PPPoE-over-BR2684 support for DSL connections.
>>
>> Removed ATM protocol modules:
>>  - net/atm/clip.c - Classical IP over ATM (RFC 2225)
>>  - net/atm/lec.c - LAN Emulation Client (LANE)
>>  - net/atm/mpc.c, mpoa_caches.c, mpoa_proc.c - Multi-Protocol Over ATM
>>
>> Removed PCI/SBUS ATM device drivers (drivers/atm/):
>>  - adummy, atmtcp - software/testing ATM devices
>>  - eni - Efficient Networks ENI155P (OC-3, ~1995)
>>  - fore200e - FORE Systems 200E PCI/SBUS (OC-3, ~1999)
>>  - he - ForeRunner HE (OC-3/OC-12, ~2000)
>>  - idt77105 - IDT 77105 25 Mbps ATM PHY
>>  - idt77252 - IDT 77252 NICStAR II (OC-3, ~2000)
>>  - iphase - Interphase ATM PCI (OC-3/DS3/E3)
>>  - lanai - Efficient Networks Speedstream 3010
>>  - nicstar - IDT 77201 NICStAR (155/25 Mbps, ~1999)
>>  - solos-pci - Traverse Technologies ADSL2+ PCI
>>  - suni - PMC S/UNI SONET PHY library
>>
>> Also clean up references in:
>>  - net/bridge/ - remove ATM LANE hook (br_fdb_test_addr_hook,
>>    br_fdb_test_addr)
>>  - net/core/dev.c - remove br_fdb_test_addr_hook export
>>  - defconfig files - remove ATM driver config options
>>
>> The removed code is moved to an out-of-tree module package (mod-orphan).
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>> v2:
>>  - keep BR2684
>>  - correct the claim that Traverse Technologies is defunct,
>>    I'm still deleting the solos driver, chances are nobody uses it.
>>    Easy enough to revert back in since core is still around.
>>    The guiding principle is to keep USB modems and delete
>>    the rest as USB ADSL2+ CPEs were most popular historically.

A possible alternative would be moving the solos driver (and others
similarly old, possibly not used anymore drivers into the staging dir
(and let them be removed after some reasonable grace period).

/P

