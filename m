Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795879016;
	b=AQxuJh//1/H4B+lszszBJJj4BRr2+8G4g/F0lX1EQc5Sj5z6KuuOxgrtfQES7z+JY0Sj
	 YhzrPtldv7CwHM+JAq1Zdo318UoqdzZQs/i2jGKXVYTgJo8fA1EHGeVzq9nxnmLoR8Bsa
	 EOPvuZMuRNIaZpQYI0OQT8C1jVCfetpBX8rGf8NtgvONWNdmdtyAgwCROmEZCXWx/vc4U
	 Kim/yslfd6XI3adkLwKsader1SZoSVCFVuWNEnmm5LYVH8NgNJNK1j2ojkEbSvR0q2HIR
	 DmJy7YxENvWJRRRAJ4R8krey96YLsxwDU5zhebjzCkR+zMyABwLkZIvz3DjeV2Qt+3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795879016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4h7H8gUxe6ZRZN+7gY06DzLor7C8AIjaJx9A0BPZrIU=;
	b=UXahAzDfVPjFIrsAOn0kHO32GJos2i8DOeGvvIdbw1QtWIeD3TI9xwQHkomIlYaQcxzQ
	 QJxIZnx0O2KSaAT+M9tf/RpPRiGlk7tIyUtNmfiRF7Nk6H3JTNkfYGhPWZh9VUSiqu9qt
	 sSRyPqu9rnOMxODoXkhSWvZqEjWp9Xcnbgvf4A/O6UozaJK5ED6XgUoNP96qr8x8BvAfL
	 syEnI6U9PrQMjJ+lhPXQHobta3YaTP7gJML6Sy4V/LBsuydDB3TDG19T76cXhZh45LIGW
	 sW08a3VUPuAqQvYRXsdCaeVXGYi4OagW+bnvB/SL8QZMbW6Ix4x+LSYanpkdt6V/LYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=aWHwwA90;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3E606A332
	for <bridge@lists.linux.dev>; Sat, 28 Nov 2026 15:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1E3E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=aWHwwA90
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d28f75d62so1469422066b.0
        for <bridge@lists.linux.dev>; Sat, 28 Nov 2026 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795879014; x=1796483814; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4h7H8gUxe6ZRZN+7gY06DzLor7C8AIjaJx9A0BPZrIU=;
        b=aWHwwA909dYvU7BDPkprxHEa1dUxTRgmIBbOudUCvPMM1n42tBBXJxLQxuhTuoT3hB
         LhV+YBoEjwaR7U0LTUKy0cRlAXHVVMDPEKPuzQlQlwmgHSWFH/pXpJZhPn06NGguTyJv
         k6oADA3/VMA2YNq71e4AwfSQU0/A8FsndXDtNP3KO0xXgRb3jozpg9Y9dezfPgcuF6cR
         TDBcTWHxnsU97P61z7tOiuP9Jw9lX2eyLmKBQLUNW8g3arGPQ3/oLbhkxepAHsvo5Cjs
         lQUHUKF7StK4OeW5ootwumGmYPyuIJC/FENPqyqv7Ky26ZkyhY5wqnVQaPa2O8YXD+CN
         c2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795879014; x=1796483814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4h7H8gUxe6ZRZN+7gY06DzLor7C8AIjaJx9A0BPZrIU=;
        b=UlMg8ZAc+zqTe6g3RkvAe7HEsSX0nHjA+DCaAHWX47a0QOnDDiR3zUMmnFmfbVVA5K
         DGzikfJPUuzzvdYmHmNqLpXmpjSA9VQcUI/DRlq5CwPWOnNJbzjCOZuYuKtLqXlXkocy
         eymzB1tvuYynwvpsbQkCA4YeyZbRtt8GRNNVWV9ov9c3s5dUuc5jqd+5aOPKmz/H0OM+
         ElH2QI6OUWcALYiQ3fq7ElS7fRYzAh+yfwr3TRz+hhystkJbMRZWUHlPfYwvNm4TkEjV
         nkhpBwOAOL7AkN2pxV5Fz1JOCGLKPHDAE62bfiDPTYsAfbg7JumO0Q3jSKFn0Ycy5v8q
         o3mQ==
