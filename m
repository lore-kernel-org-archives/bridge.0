Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D758405D
	for <bridge@lists.linux.dev>; Tue, 23 Apr 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874355; cv=none; b=A/oQv04ltyMRozzncOdjxafQHpi1kz9q/afSfQg+h6F8C0ASZiKCsw62IGKYYi5OmFD9h+ZaxTWSW3fLd1lAtMD1PI/ZBHpkP6HlHO104RUH9o8SzJyOcrDdCCasMyOYtseeHAWhpXjzIc635rrUyGKZ2H3jcs5w7s2iuT1NQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874355; c=relaxed/simple;
	bh=jGvAPhh5VW4fYO/D1OLd4bVzXz1IC7v3zJgq8hBP5Lk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=AcpSVb/kJ+a35TbLLG9drWxXRKaQLFE/G3yfSeQm35+kfo1NCRaBv1ZysRGv950Z+4CphABLaOA+gyR4/M1ixTds6ATe//UGRsqoQMH6Z+na/cFI4K2bXTTLJ2kcmwU7qPDFRuoxdvAeiQacYhvYAer+pSuOBljpnPKeQosAqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Qr0iAbvN; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Qr0iAbvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713874338; bh=jGvAPhh5VW4fYO/D1OLd4bVzXz1IC7v3zJgq8hBP5Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qr0iAbvNWSUrkL/gIjzw+4bSjYhbEd9slyHUe09jp3xQI06Ml5zFRGRSIjO6p+x/A
	 1qmPj5CWxzoqgJAYiatPmq+x1jPFEfedXtUgIzbwyPtlg2DGTur4hr6KruDOxeLzaD
	 BD47ZlZ1EtgjuqvauM5Mb8aYMY4n8wVlxJnbxAHM=
Received: from localhost.localdomain ([58.213.8.145])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id EB2B9A45; Tue, 23 Apr 2024 19:58:50 +0800
X-QQ-mid: xmsmtpt1713873530te3l2kvca
Message-ID: <tencent_5C4968C62CB4BF868761113A754124143108@qq.com>
X-QQ-XMAILINFO: NVviswOLIctoag8HirS4vhs5DaIAsMSDiT63tBsS7GQfqirzHH9nDuk9t5shdC
	 07bq+ZNHZ0tyP5Mp9aURyqwPltvbH7mClpV/r9wD4kik2mh9odCO/1N9/tyEI9WPL9InI+P0pjZG
	 2Hjne0JrrMrT2PeroFvelrJW5uJTRK5GvxTgQ0Mr8KSRfaS5JX1P5YgP2v2Yx3g4k0NF7QDKe/4c
	 OCVQetDfqY7O6B8isNpJWdYSh2wMLoGIWpOXmxeel5PnqQeDdxECBE419vl3Bb3R32CoBKGdXiZe
	 zUtn9zgE6r2QLMY3UKhCVQU9sHMZo3YCvkPBuh3LcSb+7AATOO5xAm6tCnT6VxmDSaZA1d6F78hu
	 JMPwKbtSwEkSi1ny44f2ikSC3iUxnHINYGy5a0KtZoBjJSI2JWqI0mum+XqcuB9qgW+FXBlE+y+5
	 RQ6SkMEhmNMEx+BONNHVd4c+lWbwlsxIZhA35AsKYF1IfbNhBlkp+uWQA0KK9TvefUVJnn81KuX3
	 ysrRq7db7iH5pjJRG9hDy2dVY5rucdX/Y/X5JuZ7xGSqjQ142yPJNzBr4sitGXuMFvpJmIKFEBVM
	 poN3QtIonhgMjBbiJBRK63eWs568BMm8S6lXi9jzD7GzibcpfPMCg8jCh3XB3SbNLCkMBuZOf+mH
	 iLB7K4tcUVW9rEFrS6wJorLMepePQLki3JM5Hvp2uD1Ud5pi8hBRWejiXmf00FRmWB2Nq7NPIH8g
	 6mxxAN6RSqkjPiVma71l1XgUkz5EmcnW5RHdhGq/OciwPWQE8JfVxg2ERSlzJnIz92Zyqc5Wj6hp
	 qdJSMuUx5Z973Z57zPCBIVQyZFNhDLKfR6mxfNNCzKlSNh+8rY+xwL+18xYTdezs1SUk3+F42aIC
	 6tDUIzjyBGaE44bO0xs6ZEzbKAcm4+kH8p4Y2JCe/gbgPTm3usg/HLSHF9AybynMchjgkZrc+3Ez
	 WUZo/W1vq69RBAayxxcNSIXVPFq6FiKNerZnLjOrS5/EMaZ2FXHHJ4WXdUAVYr6Xl4o8fPb1Q/Tn
	 eZaMBZ8g==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: linke li <lilinke99@qq.com>
To: razor@blackwall.org
Cc: bridge@lists.linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	roopa@nvidia.com,
	xujianhao01@gmail.com
Subject: Re: [PATCH] net: bridge: remove redundant check of f->dst
Date: Tue, 23 Apr 2024 19:58:45 +0800
X-OQ-MSGID: <20240423115845.78992-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <b1fccc7c-3c9f-45e0-979f-f83dfc788613@blackwall.org>
References: <b1fccc7c-3c9f-45e0-979f-f83dfc788613@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for your advice! Should I submit another patch with subject
"[PATCH net-next] net: bridge: remove redundant check of f->dst" or
"[PATCH net-next v2] net: bridge: remove redundant check of f->dst"?

