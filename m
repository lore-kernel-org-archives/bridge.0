Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907041AAE0B
	for <bridge@lists.linux.dev>; Wed,  4 Dec 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307152; cv=none; b=up4E5krYQIrP+bzwSLJOomWSacz0zftoDK57w0lTjYdtnqW+yQp3J/sjGEWUjAKRo2hChUmlvXAHi6BJBofIHotG8fiddYFNfEqoxa3WgB4+WaU3aGn/5eu+YS5eEQ18VIn/qY7lO/gBQ21Kwkuw4Bpz56fwRK2wIENEtxyzYJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307152; c=relaxed/simple;
	bh=bDcBWgVILMB12NHWB4fcs1W4araBsBKWumSB2kQnUP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1LsZEdk6xvHxJB9nuAdo727z2hpZCfFNsPp55J1o9YjMsZ9gLhm8TihT75JyZgDDxSiF7RZHGuLzL208rfXOzDUQsdShSAvMdbG1t+FlmEXMcYqvHhRo73K3dVWCprM/0d23aZHyogdZBv/kEtEd1kZD+UERH5Rmh1jKDuc4eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=N0UuxX4W; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="N0UuxX4W"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ef81222be7so41786237b3.3
        for <bridge@lists.linux.dev>; Wed, 04 Dec 2024 02:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733307149; x=1733911949; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r8yJtp0VtRWCyGUDMUPSKyYrOKeXIERy5/6YkYGZGIw=;
        b=N0UuxX4WXrgIqXycLAlVhNf1RTqtHBe8s5nXwIgDKjgAB95r1XKbY9oJlteLaCkWMw
         iS0GuCLn6BKTKFwhPulS9srDNRilx/aT0Bb8cXOmA5Pn3h8uystQdPjDkiqzQl6DZVVG
         hCxrmKHW+sRhUVImEtbRU4P2jVw3zhBgbKFyp5ji8zj8UDnxKj1FLOKnjz5u75oVAVTI
         z2nWdSbWJIEbezda2a52kFlQEAumyh2M+HhzTc62/ZUfXzd3ORCCTCxt/XxY70vs/TEH
         ktNjiqeTgD5tKBUJCQ9hPTAO0f8wt6LebM8K4QbATZe/ILu/n8ZT89BUZZUshYWM+/51
         YyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733307149; x=1733911949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8yJtp0VtRWCyGUDMUPSKyYrOKeXIERy5/6YkYGZGIw=;
        b=qMaIFmS89+teFpjqzBNqmejwfLquu+yfPUO/k5fVPkbITobfNYyH2UsNEXfG7kLmaY
         emKyNbGiVjChHstSVFWgN8b2UuZ62bPTZAO47Tmi5p1I89TwcC2PjAQIzDONmZfoW/rP
         eTa4mU3DMHi2cZQLmEedZHbUlewANBP2zGcLZ9WI+s8+ssgPQrtSZPzXf2ilOzy5skFa
         35OZQnFDJPITUpVz4iOxnXoUTGoyJ21Ap4yeOpxM57Qp4sMkqYoZKb5wMlmLaaC7pmfN
         dvqqX6jQLVZQMbOomMeUoUktBvDRwB28N4wba8XFzg5eUV/ZoI1rxvl64KYU3Vz5oO5k
         nPaw==
X-Forwarded-Encrypted: i=1; AJvYcCUzwEG3mBxad62vUpG97Uh1AwjXNB427qJxwytWaq+2Vt2PKONhNxpFKlIrJJtbp9XMLd8pD/I=@lists.linux.dev
X-Gm-Message-State: AOJu0YxEvsIgtffSH1l0OAaZ3yLKIN2Fiav4eTeLKSpszQY9CxiWD7J7
	n5UZJYssyflU0NOKPjGT4E2+NoGqX1DgkT/WpmaRqhnF1nDzcVzsMU/ciK0plP+f579xlIdDB8x
	0y6KRMbYWGS27ItOFwE2KEKxP5FaEfQ4Hhq71DQ==