X-Forwarded-Encrypted: i=1; AL+hErF7sdW7yCqf51TFFE22wzFOhS4AEQ4/nZt4ipNetAhvRfFHvgEv3LB1/oq2a3ULr2bd1tV9T48=@lists.linux.dev
X-Gm-Message-State: APuU4Z8N7lbW+dznwmYvd+A0yZ3rdmmh16LqvqiJ3sSHVQyYL4AkltJZ
	i+WpJG4aUIFzIzw9uXvnFYilAyz+jyzo8EQTuzNsHUVlRxh6pmrXlGXwmQgJgLyVHw==
X-Gm-Gg: AZFdTZdtLyYl58tui5+8q8ormV2yin9hS6Bfm3GAu56j2emacgNelXPauneemy9p/sO
	cfpeDjmaTDwE+CKF4F9JHdy94ObM2qOncOcuU4FZjXTODMwHZ4OpJXRBOmSsypMwmNfaVaYu6j8
	90QCVKNXjUieCLJ/sxPeO0JKZnj/F6qTOs6TKq2jtDlXAiUcfTVxpefeMpukVLvb76bEKSGAU05
	Iob25vUR+QDR3ayNWANcBkstVgJdyNPnDhiqJjMCbSkYoxNWUVy7SZbi4W8JXumfAht8mDhDIOo
	m3+52OypaZcvW3LUiEboPow8PHzTTwJWqunkV/Jys/RICkj5fmUQ0463iP6HPwDG+VFTSB12U1z
	YB5l+35P36ZT9+hnV9+cUWPJp59fKvwtKJm/twt182bJaYCnyIX3MxovC2GNh4q842bxjy++cmy
	KlMtBOQQ/HJffjBZOBQMADZw040205mar48I87YrLt/d/93e97P76ln7WaaSRzzXfAs3hW39Nsg
	1Z2/xMx+6hylAg8bV4qvz18SugA4xyCoE6fexB/Bu3YiZka0YW1UwOlB85HGCUozs3NhIVIUZ+i
	+cZ+4NeltC4EDbvaj0+FhwavScLJE4MQ4Rdrdtg4tfb2bfovuFdRxy/Aof+huP4/27PMpbj+GR2
	H3O4ZWfOt9j4+kUIQ4ORRyjjRXyeEE02tp4g8miioYgZLqFnsjpG5yYzPqDtvt5w5JqgOFD3hqL
	9SxQxzqP7pYaifj0/VH+4iyHfIhKczOXLuU928JK2ANA4e5bJtRW0UEOPCTxSanuavB9MW2u/aa
	bc3ujzsrgaV0uzgUpRt1AEJlsl6uHh73ZI9NSnowAv7W7EQCbEETP4Q6e/5ONtYuTRJLdPDmZT+
	7V36kjX12mhsgg==
X-Received: by 2002:a17:907:1184:b0:c46:8b87:c1f4 with SMTP id a640c23a62f3a-c513ab08b3bmr1497922866b.20.1795879014368;
        Sat, 28 Nov 2026 07:16:54 -0800 (PST)
Received: from Desktop.tail070c67.ts.net ([185.152.145.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae66674sm981318866b.15.2026.11.28.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 07:16:53 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev-bot+sashiko@kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	razor@blackwall.org,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH net-next] net: dsa: report a deleted FDB entry as no longer offloaded
Date: Sat, 28 Nov 2026 16:16:42 +0100
Message-ID: <20261128151642.3100278-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179545589967.3135.15910184280641420924@kernel.org>
References: <20261122174434.975426-1-julius@bairaktaris.de> <179545589967.3135.15910184280641420924@kernel.org>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Nov 2026 17:44:59 +0000, netdev-bot+sashiko@kernel.org wrote:
> Can this report reach a different bridge than the one the deletion was
> for?

Yes. br_switchdev_event() looks up the port of orig_dev when the work
runs, and br_fdb_offloaded_set() matches only addr and vid, so a late
false report can clear the flag of an entry in another bridge, or of an
entry that another driver offloads after a roam. DSA cannot see either
case. Please drop this patch.

pw-bot: cr

Julius
