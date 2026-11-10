Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794273773;
	b=t42yQK929mR88LMvw5ExaejrSnyN6n/yJ/M+hW5wv88LlMaUDtoG98YdZdjZcQ55CJBT
	 fpkAvECpU1lDH6XnT27QvxSMdmatvOABMENELdeJxFCf4ch/3/jzaB8Fek3d9NMTaYn9b
	 Vg3H/UNPWphlAjGNXl+enKt/WsA5SOLolD5DjghxSRur2xwRgQPwy82qLLzKyFCTTLUXu
	 1A2FUr24hPsD/iD7CKF+WB/pBoRMZRiptSUPMZy3EX1W6Ai6T+XdAW8rmXI/toUD+018W
	 dY8Bcx0BDZ735SNTtDtyhHIZU4jWzxkw3OuIHCEWVIUr0ZLTYr4YIfUA52/HjiDcOzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273773;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=rlHy0y49llRfh6fikqJG2D8BwX2hQJXYBow41oy5Q2M=;
	b=Q+fOgzL+QIlx/TWWE5z34njF9D6KQ7ryISWIGK3a/4q8WdDk2c0BPC7pDUwLM5pbgt49
	 cdjTLP1/unh5poHOGsrTpFoUlmzl/HTPqv8WHjJ7Rl4k0Z109faxTXv/G0FwwneQbguHT
	 sWSSudQx26tmC5p8DOzoVBPpOBLbYAq9snSPsQJJ9kHwwrBGfcxHdYW/ipFiTE4DHOb79
	 wA9CZ95FZ3S4+JrRoCb8+dAHa26FcI29aa4HnPeBSIIB2xbL6juVLBowG3VpilqsA+mks
	 fqLR8TbxDN9GS1ZdEJtLLkOisbB/TlqY9iGB4rwaMcbzcdlSZ6H3zlBArueOCuEk49A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=Ixuoifn6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.14
Received: from sender6-op-o14.zoho.com (sender6-op-o14.zoho.com [165.173.180.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25860A380A
	for <bridge@lists.linux.dev>; Tue, 10 Nov 2026 01:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B25860A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=Ixuoifn6
ARC-Seal: i=1; a=rsa-sha256; t=1794273772; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iDGzEyufbjEQX95PG5nPvHvs5AMuZmtGu4mw0NdgDlk73mtUNJJs4DPlPf68OY3XdeWa0qRpXgjVbHL4zg93Tw0nmCaFg6+dj7b9pCzMd7lukcQIgHnrk2AJ3U6yPIv7MNC/Cn8k2K8gHzdQSHkw6sXnzYRxC7sMvxrUTZN7pds=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794273772; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rlHy0y49llRfh6fikqJG2D8BwX2hQJXYBow41oy5Q2M=; 
	b=kYEso761Ka2+hBJ4bPYq+9XhWLsYgyQm51BIJLLeJol7wnqLzfe270i4Z4UOyilHOuttVrs9tBbMMkB5gwSnTniL1lzdHo2PxtFxGAipnd1+M5rKiDj1WFlXLlsvZDTe8v2CmHAvv++CV9zDMYZZKBycaR+FTJm2FdSgaE83K6E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=Ixuoifn6KXRdy+uBBsMQal6LYGKErlO6lUAzmKWQdYzDzYEtpzdithJnHXn6+6/3fqlMU6F73bvJ4NLsa9QUdAJDaryvd0zHPCZIauUU7lRH2xuEbk8N/Yv1drV/X0noUpGjBB0z24bFZyssv3/GMBFFfS7vP/ghHNIUFlCvcks=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=rlHy0y49llRfh6fikqJG2D8BwX2hQJXYBow41oy5Q2M=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794273770551191.82694000317304;
	Mon, 9 Nov 2026 17:22:50 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	syzbot+a8ba738fe2db6b4bb27f@syzkaller.appspotmail.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH nf-next 0/2] netfilter: bridge: refragment packets with a vlan tag moved by the bridge
Date: Mon,  9 Nov 2026 17:22:44 -0800
Message-ID: <20261110012244.69518-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <avJuijtALFuuk7yd@chamomile>
References: <avJuijtALFuuk7yd@chamomile>
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
X-ZohoMailClient: External

On Tue, Nov 10, 2026 at 02:08:26AM +0100, Pablo Neira Ayuso wrote:
> But does it make sense what syzbot is trying in real life?

Here is a sample scenario: a customer sends large fragmented UDP packets
into a bridge doing QinQ with stateful bridge rules. It takes that
combination so it is rare.
