Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206302;
	b=DIZ+LF2TQ4/GsTciVlsEFB7OiOx05+TT1NicwLXIGcq/oCBUyOP2De/sbJFEbpjcfbXa
	 JaK0KQwOirIowwbf+mDNOdyFaNQwL8gveCK29c3vRav2wuKea6AtoPoQF8mwTJNTv8oE1
	 LL19kiowNS8w5/JKT5NLJbYCakw7csHG0WzB/2il1KMCppBvy6p/e/SuWgL5+MSL4E2KD
	 SlGsuF6LwMVkoZ8Dzg74GT3XkluONhy0xlc6byftKG+AmyqYLnXQ3XgKP0/wSegK5UAy2
	 G6Koi3HHVhh43NC47YDS1NCG5iWtYd2sNy/OYSR3AufI1sJGvtbaMfOaJRcPYpByjUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206302;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=GxSBgBRj6RlRgwj5Vbp2CHWHsvzFLRSYYFbbHUEstQ3aFT4kXEPxiytmABn8XiWgUbrc
	 OLSwhom+PsGc1Lc3oVsSk7R+haL8J2uuawzm+uinlJYzyxtwpdjyKSkUMORlB0T0Ovb3w
	 uW0eMzgFyBRw69jK90GMFIjnBrkDMDIQ67oNPIAqUtgRBHf8xzLACMhS7OYmZRGtjaceN
	 L9MZ3UdM7KjO2xpYBaul2Yh7AYomgoVQ3Pyl8AD9g/nOkl29/b+BmCKVPMeMgqnUT9YSQ
	 XQ90ws9zwrfZ3yWwOtxvXADJBpUK49J9yezOfrmfMmD7iFKKisYH659iFaxvsUlE4CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYUDXnXn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D9606A31C;
	Wed, 28 Oct 2026 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYUDXnXn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C08F1F01825;
	Wed, 28 Oct 2026 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793206301;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IYUDXnXn811YSJ04LkVqxGdLBsih2ExNheFomRihXxc1hkZ/j+vndsq7uY1KzAk8n
	 3eQHFRdoltyQAPY3Y+1ZWmMWNF4IER4A0FVNMqRoiGxaSOSDpRGihyfJ/MaARTKh7z
	 /GpS1FkgN+Mob9TnP77Yh4YbZ3U5b99gDfW5DtIv10jFJPRBf254BdipOywEV5egF9
	 eC/tpdga6WfiJkwA9R5zPxXTAIxcZcSly0OoFLP4CSyvLyrunos/8yELk0om5hUSZg
	 92ep9KUvptA7mFZTCtSRS6E9LylBQafjhlaxfqGcep2KQPfwlRcXwLgqwyZX2HPXPr
	 IOj1111X9xsBw==
From: netdev-bot+sinfo@kernel.org
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2 0/2] bridge: cfm: correct CC receive monitoring transitions
Date: Wed, 28 Oct 2026 16:51:40 +0000
Message-ID: <179320630061.3327.303082876376528510@kernel.org>
In-Reply-To: <20261028164730.253238-1-pocj8ur4in@gmail.com>
References: <20261028164730.253238-1-pocj8ur4in@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
