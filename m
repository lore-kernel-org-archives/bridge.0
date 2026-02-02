Received: from a8-237.smtp-out.amazonses.com (a8-237.smtp-out.amazonses.com [54.240.8.237])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB032C17A1
	for <bridge@lists.linux.dev>; Mon,  2 Feb 2026 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058986; cv=none; b=m5likWw4VpSYd9o+4zsyxKT8KiDbx7NVCHS4TWawURw4PBZSmO7t/oAXr1lHhf1Jt2UZiaSzRl4tYtESLwAlwiKBfMed+jX6zE+njf2ToyWuffW67XWVQcAn2Do2tBa/HDJYVGqQscKp7SE6c1eZt+iKy36hF5itLUpndvIx/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058986; c=relaxed/simple;
	bh=frHfKa0JZKFWPCG2h85KlUf1gIaXEk13F3YDDS917Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYC9+g/hGsSjDIT7TwyFovl8pzINIpkimAO8HkWlXowEacUlriH7+BdaKdze796zdHUplJDT7dIaz47B50x46RT3kKyYmkZwUxX5b/UFnvy72cDmH7SX9mMXO5BSHL6sbMntug3TezChx3F3M4mtUiWLotKuUxMZrRn0ICyue+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev; spf=pass smtp.mailfrom=mail.corvaglia.dev; dkim=pass (2048-bit key) header.d=corvaglia.dev header.i=@corvaglia.dev header.b=IOvkeqDf; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=dtYzgcwp; arc=none smtp.client-ip=54.240.8.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corvaglia.dev header.i=@corvaglia.dev header.b="IOvkeqDf";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="dtYzgcwp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=bvgar2idfqx6rr2b3v3v2bwbuxumhdxo; d=corvaglia.dev; t=1770058984;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=frHfKa0JZKFWPCG2h85KlUf1gIaXEk13F3YDDS917Bo=;
	b=IOvkeqDf4vjk6YUoVrQzRZ5827Q7/Z3h13p6UgwPOC/l1+nBBn3bGXTrKATODj86
	E825QABFWh1L5sm7NWEKbCRkFO199eLy/WYGM8qohBbt19CZ2RdzCmmnjx1ZNx7e/4z
	/OaNDzcrtsHQdNSiCk4j7F3gvwy8a/S+BkTlgeW2xLwapvR0uTv/x9cWALmPoUZw+Hr
	NwspNcEhdoySDLvOtigL6HJ6NxmZVK7+yrm147p3xXfdyo3p4SyEiEOqXIMTD7isZAL
	HPdFHfBxZkUzKtUJGAZ74rvelbQAFu8atnzHQsfgHiUKDjhqDkrOFj+LSZcTxg7qv0T
	Oyv/vTnzFg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1770058984;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=frHfKa0JZKFWPCG2h85KlUf1gIaXEk13F3YDDS917Bo=;
	b=dtYzgcwpt0RcUv31SJD/8JrnhPb7c+LqwvEvUC8B1WQcbw15NWnMVfMnz+QeOkKQ
	J1m95ZYazIVEdRx1xk0ApYMpcXGLQPsKxLx6mPMV3lN0vxC1tGVpgnh/Hjkdm5wu/rw
	ULOksf4Hc+jDbo0Nbk8730w091ezokBjf8lWEDLE=
From: David Corvaglia <david@corvaglia.dev>
To: idosch@nvidia.com
Cc: bridge@lists.linux.dev, davem@davemloft.net, david@corvaglia.dev, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, razor@blackwall.org
Subject: Re: [PATCH net-next v2] net: bridge: use sysfs_emit instead of sprintf
Date: Mon, 2 Feb 2026 19:03:03 +0000
Message-ID: <0100019c1fbca989-a2726974-1033-4468-bd63-a5c306949e37-000000@email.amazonses.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202174409.GA127339@shredder>
References: <20260202174409.GA127339@shredder>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.us-east-1.Dw79TYOMY2hrNmvZ7e9+qnciE2cwcAniRLo3LdoqSVI=:AmazonSES
X-SES-Outgoing: 2026.02.02-54.240.8.237

Hi Ido,

Will fix the whitespace issue and send v3 soon. Thanks for the review, sorry about that.

Best,
David Corvaglia
