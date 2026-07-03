Received: from mail-m3292.qiye.163.com (mail-m3292.qiye.163.com [220.197.32.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB24433E7F
	for <bridge@lists.linux.dev>; Fri,  3 Jul 2026 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065222; cv=none; b=B1fNSb69E7uBsUDqHd7IVJzd6M2hm93cww4Zjf5BAPTW51vSV11guKkWfHby1Gy7kGgbm8r+D4komadkGeAuzJen9Wpvml+A2GLi4pQ6l6h+D4jAEwUDzfGgk7Vi5Tpoaw7EUfe0yjifOW0WvO8aPHKvwMYH21OE47GZutmJw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065222; c=relaxed/simple;
	bh=Sh5U0WcktPrQRWf8YbANFZWk8ylWwf5JVctQoftyaZg=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=X1pZGP4BW8lp7B846ob+5KSE8tpF3ePYlfZC3Qm+lF96+ja7LW5isRkeG836pkb3CIiJkS1Q1PIVAp8ghO1ydP1ZggBCfOqfmvCk40dwrUTl5kVvLQFyMCWrvENjP7NqKuFt3pat6LfvxQJHdENkrLKmuVNlBqne5gsXWzjcQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=SG1nvMnb; arc=none smtp.client-ip=220.197.32.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="SG1nvMnb"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AMAAoQBgKr7QFadsWSye64o0.3.1783052662261.Hmail.220255722@seu.edu.cn>
To: Ido Schimmel  <idosch@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bridge <bridge@lists.linux.dev>, netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	"jianhao.xu" <jianhao.xu@seu.edu.cn>
Subject: =?UTF-8?B?UmU6IFF1ZXN0aW9uOiBicmlkZ2U6IGNsYXJpZnkgTVNUIFZMQU4gbGlzdCBSQ1UgdHJhdmVyc2FsIGNvbnRyYWN0?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.64.1
In-Reply-To: <20260628174900.GA400397@shredder>
References: <20260627132539.3701630-1-runyu.xiao@seu.edu.cn> <20260628174900.GA400397@shredder>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [223.112.146.162] ) by ajax-webmail ( [127.0.0.1] ) ; Fri, 3 Jul 2026 12:24:22 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 3 Jul 2026 12:24:22 +0800 (GMT+08:00)
X-HM-Tid: 0a9f2637f1c502f2kunm7fae1f9f1e2d
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTUS6Y2fHkyPT6dc03QDwVaZPGiA09TnwhbhTj
	hLfuFZO94YXwX6xgvkjGVFFRKj5GfO5Omku9T/6BrnRlHEXAyMQMJfF4WZB3hWdN6nWl6ZDg+w6i
	lWlQw5QgNCmEIDvyS+/0arsuJXQe751UCzPTg=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGhlCVksYGBgdQx5KSk5MT1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVU
	pLSEpOT0xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SG1nvMnbdVqOumlMHvWJTqP29odvDs4GTCRb3wjINsxAXsurgkxo5RQzamY8z42iw2Ilqn7757anXkaC+4npOvBR6GqkJPaS41lhw1YKrHy7t87IF8r65VUP3mVJ6ZLk9rBPaOimMaCBZpnvEQqltN/VlCzK3jP1vqmP2MVllbc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Sh5U0WcktPrQRWf8YbANFZWk8ylWwf5JVctQoftyaZg=;
	h=date:mime-version:subject:message-id:from;

SGkgSWRvLAoKT24gU3VuLCAyOCBKdW4gMjAyNiAyMDo0OTowMCArMDMwMCwgSWRvIFNjaGltbWVs
IHdyb3RlOgomZ3Q7IEkgZG9uJ3QgdGhpbmsgYW55dGhpbmcgbmVlZHMgdG8gY2hhbmdlLiBBRkFJ
Q1QsIGJyX21zdF9pbmZvX3NpemUoKSBpcwomZ3Q7IG9ubHkgcmVhY2hhYmxlIHZpYSB0aGUgZ2V0
X2xpbmtfYWZfc2l6ZSgpIGNhbGxiYWNrIGFuZAomZ3Q7IHJ0bmxfbGlua19nZXRfYWZfc2l6ZSgp
IGFsd2F5cyBpbnZva2VzIGl0IGZyb20gYW4gUkNVIHJlYWQtc2lkZSBjcml0aWNhbAomZ3Q7IHNl
Y3Rpb24uCiZndDsKJmd0OyBEaWQgeW91IHNlZSBhIHNwbGF0IHdpdGggQ09ORklHX1BST1ZFX1JD
VV9MSVNUPwpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLgoKTm8sIEkgZGlkIG5vdCBzZWUg
YW4gaW4ta2VybmVsIHNwbGF0IGZyb20gdGhlIGFjdHVhbCBydG5ldGxpbmsgcGF0aC4KVGhlIHdh
cm5pbmcgSSBoYWQgd2FzIGZyb20gdGhlIHJldmlld2VkIG91dC1vZi10cmVlIHJlcHJvZHVjZXIg
dXNlZCBmb3IKb3VyIENPTkZJR19QUk9WRV9SQ1VfTElTVCB0cmlhZ2UsIG5vdCBmcm9tIGEgcmVh
bCBicmlkZ2UgbmV0bGluayBjYWxsCnBhdGguCgpHaXZlbiB5b3VyIGV4cGxhbmF0aW9uIHRoYXQg
cnRubF9saW5rX2dldF9hZl9zaXplKCkgYWxyZWFkeSBpbnZva2VzCnRoaXMgZnJvbSBhbiBSQ1Ug
cmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb24sIEkgd2lsbCB0cmVhdCB0aGlzIGFzIGFuCmludGVu
ZGVkIGNvbnRyYWN0IGFuZCBJIHdpbGwgbm90IHB1cnN1ZSBhIHBhdGNoIGZvciBpdCBiYXNlZCBv
biB0aGUKY3VycmVudCBldmlkZW5jZS4KClRoYW5rcywKUnVueXUKCg==
