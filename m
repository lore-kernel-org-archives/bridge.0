Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333190;
	b=G5xP3qPRpjGvjBvicVP6sWQSAYmLdKR5ZznVR4rcuMlZ/NMfkGnqUALom6mMnLHSb8BI
	 8qXxNDrJDtbj6tMjnZ8v3iqRwPQi1H3Tt3Bh/AhjdG3KA0ltpm/IcDBoZwm5AQhtC9J4s
	 HktHsHvYKDe90jt6qUNvnXEIhva3Askk3t9hscBHWwibMRsBzNWo+nH0hrJmEZBmV0mKM
	 SdSzBIj26NLJmsTjqnen9f8+l17wWYiihIUcTjoD3RNMMI75pGH+weUcMt6Df9S/Wbj5S
	 qB98oInOpFlWR+GtShVCaMFiqE+d1wa9d2lY9GCAeehS/21s6AruwoFvqFVAWoyszrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=uWhG69hUkv8+lJDJp2Q5DGOfAlOtWL0/OT+J3s73WV0=;
	b=W6dV3u72H7GyleoOPhsxWqhL64mPXq5F8CrLWGN0/QFKFbCi0AuSR85YXqgyLSRjw4gV
	 bfx0P2tdXPew3rX+s2q/5xbNZSIYgKO5nJeEqyKWKn2isggccdEvaH+PlRmxWK9MRIREk
	 Gx0Z/JD1nQIgiEYanFK9peYZkPxVRpoDel11bTe7RmO8QjBiPqllOs2CPsuAG55MRrQP7
	 oKnAyZAjAJucGL+BFYm4r2KzOhpcOh9XTV+mPGKp9rV6GYwdrDe0jZq7ojCqyxOuy9ofL
	 uG9MkNXdQgh8HevJjbgprDxjghafEoB4153wPurRPMnW34zDYUS1DMF4OOc8YB137lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="uSJo/T/0";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A72606A32E
	for <bridge@lists.linux.dev>; Fri, 30 Oct 2026 04:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A72606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uSJo/T/0
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-181516de561so249575c88.1
        for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 21:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793333189; x=1793937989; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uWhG69hUkv8+lJDJp2Q5DGOfAlOtWL0/OT+J3s73WV0=;
        b=uSJo/T/0T65rmwJm9IX+m6uyUf3TACFFXPzMor770/VcnvVUHQato8vTx1ZIZVE/d4
         tA/mQIpd/Bo8UGh4UNbssS9Y8PntqeyrcEZgd3YCMk8ojZAmF8UzUSoJ9UsbOHBIw1Kr
         j+8ZtbFKLkv+bW6WwkWG83jDyt1X1lZodM1ugItC1uVnDShNoTlLzmf6OlyzxAxbYlCZ
         JPtDDmveVTb4KGrm0+Bo1awCdVshao1vF8GazvELq46Y3n4zQg/FmqTq7Mhd7Z8274iD
         TrPEDpIEU2rC0csXGju3CPnfP4OEC7sqRA9AUq8NzRiCbj/SJo9PSJEFwzRJBAznLyRZ
         Av4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333189; x=1793937989;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uWhG69hUkv8+lJDJp2Q5DGOfAlOtWL0/OT+J3s73WV0=;
        b=QLKMLIC5JyizCJPQDvJ6LafRKZ+R43eOrrNOnSTL66lmKEn/sLNvk3lf6HDVX+Lrq7
         +ud3Dd0pyvBEuvQ/uzSL+HIug1ePofAOn9jdfL2W185/j85CF1hgcRpcxb1eLkEVnkmN
         XVJ5yZjpBZ9C5fx1W5E4A7HRGQdr20uwV5pjRBg75dOC0s88xM5I3t908P/n7UOjHvdn
         ZThTdIVZWL07DYUzZAa1t9Ny/HC2OH2UK2CMIy2CPf0UKi9YrTIV79A6ZAQ2pWHkJaxo
         BUKcVt3vHX3RaV4lwk7xPjqGHeZYD/yhWHSPDRieyeoB3s0RjTsua8EXJC8boeMi7TBp
         PfsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcZ0yOOR4tKgu2SpmK8hGenMKMhGixNtw07Q40HgKaBGvtjEjVnjYAfI+MFRp9bd11lyIe9u0=@lists.linux.dev