X-Gm-Gg: ASbGncv/eyRHSnJUHcTbftppxIRSYt/3YJ3MrsH5bdOhp4YuLGNQLhwCtAdp77aPATd
	7qWjEGTvLODVnxXy2j8XCBcGy6qfKGPc=
X-Google-Smtp-Source: AGHT+IFiZwav0lkXcdEoC0k0swq2tYz4RZsKxcJnENpHGhhnbUCXatljeleEVM5PesTsKopimNNDdHD+hwBm2MoI2HY=
X-Received: by 2002:a05:690c:46c7:b0:6ef:69b2:eac with SMTP id
 00721157ae682-6eface0164dmr68389077b3.4.1733307149315; Wed, 04 Dec 2024
 02:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
 <Z0s3pDGGE0zXq0UE@penguin> <CAA8ajJmn-jWTweDMO48y7Dtk3XPEhnH0QbFj5J5RH4KgXog4ZQ@mail.gmail.com>
 <20241202100635.hkowskequgsrqqkf@skbuf> <CAA8ajJkPzpGRXO6tX5CkgX7DjGwR6bPyT4AXjZ0z8kXBk8Vr_g@mail.gmail.com>
 <20241204084817.g7tort3v3gwdzeic@skbuf>
In-Reply-To: <20241204084817.g7tort3v3gwdzeic@skbuf>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Wed, 4 Dec 2024 02:12:18 -0800
Message-ID: <CAA8ajJnRPB=KRcDpQiAJww3Apv6ZGqWaAg5stSjOE99BOmkCjg@mail.gmail.com>
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for Q-in-Q
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, 
	Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Roopa Prabhu <roopa@nvidia.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> I didn't say "tagged". I just said "not PVID". There are 2 independent
> bridge VLAN attributes: "pvid" and [egress-]"untagged". I am suggesting
> that packets in VID 3, 4, 5 all exit the 802.1ad bridge untagged, but
> every bridge port has a unique PVID from this range.
>
> bridge vlan add dev port1 vid 3 pvid untagged
> bridge vlan add dev port1 vid 4 untagged
> bridge vlan add dev port1 vid 5 untagged
>
> bridge vlan add dev port1 vid 3 untagged
> bridge vlan add dev port1 vid 4 pvid untagged
> bridge vlan add dev port1 vid 5 untagged
>
> bridge vlan add dev port1 vid 3 untagged
> bridge vlan add dev port1 vid 4 untagged
> bridge vlan add dev port1 vid 5 pvid untagged

Thanks for the clarification. I think you meant to have the second
set of three commands affect port2 and the third set of three
commands affect port3. Please let me know if I'm wrong
about this.

I gave this a try:

root@OpenWrt:~# bridge vlan show
port              vlan-id
lan1              3 PVID Egress Untagged
                  4 Egress Untagged
                  5 Egress Untagged
lan2              3 Egress Untagged
                  4 PVID Egress Untagged
                  5 Egress Untagged
lan3              3 Egress Untagged
                  4 Egress Untagged
                  5 PVID Egress Untagged
root@OpenWrt:~# bridge fdb show dynamic
f4:a4:54:80:93:2f dev lan1 vlan 3 master br-lan
e0:3f:49:47:9a:38 dev lan2 vlan 4 master br-lan
f4:a4:54:81:7a:90 dev lan3 vlan 5 master br-lan

Like you said, this has a FDB per port. But I think
I need to have a FDB per inner/outer VLAN combination.

Connectiving works as expected in the above example,
but only because of unknown-unicast flood, which of course,
is suboptimal. The switch is acting like a hub.

For example, ever time the host behind lan1 sends a frame
to the host behind lan2, the bridge is not able to find an FDB
entry for the VID corresponding to PVID of lan1 and the MAC
of the host behind lan2. The only FDB entry for the MAC
corresponding to the host behind lan2 is associated with
the VID corresponding to the PVID of lan2 (which is a
different VID than what the packet arrived on).
Hence, there is constant unicast flood.

I also don't think that this solves the issue for
https://docs.google.com/drawings/d/1FybJP3UyCPxVQRGxAqGztO4Qc5mgXclV4m-QEyfUFQ8
. If you like, I'm happy to explain why. But before I do, I want to
make sure we are on the same page before going further.

Thanks,

Andy