X-Gm-Message-State: AFq9FYJmbCt4QFWG/HZYL1XHml26pvBf2FJqSNz+qXy+dRJwKx8t9hgo
	Hc+n1M8Jvtjvcjx4hFMa5r5+kxGyTHjACAOv2xMkCMl/EF9BPls+XYPTzzxyUjuU
X-Gm-Gg: AYBFou0nwVoAWi+b+pIhCFTbDHSAd67jAytnIuFGnn5rm2U2A8NMU4LKyD9HpRj5G0+
	DUL1PaqM0NTpXSdzeC/2MxVCEy+1p+PuXiFzbKBLsb0hAafLK9fi78YKL/DOAS8UeME0hVH043y
	vSqPYYIOkehVQcQJyUZI3F6PeDSh2IUV3k8ILsfBSYGo8HhKNp1TGvw2y9LmXwwCSj+/qYlsAHy
	zfu0oCsRSdNDizrI/t8mIolctw8Zq97LupN6A5tObpzING9DLpzh7IkMuy9paIPzpkAIphdzJ2s
	8VczVYT6zUH2xpqNFCwViiQkfH+lnN6DIjZCS/E9Z4MAZaSttHW9DrHKvnPSnR0COeMd+cQ7I3G
	9Qgo1QRQYEuMeTAzXZ/9oodWUOdMdBndBAQCycdrgctuCMzhbjzPkUPiPUjXf7A7y9nCoTViBe/
	RTIKtKWp3HrP1xWO7pfgL0nqGUHDkCm/xlX93gndm2o9b5zw4aF68OA7KDrRDSuaQjV1k2l3nku
	N6sh5ZH0JsgGPAPN7F3ocIAUHtWEihC0JTg4y7PQ1nOegXIOGIfYmj+xvuIljKmlKtBSYrpilyD
	qzHImiuT3+btx+riIeZCNrfs3zCrSlwsSkPTDmoBNT94iP0yofR7zp7k2msj4iLmNnOfcHUoJ+o
	=
X-Received: by 2002:a05:7022:ec2:b0:19f:cc98:f603 with SMTP id a92af1059eb24-1a9420e4a4emr7161417c88.1.1793333189327;
        Thu, 29 Oct 2026 21:06:29 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm3410984eec.11.2026.10.29.21.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:06:28 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: flush FDB again after unregistering the
 RX handler
Date: Thu, 29 Oct 2026 21:06:18 -0700
Message-ID: <179333317813.2102764.11838518621146184655@gmail.com>
In-Reply-To: <20261025081919.GA53797@shredder>
References: <179268538303.70821.8213834342995341232@gmail.com>
 <20261025081919.GA53797@shredder>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi Ido,

I'm sorry for not getting back to you on this patch sooner — I only found
your reply when I went through my spam folder.

I tested your suggestion.  I applied exactly the reorder from [1] (move
br_mrp_port_del() and br_cfm_port_del() before br_stp_disable_port()),
and ran the same reproducer: a diagnostic switchdev endpoint keeps
del_nbp() between br_fdb_delete_by_port() and
netdev_rx_handler_unregister() for 1.5 s while a flood keeps sending
frames; the test then waits for destroy_nbp_rcu() and sends frames to the
learned MACs.

On an unpatched v7.3 KASAN kernel the port stays in BR_STATE_FORWARDING,
new entries with dst == the dying port are learned in that window, and
the trigger reports:

  BUG: KASAN: slab-use-after-free in br_forward+0x55/0x3c0
  Read of size 8 at addr ffff8880200bf038 by task mrp-poc/9420
  ...
    br_forward
    br_handle_frame_finish
    br_handle_frame

With the reorder the same window is still exercised in all six cycles
(the 1.5 s hold is reached every time), the port is disabled before the
synchronize_net() and the FDB flush, and there is no KASAN report.  A
normal (non-MRP) bridge regression (two veth pairs in separate netns,
ping, FDB learning, port detach and bridge deletion) also passes.

So the reorder is sufficient and the second flush is not needed.  I have
prepared a v2 implementing it and will send it as a separate patch.

Thanks,
Cheng Yongkang
